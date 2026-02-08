*** Settings ***

Resource        cumulusci/robotframework/Salesforce.robot
Library         cumulusci.robotframework.PageObjects
Library         SeleniumLibrary

Suite Setup     Open Test Browser
# Suite Teardown  Delete Records and Close Browser


*** Test Cases ***

Community Follow Case
    [Documentation]
    ...  Test logs into Salesforce, navigates to Hammy Hampster person account,
    ...  clicks "Log in to Experience as User", lands on the portal home page,
    ...  and clicks on the Make a request tile.

    # Query for person account named "Hammy Hampster"
    Log To Console    Querying for Hammy Hampster account...
    @{accounts} =    Salesforce Query    Account    select=Id,Name,PersonContactId    where=Name='Hammy Hampster'    limit=1

    ${account_count} =    Get Length    ${accounts}
    Run Keyword If    ${account_count} == 0    Fail    No account found with name 'Hammy Hampster'. Please check the account name.

    ${account_id} =    Set Variable    ${accounts}[0][Id]
    ${account_name} =    Set Variable    ${accounts}[0][Name]
    ${person_contact_id} =    Set Variable    ${accounts}[0][PersonContactId]
    Log To Console    Account ID: ${account_id}
    Log To Console    Account Name: ${account_name}
    Log To Console    Person Contact ID: ${person_contact_id}

    # Query for the User associated with this contact
    Log To Console    Querying for User associated with this contact...
    @{users} =    Salesforce Query    User    select=Id,Username,ContactId,AccountId    where=ContactId='${person_contact_id}'    limit=1
    ${user_count} =    Get Length    ${users}
    Run Keyword If    ${user_count} > 0    Log To Console    Found User: ${users}[0][Username] (AccountId: ${users}[0][AccountId])
    Run Keyword If    ${user_count} == 0    Log To Console    WARNING: No User found for this contact

    ${user_id} =    Set Variable    ${users}[0][Id]

    # Unfollow all cases by deleting Interested Parties records for this user
    Log To Console    Unfollowing all cases for this user to ensure test can follow a case...
    Unfollow All Cases For User    ${user_id}

    # Navigate to the account detail page
    Go to page    Detail    Account    ${account_id}

    # Wait for account detail page to load
    Sleep    5s
    Capture Page Screenshot    hammy_account_detail.png

    # Click the dropdown button next to "View Customer User" to reveal menu
    Log To Console    Looking for dropdown menu button...
    ${dropdown_button} =    Set Variable    xpath=//button[contains(@class, 'slds-button_icon-border-filled')]
    Wait Until Element Is Visible    ${dropdown_button}    timeout=10s
    Log To Console    Dropdown button found - clicking it

    Click Element    ${dropdown_button}
    Sleep    2s
    Capture Page Screenshot    actions_menu_opened.png

    # Click "Log in to Experience as User" menu item
    Log To Console    Looking for Log in to Experience as User option...
    ${login_experience_selector} =    Set Variable    xpath=//lightning-menu-item[@data-target-selection-name='sfdc:StandardButton.Account.LoginToNetworkAsPersonUser']//span[contains(text(), 'Log in to Experience as User')]
    Wait Until Element Is Visible    ${login_experience_selector}    timeout=15s
    Log To Console    Log in to Experience option found - clicking it

    Click Element    ${login_experience_selector}

    # Wait for portal page to load
    Sleep    10s
    Capture Page Screenshot    portal_home_page.png
    Log To Console    Successfully logged into customer portal

    # Validate we're on the portal home page
    ${current_url} =    Get Location
    Log To Console    Current URL: ${current_url}

    # Click "Make a request" tile
    Log To Console    Looking for Make a request tile...
    ${make_request_selector} =    Set Variable    xpath=//a[@href='/s/requests']//div[contains(@class, 'box-title')]//div[text()='Make a request']
    Wait Until Element Is Visible    ${make_request_selector}    timeout=15s
    Log To Console    Make a request tile found - clicking it
    Click Element    ${make_request_selector}
    Sleep    5s
    Capture Page Screenshot    request_types_page.png

    # Switch to the map iframe
    Log To Console    Looking for map iframe...
    ${map_iframe_selector} =    Set Variable    xpath=//iframe[contains(@src, 'cf_MapRecentCases')]
    Wait Until Element Is Visible    ${map_iframe_selector}    timeout=15s
    Log To Console    Map iframe found - switching to iframe
    Select Frame    ${map_iframe_selector}
    Sleep    5s
    Capture Page Screenshot    inside_map_iframe.png

    # Wait for map to load
    Log To Console    Waiting for map to load...
    ${map_container} =    Set Variable    xpath=//div[contains(@class, 'esri-view-surface')]
    Wait Until Element Is Visible    ${map_container}    timeout=20s
    Sleep    10s
    Capture Page Screenshot    map_loaded.png

    # Automatically click on map coordinates to find a pin with a Follow button
    # Start from center and work outward in a spiral pattern
    Log To Console    Clicking on map to find a case with Follow button (starting from center)...
    ${popup_selector} =    Set Variable    xpath=//div[contains(@class, 'esri-popup')]
    ${follow_button_selector} =    Set Variable    xpath=//button[@class='followupButton']
    ${follow_found} =    Set Variable    False

    # Define center point and radius increments (smaller to stay in bounds)
    ${center_x} =    Set Variable    150
    ${center_y} =    Set Variable    150

    # Try clicking in a spiral pattern from center outward
    FOR    ${radius}    IN RANGE    0    140    30
        Exit For Loop If    ${follow_found}

        FOR    ${angle}    IN RANGE    0    360    30
            ${angle_rad} =    Evaluate    ${angle} * 3.14159 / 180
            ${x_offset} =    Evaluate    int(${radius} * __import__('math').cos(${angle_rad}))
            ${y_offset} =    Evaluate    int(${radius} * __import__('math').sin(${angle_rad}))
            ${x_coord} =    Evaluate    ${center_x} + ${x_offset}
            ${y_coord} =    Evaluate    ${center_y} + ${y_offset}

            # Skip if coordinates are out of reasonable bounds
            ${skip} =    Evaluate    ${x_coord} < 20 or ${x_coord} > 280 or ${y_coord} < 20 or ${y_coord} > 280
            Continue For Loop If    ${skip}

            Log To Console    Trying coordinates (${x_coord}, ${y_coord}) - radius ${radius}, angle ${angle}

            # Click on the map at these coordinates with error handling
            ${click_status} =    Run Keyword And Return Status    Click Element At Coordinates    ${map_container}    ${x_coord}    ${y_coord}
            Continue For Loop If    not ${click_status}
            Sleep    1s

            # Check if popup appeared
            ${popup_visible} =    Run Keyword And Return Status    Page Should Contain Element    ${popup_selector}

            # If popup appeared, check if it has a Follow button (not Stop following)
            ${has_follow} =    Run Keyword If    ${popup_visible}    Run Keyword And Return Status    Page Should Contain Element    ${follow_button_selector}
            ...    ELSE    Set Variable    False

            Run Keyword If    ${has_follow}    Log To Console    Found case with Follow button at (${x_coord}, ${y_coord})!
            ${follow_found} =    Set Variable If    ${has_follow}    True    False
            Exit For Loop If    ${follow_found}

            # If popup appeared but no Follow button, close it and try next coordinates
            Run Keyword If    ${popup_visible} and not ${has_follow}    Log To Console    Case already followed, trying next location...
            Run Keyword If    ${popup_visible} and not ${has_follow}    Press Keys    None    ESCAPE
            Sleep    0.5s
        END
    END

    # Verify we found a Follow button
    Run Keyword Unless    ${follow_found}    Fail    Could not find any case with a Follow button on the map
    Log To Console    Successfully found a case to follow!
    Capture Page Screenshot    follow_button_visible.png

    # Extract the case number from the onclick attribute of the follow button
    # The button looks like: <button class="followupButton" onclick="followHandler('500Rt00000YEvz2IAD', '00001014')">
    ${onclick_attr} =    Get Element Attribute    ${follow_button_selector}    onclick
    Log To Console    Follow button onclick: ${onclick_attr}

    # Extract case number from onclick using regex - looking for the second parameter which is the case number
    ${case_numbers} =    Get Regexp Matches    ${onclick_attr}    '(\\d{8})'    1
    ${case_number} =    Set Variable    ${case_numbers}[0]
    Log To Console    Extracted case number: ${case_number}

    # Click the Follow button
    Log To Console    Clicking Follow button for case ${case_number}...
    Click Element    ${follow_button_selector}
    Sleep    3s
    Capture Page Screenshot    follow_button_clicked.png

    # Switch back to default content
    Unselect Frame
    Sleep    2s

    # Click on MY DASHBOARD navigation link at top
    Log To Console    Looking for MY DASHBOARD navigation link...
    ${dashboard_nav} =    Set Variable    xpath=//a[@href='/s/' and contains(@class, 'nav-link')]
    Wait Until Element Is Visible    ${dashboard_nav}    timeout=15s
    Log To Console    MY DASHBOARD nav link found - clicking it
    Click Element    ${dashboard_nav}
    Sleep    5s
    Capture Page Screenshot    dashboard_page.png

    # Click on "My requests" tile
    Log To Console    Looking for My requests tile...
    ${my_requests_tile} =    Set Variable    xpath=//a[@href='/s/my-requests']
    Wait Until Element Is Visible    ${my_requests_tile}    timeout=15s
    Log To Console    My requests tile found - clicking it
    Click Element    ${my_requests_tile}
    Sleep    5s
    Capture Page Screenshot    my_requests_page.png

    # Click on "My followed requests" tab
    Log To Console    Looking for My followed requests tab...
    ${followed_tab_selector} =    Set Variable    xpath=//a[@data-tab-value='Followed' and @data-label='My followed requests']
    Wait Until Element Is Visible    ${followed_tab_selector}    timeout=15s
    Log To Console    My followed requests tab found - clicking it
    Click Element    ${followed_tab_selector}
    Sleep    5s
    Capture Page Screenshot    followed_requests_tab.png

    # Verify the case number appears in the followed requests table
    Log To Console    Verifying case ${case_number} appears in followed requests...

    # Wait a bit for the page to load
    Sleep    10s
    Capture Page Screenshot    followed_requests_page.png

    # Look for the table - try multiple selectors
    ${table_selector_1} =    Set Variable    xpath=//table[contains(@class, 'slds-table--bordered')]
    ${table_selector_2} =    Set Variable    xpath=//table[contains(@class, 'slds-table')]
    ${table_selector_3} =    Set Variable    xpath=//table

    ${table_found_1} =    Run Keyword And Return Status    Wait Until Element Is Visible    ${table_selector_1}    timeout=5s
    ${table_found_2} =    Run Keyword And Return Status    Wait Until Element Is Visible    ${table_selector_2}    timeout=5s
    ${table_found_3} =    Run Keyword And Return Status    Wait Until Element Is Visible    ${table_selector_3}    timeout=5s

    ${table_selector} =    Run Keyword If    ${table_found_1}    Set Variable    ${table_selector_1}
    ...    ELSE IF    ${table_found_2}    Set Variable    ${table_selector_2}
    ...    ELSE IF    ${table_found_3}    Set Variable    ${table_selector_3}
    ...    ELSE    Set Variable    xpath=//body

    Log To Console    Using selector: ${table_selector}

    # Get the content
    ${content} =    Get Text    ${table_selector}
    Log To Console    Page content: ${content}

    # Check if case number appears
    ${case_found} =    Run Keyword And Return Status    Should Contain    ${content}    ${case_number}

    Run Keyword If    ${case_found}    Log To Console    ✓ Case ${case_number} found in My followed requests
    Run Keyword Unless    ${case_found}    Fail    Case ${case_number} not found in My followed requests

    Log To Console    ✓ Follow case test PASSED


*** Keywords ***

Unfollow All Cases For User
    [Arguments]    ${user_id}
    [Documentation]
    ...  Unfollows all cases that the given user is following.
    ...  This is done by first finding the Contact associated with the User,
    ...  then querying for cfsuite1__Interested_Parties__c records for that contact.

    # First, find the Contact ID from the User
    Log To Console    Finding contact for user ${user_id}...
    @{users} =    Salesforce Query    User    select=ContactId    where=Id='${user_id}'    limit=1
    ${contact_id} =    Set Variable    ${users}[0][ContactId]
    Log To Console    Contact ID: ${contact_id}

    # Now query for Interested Parties records for this contact
    Log To Console    Querying for all followed cases (Interested Parties)...
    @{interested_parties} =    Salesforce Query    cfsuite1__Interested_Parties__c    select=Id,cfsuite1__Case__c    where=cfsuite1__Contact__c='${contact_id}'

    ${party_count} =    Get Length    ${interested_parties}
    Log To Console    Found ${party_count} followed cases

    Run Keyword If    ${party_count} == 0    Log To Console    No cases to unfollow
    Run Keyword If    ${party_count} == 0    Return From Keyword

    # Delete each Interested Party record
    FOR    ${party}    IN    @{interested_parties}
        ${party_id} =    Set Variable    ${party}[Id]
        Log To Console    Unfollowing case (Interested Party ID: ${party_id})...
        Salesforce Delete    cfsuite1__Interested_Parties__c    ${party_id}
    END

    Log To Console    Successfully unfollowed ${party_count} cases

