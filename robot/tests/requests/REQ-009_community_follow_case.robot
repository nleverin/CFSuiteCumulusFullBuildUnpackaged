*** Settings ***

Resource        ../resources/playwright_common.robot

Suite Setup     Open Test Browser With Video
# Suite Teardown  Delete Records and Close Browser


*** Test Cases ***

Community Follow Case
    [Documentation]
    ...  Test logs into Salesforce, navigates to Hammy Hampster person account,
    ...  clicks "Log in to Experience as User", follows a case from the map,
    ...  and verifies it appears in My followed requests.

    # Query for person account named "Hammy Hampster"
    Log To Console    Querying for Hammy Hampster account...
    @{accounts} =    Salesforce Query    Account    select=Id,Name,PersonContactId    where=Name='Hammy Hampster'    limit=1

    ${account_count} =    Get Length    ${accounts}
    Run Keyword If    ${account_count} == 0    Fail    No account found with name 'Hammy Hampster'.

    ${account_id} =    Set Variable    ${accounts}[0][Id]
    ${person_contact_id} =    Set Variable    ${accounts}[0][PersonContactId]
    Log To Console    Account ID: ${account_id}
    Log To Console    Person Contact ID: ${person_contact_id}

    # Query for the User associated with this contact
    @{users} =    Salesforce Query    User    select=Id,Username,ContactId,AccountId    where=ContactId='${person_contact_id}'    limit=1
    ${user_count} =    Get Length    ${users}
    Run Keyword If    ${user_count} > 0    Log To Console    Found User: ${users}[0][Username]
    Run Keyword If    ${user_count} == 0    Log To Console    WARNING: No User found for this contact

    ${user_id} =    Set Variable    ${users}[0][Id]

    # Unfollow all cases for this user to ensure test can follow a case
    Log To Console    Unfollowing all cases for this user...
    Unfollow All Cases For User    ${user_id}

    # Navigate to the account detail page
    Navigate To Account    ${account_id}
    Take Screenshot

    # Click the dropdown button to reveal menu
    Log To Console    Looking for dropdown menu button...
    ${dropdown_button} =    Set Variable    css=button.slds-button_icon-border-filled
    Wait For Elements State    ${dropdown_button}    visible    timeout=10s
    Click    ${dropdown_button}
    Sleep    2s
    Take Screenshot

    # Click "Log in to Experience as User" menu item
    Log To Console    Looking for Log in to Experience as User option...
    ${login_experience} =    Set Variable    xpath=//lightning-menu-item[@data-target-selection-name='sfdc:StandardButton.Account.LoginToNetworkAsPersonUser']//span[contains(text(), 'Log in to Experience as User')]
    Wait For Elements State    ${login_experience}    visible    timeout=15s
    Click    ${login_experience}

    # Wait for portal page to load
    Sleep    10s
    Take Screenshot

    # Validate we're on the portal home page
    ${current_url} =    Evaluate JavaScript    ${None}    window.location.href
    Log To Console    Current URL: ${current_url}

    # Click "Make a request" tile
    Log To Console    Looking for Make a request tile...
    ${make_request} =    Set Variable    xpath=//a[@href='/s/requests']//div[contains(@class, 'box-title')]//div[text()='Make a request']
    Wait For Elements State    ${make_request}    visible    timeout=15s
    Click    ${make_request}
    Sleep    5s
    Take Screenshot

    # Switch to the map iframe using >>> piercing selector
    Log To Console    Looking for map iframe...
    ${map_iframe} =    Set Variable    iframe[src*='cf_MapRecentCases']
    Wait For Elements State    ${map_iframe}    visible    timeout=15s
    Sleep    5s
    Take Screenshot

    # Wait for map to load
    ${map_container} =    Set Variable    ${map_iframe} >>> div.esri-view-surface
    Wait For Elements State    ${map_container}    visible    timeout=20s
    Sleep    10s
    Take Screenshot

    # Click on map coordinates to find a pin with a Follow button (spiral pattern)
    Log To Console    Clicking on map to find a case with Follow button...
    ${follow_button} =    Set Variable    ${map_iframe} >>> button.followupButton
    ${follow_found} =    Set Variable    False

    ${center_x} =    Set Variable    150
    ${center_y} =    Set Variable    150

    FOR    ${radius}    IN RANGE    0    140    30
        Exit For Loop If    ${follow_found}
        FOR    ${angle}    IN RANGE    0    360    30
            ${angle_rad} =    Evaluate    ${angle} * 3.14159 / 180
            ${x_offset} =    Evaluate    int(${radius} * __import__('math').cos(${angle_rad}))
            ${y_offset} =    Evaluate    int(${radius} * __import__('math').sin(${angle_rad}))
            ${x_coord} =    Evaluate    ${center_x} + ${x_offset}
            ${y_coord} =    Evaluate    ${center_y} + ${y_offset}

            ${skip} =    Evaluate    ${x_coord} < 20 or ${x_coord} > 280 or ${y_coord} < 20 or ${y_coord} > 280
            Continue For Loop If    ${skip}

            Log To Console    Trying coordinates (${x_coord}, ${y_coord})

            ${click_status} =    Run Keyword And Return Status    Click    ${map_container}    position_x=${x_coord}    position_y=${y_coord}
            Continue For Loop If    not ${click_status}
            Sleep    1s

            # Check if Follow button appeared
            ${has_follow} =    Run Keyword And Return Status    Wait For Elements State    ${follow_button}    visible    timeout=2s

            Run Keyword If    ${has_follow}    Log To Console    Found case with Follow button at (${x_coord}, ${y_coord})!
            ${follow_found} =    Set Variable If    ${has_follow}    True    False
            Exit For Loop If    ${follow_found}

            # Close popup if no follow button
            Run Keyword Unless    ${has_follow}    Keyboard Key    press    Escape
            Sleep    0.5s
        END
    END

    Run Keyword Unless    ${follow_found}    Fail    Could not find any case with a Follow button on the map
    Log To Console    Successfully found a case to follow!
    Take Screenshot

    # Extract the case number from the onclick attribute
    ${onclick_attr} =    Get Attribute    ${follow_button}    onclick
    Log To Console    Follow button onclick: ${onclick_attr}

    ${case_numbers} =    Get Regexp Matches    ${onclick_attr}    '(\\d{8})'    1
    ${case_number} =    Set Variable    ${case_numbers}[0]
    Log To Console    Extracted case number: ${case_number}

    # Click the Follow button
    Log To Console    Clicking Follow button for case ${case_number}...
    Click    ${follow_button}
    Sleep    3s
    Take Screenshot

    # Navigate to MY DASHBOARD
    Log To Console    Looking for MY DASHBOARD navigation link...
    ${dashboard_nav} =    Set Variable    xpath=//a[@href='/s/' and contains(@class, 'nav-link')]
    Wait For Elements State    ${dashboard_nav}    visible    timeout=15s
    Click    ${dashboard_nav}
    Sleep    5s
    Take Screenshot

    # Click on "My requests" tile
    ${my_requests_tile} =    Set Variable    xpath=//a[@href='/s/my-requests']
    Wait For Elements State    ${my_requests_tile}    visible    timeout=15s
    Click    ${my_requests_tile}
    Sleep    5s
    Take Screenshot

    # Click on "My followed requests" tab
    Log To Console    Looking for My followed requests tab...
    ${followed_tab} =    Set Variable    xpath=//a[@data-tab-value='Followed' and @data-label='My followed requests']
    Wait For Elements State    ${followed_tab}    visible    timeout=15s
    Click    ${followed_tab}
    Sleep    5s

    # Wait for data to load
    Sleep    10s
    Take Screenshot

    # Check if case number appears in the followed requests table
    Log To Console    Verifying case ${case_number} in followed requests...
    ${table_text} =    Get Text    table
    Log To Console    Table content: ${table_text}

    ${case_found} =    Run Keyword And Return Status    Should Contain    ${table_text}    ${case_number}
    Run Keyword If    ${case_found}    Log To Console    Case ${case_number} found in My followed requests PASSED
    Run Keyword Unless    ${case_found}    Fail    Case ${case_number} not found in My followed requests

    Log To Console    Follow case test PASSED


*** Keywords ***

Unfollow All Cases For User
    [Arguments]    ${user_id}
    [Documentation]    Unfollows all cases by deleting Interested Parties records.

    # Find the Contact ID from the User
    @{users} =    Salesforce Query    User    select=ContactId    where=Id='${user_id}'    limit=1
    ${contact_id} =    Set Variable    ${users}[0][ContactId]
    Log To Console    Contact ID: ${contact_id}

    # Query for Interested Parties records
    @{interested_parties} =    Salesforce Query    cfsuite1__Interested_Parties__c    select=Id,cfsuite1__Case__c    where=cfsuite1__Contact__c='${contact_id}'

    ${party_count} =    Get Length    ${interested_parties}
    Log To Console    Found ${party_count} followed cases

    Run Keyword If    ${party_count} == 0    Log To Console    No cases to unfollow
    Run Keyword If    ${party_count} == 0    Return From Keyword

    # Delete each Interested Party record
    FOR    ${party}    IN    @{interested_parties}
        ${party_id} =    Set Variable    ${party}[Id]
        Log To Console    Unfollowing (ID: ${party_id})...
        Salesforce Delete    cfsuite1__Interested_Parties__c    ${party_id}
    END

    Log To Console    Successfully unfollowed ${party_count} cases
