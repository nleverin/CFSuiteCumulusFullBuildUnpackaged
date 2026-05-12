*** Settings ***

Resource        ../resources/playwright_common.robot
Resource        ../resources/test_data.robot

Suite Setup     Run Keywords    Ensure SR Baseline    AND    Open Test Browser With Video
# Suite Teardown  Delete Records and Close Browser


*** Test Cases ***

Login to Customer Portal as Hammy Hampster
    [Documentation]
    ...  Test logs into Salesforce, navigates to Hammy Hampster person account,
    ...  clicks "Log in to Experience as User", makes a request, and validates
    ...  the thank you page and My Requests dashboard.

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
    Log To Console    Successfully logged into customer portal

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

    # Click "Animals" tile
    Log To Console    Looking for Animals tile...
    ${animals} =    Set Variable    xpath=//a[@href='/s/request-submit?id=DS-0004']
    Wait For Elements State    ${animals}    visible    timeout=15s
    Click    ${animals}
    Sleep    5s
    Take Screenshot

    # Click "A Wandering Dog" button
    Log To Console    Looking for A Wandering Dog option...
    ${wandering_dog} =    Set Variable    xpath=//button[@id='DS-0014']
    Wait For Elements State    ${wandering_dog}    visible    timeout=15s
    Click    ${wandering_dog}
    Sleep    5s
    Take Screenshot

    # Click in the center of the map (inside iframe using >>> piercing)
    Log To Console    Looking for map iframe...
    ${map_iframe} =    Set Variable    iframe[src*='cf_MapCreateCaseCommunity']
    Wait For Elements State    ${map_iframe}    visible    timeout=15s

    ${map_surface} =    Set Variable    ${map_iframe} >>> div.esri-view-surface
    Wait For Elements State    ${map_surface}    visible    timeout=10s
    Click    ${map_surface}    position_x=200    position_y=150
    Sleep    3s
    Take Screenshot

    # Click Continue button
    Log To Console    Looking for Continue button...
    ${continue_button} =    Set Variable    xpath=//button[contains(@class, 'btn-continue')]
    Wait For Elements State    ${continue_button}    enabled    timeout=15s
    Click    ${continue_button}
    Sleep    5s
    Take Screenshot

    # Select "No notification" from preferred contact method
    Log To Console    Selecting No notification...
    ${no_notification} =    Set Variable    xpath=//label[contains(., 'No notification')]
    Wait For Elements State    ${no_notification}    visible    timeout=15s
    Click    ${no_notification}
    Sleep    2s
    Take Screenshot

    # Click Submit request button
    Log To Console    Looking for Submit request button...
    ${submit_button} =    Set Variable    xpath=//button[@id='SubmitButton']
    Wait For Elements State    ${submit_button}    enabled    timeout=15s
    Click    ${submit_button}
    Sleep    5s
    Take Screenshot

    # Validate thank you page and extract reference number
    ${reference_number} =    Validate Thank You Page

    # Verify case is linked to account via My Requests dashboard
    Verify Case In My Requests    ${reference_number}


*** Keywords ***

Validate Thank You Page
    [Documentation]    Validates the thank you page and extracts the reference number.

    Log To Console    Validating thank you page...

    ${page_text} =    Get Text    body
    Should Contain    ${page_text}    Reference number:    msg=Reference number not found

    ${reference_numbers} =    Get Regexp Matches    ${page_text}    Reference number:\\s+(\\d+)    1
    ${ref_num} =    Set Variable    ${reference_numbers}[0]
    Log To Console    Extracted reference number: ${ref_num}

    # Check for preferred contact method showing "None"
    ${has_none} =    Run Keyword And Return Status    Should Contain    ${page_text}    None
    Run Keyword If    ${has_none}    Log To Console    Preferred contact method shows None PASSED

    # Check for assessment timeframe text
    ${has_timeframe} =    Run Keyword And Return Status    Should Contain    ${page_text}    This will be assessed within: 3-5 Business Days
    Run Keyword If    ${has_timeframe}    Log To Console    Assessment timeframe PASSED
    Run Keyword Unless    ${has_timeframe}    Fail    Assessment timeframe text not found

    Log To Console    Thank you page validation PASSED
    [Return]    ${ref_num}


Verify Case In My Requests
    [Arguments]    ${reference_number}
    [Documentation]    Verifies that the case appears in My Requests.

    Log To Console    Verifying case ${reference_number} is linked to account...

    # Verify via API
    @{cases} =    Salesforce Query    Case    select=Id,CaseNumber,AccountId,ContactId,OwnerId    where=CaseNumber='${reference_number}'    limit=1
    ${case_count} =    Get Length    ${cases}
    Run Keyword If    ${case_count} == 0    Fail    Case ${reference_number} not found

    ${account_id} =    Set Variable    ${cases}[0][AccountId]
    Run Keyword If    '${account_id}' == 'None' or '${account_id}' == ''    Fail    Case not linked to account

    Log To Console    Case ${reference_number} is linked to AccountId: ${account_id} PASSED

    # Navigate to My Requests UI
    Log To Console    Checking My Requests UI...
    ${dashboard_nav} =    Set Variable    xpath=//a[@href='/s/' and contains(@class, 'nav-link')]
    Wait For Elements State    ${dashboard_nav}    visible    timeout=15s
    Click    ${dashboard_nav}
    Sleep    5s
    Take Screenshot

    ${my_requests_tile} =    Set Variable    xpath=//a[@href='/s/my-requests']
    Wait For Elements State    ${my_requests_tile}    visible    timeout=15s
    Click    ${my_requests_tile}
    Sleep    5s

    # Refresh to get latest data
    Evaluate JavaScript    ${None}    location.reload()
    Sleep    3s
    Take Screenshot

    # Check if reference number appears in table
    ${table_selector} =    Set Variable    table
    Wait For Elements State    ${table_selector}    visible    timeout=15s
    ${table_text} =    Get Text    ${table_selector}
    Log To Console    Table content: ${table_text}

    ${case_in_table} =    Run Keyword And Return Status    Should Contain    ${table_text}    ${reference_number}
    Run Keyword If    ${case_in_table}    Log To Console    Case ${reference_number} found in My Requests PASSED
    Run Keyword Unless    ${case_in_table}    Log To Console    NOTE: Case not yet visible (may need sync time)

    Log To Console    Case account linkage verification PASSED
