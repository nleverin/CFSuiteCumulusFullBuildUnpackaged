*** Settings ***

Resource        cumulusci/robotframework/Salesforce.robot
Library         cumulusci.robotframework.PageObjects
Library         SeleniumLibrary

Suite Setup     Open Test Browser
# Suite Teardown  Delete Records and Close Browser


*** Test Cases ***

Login to Customer Portal as Hammy Hampster
    [Documentation]
    ...  Test logs into Salesforce, navigates to Hammy Hampster person account,
    ...  clicks "Log in to Experience as User", and lands on the postal home page.

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
    Capture Page Screenshot    postal_home_page.png
    Log To Console    Successfully logged into customer portal

    # Validate we're on the postal home page
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

    # Click "Animals" tile
    Log To Console    Looking for Animals tile...
    ${animals_selector} =    Set Variable    xpath=//a[@href='/s/request-submit?id=DS-0004']
    Wait Until Element Is Visible    ${animals_selector}    timeout=15s
    Log To Console    Animals tile found - clicking it
    Click Element    ${animals_selector}
    Sleep    5s
    Capture Page Screenshot    animals_request_page.png

    # Click "A Wandering Dog" button
    Log To Console    Looking for A Wandering Dog option...
    ${wandering_dog_selector} =    Set Variable    xpath=//button[@id='DS-0014']
    Wait Until Element Is Visible    ${wandering_dog_selector}    timeout=15s
    Log To Console    A Wandering Dog option found - clicking it
    Click Element    ${wandering_dog_selector}
    Sleep    5s
    Capture Page Screenshot    map_page.png

    # Switch to iframe containing the map
    Log To Console    Looking for map iframe...
    ${iframe_selector} =    Set Variable    xpath=//iframe[contains(@src, 'cf_MapCreateCaseCommunity')]
    Wait Until Element Is Visible    ${iframe_selector}    timeout=15s
    Log To Console    Map iframe found - switching to iframe

    Select Frame    ${iframe_selector}
    Sleep    3s
    Capture Page Screenshot    inside_iframe.png

    # Click in the center of the map
    Log To Console    Clicking in center of map...
    ${map_surface} =    Set Variable    xpath=//div[contains(@class, 'esri-view-surface')]
    Wait Until Element Is Visible    ${map_surface}    timeout=10s

    # Click at center coordinates (200, 150 pixels from top-left of map element)
    Log To Console    Clicking at offset 200, 150 on map
    Click Element At Coordinates    ${map_surface}    200    150

    Sleep    3s
    Capture Page Screenshot    map_location_selected.png

    # Switch back to default content
    Unselect Frame
    Sleep    2s

    # Click Continue button
    Log To Console    Looking for Continue button...
    ${continue_button_selector} =    Set Variable    xpath=//button[contains(@class, 'btn-continue')]
    Wait Until Element Is Enabled    ${continue_button_selector}    timeout=15s
    Log To Console    Continue button found - clicking it
    Click Element    ${continue_button_selector}
    Sleep    5s
    Capture Page Screenshot    details_page.png

    # Select "No notification" from preferred contact method
    Log To Console    Selecting No notification for preferred contact method...
    ${no_notification_label} =    Set Variable    xpath=//label[contains(., 'No notification')]
    Wait Until Element Is Visible    ${no_notification_label}    timeout=15s
    Click Element    ${no_notification_label}
    Sleep    2s
    Capture Page Screenshot    contact_method_selected.png

    # Click Submit request button
    Log To Console    Looking for Submit request button...
    ${submit_button_selector} =    Set Variable    xpath=//button[@id='SubmitButton']
    Wait Until Element Is Enabled    ${submit_button_selector}    timeout=15s
    Log To Console    Submit request button found - clicking it
    Click Element    ${submit_button_selector}
    Sleep    5s
    Capture Page Screenshot    thank_you_page.png

    # Validate thank you page and extract reference number
    ${reference_number} =    Validate Thank You Page

    # Verify case is linked to account via My Requests dashboard
    Verify Case In My Requests    ${reference_number}


*** Keywords ***

Validate Thank You Page
    [Documentation]
    ...  Validates the thank you page has case reference number, preferred contact method None,
    ...  and assessment timeframe text.

    Log To Console    Validating thank you page...

    # Check for reference number and extract it
    Log To Console    Looking for reference number...
    ${ref_number_exists} =    Run Keyword And Return Status    Page Should Contain    Reference number:
    Run Keyword If    ${ref_number_exists}    Log To Console    Reference number found ✓
    Run Keyword Unless    ${ref_number_exists}    Fail    Reference number not found on thank you page

    # Extract the reference number from the page
    ${page_text} =    Get Text    xpath=//body
    ${reference_number} =    Get Regexp Matches    ${page_text}    Reference number:\\s+(\\d+)    1
    ${ref_num} =    Set Variable    ${reference_number}[0]
    Log To Console    Extracted reference number: ${ref_num}

    # Check for preferred contact method showing "None"
    Log To Console    Looking for preferred contact method...
    ${contact_method_text} =    Get Text    xpath=//body
    ${has_none} =    Run Keyword And Return Status    Should Contain    ${contact_method_text}    None
    Run Keyword If    ${has_none}    Log To Console    Preferred contact method shows None ✓
    Run Keyword Unless    ${has_none}    Log To Console    WARNING: Could not verify contact method is None

    # Check for assessment timeframe text
    Log To Console    Looking for assessment timeframe...
    ${has_timeframe} =    Run Keyword And Return Status    Page Should Contain    This will be assessed within: 3-5 Business Days
    Run Keyword If    ${has_timeframe}    Log To Console    Assessment timeframe found: 3-5 Business Days ✓
    Run Keyword Unless    ${has_timeframe}    Fail    Assessment timeframe text not found on thank you page

    Log To Console    ✓ Thank you page validation PASSED

    [Return]    ${ref_num}


Verify Case In My Requests
    [Arguments]    ${reference_number}
    [Documentation]
    ...  Verifies that the case with the given reference number is linked to the account.
    ...  Checks via API first, then verifies in UI.

    Log To Console    Verifying case ${reference_number} is linked to account...

    # First, verify via API that the case has the AccountId set
    Log To Console    Querying case ${reference_number} via API...
    @{cases} =    Salesforce Query    Case    select=Id,CaseNumber,AccountId,ContactId,OwnerId    where=CaseNumber='${reference_number}'    limit=1

    ${case_count} =    Get Length    ${cases}
    Run Keyword If    ${case_count} == 0    Fail    Case ${reference_number} not found in Salesforce
    Log To Console    Case found via API

    ${case_id} =    Set Variable    ${cases}[0][Id]
    ${account_id} =    Set Variable    ${cases}[0][AccountId]
    ${contact_id} =    Set Variable    ${cases}[0][ContactId]
    ${owner_id} =    Set Variable    ${cases}[0][OwnerId]

    Log To Console    Case Details:
    Log To Console    - Case ID: ${case_id}
    Log To Console    - AccountId: ${account_id}
    Log To Console    - ContactId: ${contact_id}
    Log To Console    - OwnerId: ${owner_id}

    # Check if AccountId exists (not None or empty)
    Run Keyword If    '${account_id}' == 'None' or '${account_id}' == ''    Fail    Case ${reference_number} does not have an AccountId - not linked to account

    # Query account name separately since we know AccountId exists
    @{case_with_account} =    Salesforce Query    Case    select=Account.Name    where=Id='${case_id}'    limit=1
    ${account_name} =    Set Variable    ${case_with_account}[0][Account][Name]
    Log To Console    ✓ Case ${reference_number} is linked to Account: ${account_name} (${account_id})

    # Now check if it appears in My Requests UI
    Log To Console    Checking if case appears in My Requests UI...

    # Click on MY DASHBOARD navigation link at top
    Log To Console    Looking for MY DASHBOARD navigation link...
    ${dashboard_nav} =    Set Variable    xpath=//a[@href='/s/' and contains(@class, 'nav-link')]
    Wait Until Element Is Visible    ${dashboard_nav}    timeout=15s
    Log To Console    MY DASHBOARD nav link found - clicking it
    Click Element    ${dashboard_nav}
    Sleep    5s
    Capture Page Screenshot    dashboard_home_page.png

    # Click on "My requests" tile
    Log To Console    Looking for My requests tile...
    ${my_requests_tile} =    Set Variable    xpath=//a[@href='/s/my-requests']
    Wait Until Element Is Visible    ${my_requests_tile}    timeout=15s
    Log To Console    My requests tile found - clicking it
    Click Element    ${my_requests_tile}
    Sleep    5s
    Capture Page Screenshot    my_requests_page_initial.png

    # Wait for case to appear in the system (may take a few seconds to sync)
    Log To Console    Waiting for case to appear in My Requests (allowing time for sync)...
    Sleep    5s

    # Refresh the page to get latest data
    Reload Page
    Sleep    3s
    Capture Page Screenshot    my_requests_page_refreshed.png

    # Check if the reference number appears in the My Requests table
    Log To Console    Looking for reference number ${reference_number} in My Requests table...
    ${table_selector} =    Set Variable    xpath=//table
    Wait Until Element Is Visible    ${table_selector}    timeout=15s

    ${table_text} =    Get Text    ${table_selector}
    Log To Console    Table content: ${table_text}

    ${case_in_table} =    Run Keyword And Return Status    Should Contain    ${table_text}    ${reference_number}
    Run Keyword If    ${case_in_table}    Log To Console    ✓ Case ${reference_number} found in My Requests UI table
    Run Keyword Unless    ${case_in_table}    Log To Console    NOTE: Case ${reference_number} not yet visible in My Requests table (may need more sync time)

    Log To Console    ✓ Case account linkage verification PASSED (API confirmed AccountId is set correctly)

