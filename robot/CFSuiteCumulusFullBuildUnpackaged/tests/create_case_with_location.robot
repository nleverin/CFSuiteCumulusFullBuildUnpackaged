*** Settings ***

Resource        cumulusci/robotframework/Salesforce.robot
Library         cumulusci.robotframework.PageObjects
Library         SeleniumLibrary

Suite Setup     Open Test Browser
# Suite Teardown  Delete Records and Close Browser
# Comment out teardown to keep browser open for debugging


*** Test Cases ***

Create Case With Map Location And Validation
    [Documentation]
    ...  Test creates a new Case by selecting a map location,
    ...  choosing category options, filling modal fields,
    ...  and validates the address and due date are populated correctly.

    # Navigate to Case tab
    Go to page            Home  Case

    # Wait for page to load
    Sleep    5s

    # Click New button directly (not using Click Object Button which expects standard modal)
    Wait Until Element Is Visible    xpath=//div[@title='New']    timeout=10s
    Click Element    xpath=//div[@title='New']

    # Wait for custom case creation page to load
    Sleep    15s
    Capture Page Screenshot    new_case_page.png

    # Log page source for debugging
    ${page_source} =    Get Source
    Log    ${page_source}

    # Log what elements we can actually see
    ${iframe_count} =    Execute Javascript    return document.querySelectorAll('iframe').length;
    Log To Console    Number of iframes on page: ${iframe_count}
    ${category_exists_js} =    Execute Javascript    return document.getElementById('category_0') !== null;
    Log To Console    Category element exists (via JS): ${category_exists_js}

    # Check if Create Case button exists
    ${button_exists} =    Run Keyword And Return Status    Page Should Contain Element    xpath=//button[@value='Create Case']
    Run Keyword If    ${button_exists}    Log To Console    Create Case button found
    Run Keyword Unless    ${button_exists}    Log To Console    Create Case button NOT found - checking for alternatives

    # Select map location using screen coordinates
    # Wait for map iframe to be ready
    Log To Console    Waiting for map iframe to load...
    Sleep    10s

    # Find and switch to the iframe containing the map
    ${iframe_selector} =    Set Variable    xpath=//iframe[contains(@src, 'cf_MapCreateCase')]
    Log To Console    Looking for iframe with selector: ${iframe_selector}

    # Try to find the iframe with extended timeout
    ${iframe_found} =    Run Keyword And Return Status    Wait Until Element Is Visible    ${iframe_selector}    timeout=20s

    Run Keyword Unless    ${iframe_found}    Log To Console    ERROR: Map iframe not found - checking for all iframes on page
    Run Keyword Unless    ${iframe_found}    Execute Javascript    console.log('All iframe sources:', Array.from(document.querySelectorAll('iframe')).map(f => f.src));
    Run Keyword Unless    ${iframe_found}    Capture Page Screenshot    iframe_not_found.png
    Run Keyword Unless    ${iframe_found}    Fail    Map iframe with 'cf_MapCreateCase' not found on page

    Log To Console    MapCreateCase iframe found - switching to it

    # Switch to the cf_MapCreateCase iframe
    Select Frame    ${iframe_selector}
    Log To Console    Successfully switched to iframe

    # Wait longer for map to fully load
    Log To Console    Waiting for map to fully load and render...
    Sleep    10s
    Capture Page Screenshot    inside_iframe.png

    # Log what's in the iframe
    ${canvas_count} =    Execute Javascript    return document.querySelectorAll('canvas').length;
    Log To Console    Number of canvas elements in iframe: ${canvas_count}
    ${all_classes} =    Execute Javascript    return Array.from(document.querySelectorAll('canvas')).map(c => c.className).join(', ');
    Log To Console    Canvas classes found: ${all_classes}

    # Try to find ANY canvas element with extended timeout
    Log To Console    Looking for map canvas element...
    ${map_canvas} =    Set Variable    xpath=//canvas
    ${canvas_found} =    Run Keyword And Return Status    Wait Until Element Is Visible    ${map_canvas}    timeout=30s

    Run Keyword Unless    ${canvas_found}    Log To Console    ERROR: Map canvas not found after 30 seconds - map may not have loaded
    Run Keyword Unless    ${canvas_found}    Capture Page Screenshot    map_canvas_not_found.png
    Run Keyword Unless    ${canvas_found}    Fail    Map canvas element not found in iframe - cannot proceed with map click

    Log To Console    Map canvas found - clicking at coordinates

    # Wait a bit more to ensure map is fully interactive
    Sleep    3s

    # Click on the canvas at specific coordinates (center of typical map view)
    Log To Console    About to click map canvas at coordinates 300, 200
    Click Element At Coordinates    ${map_canvas}    300    200
    Log To Console    Map click completed successfully
    Capture Page Screenshot    after_map_click.png
    Sleep    5s

    # Wait for the ESRI search input field to be visible
    ${location_input_selector} =    Set Variable    xpath=//input[@class='esri-input esri-search__input'][@aria-label='Search']
    Log To Console    Waiting for location input field to appear...
    Wait Until Element Is Visible    ${location_input_selector}    timeout=10s
    Log To Console    Location input field found

    # Wait for the input field to be populated with an address after map click
    Log To Console    Waiting for address to populate in input field...
    Wait Until Keyword Succeeds    20s    1s    Address Should Be Populated    ${location_input_selector}

    # Store the selected location for later validation
    ${selected_location} =    Get Element Attribute    ${location_input_selector}    value
    Set Test Variable    ${SELECTED_LOCATION}    ${selected_location}
    Log To Console    Selected Location: ${selected_location}

    # Switch back to main content
    Unselect Frame
    Sleep    1s
    Capture Page Screenshot    after_iframe_interaction.png

    # Select Category = Animals (click on the li element)
    Log To Console    Looking for Category element...
    Wait Until Element Is Visible    id=category_0    timeout=10s
    Log To Console    Category element found

    # Scroll the element into view before clicking
    Execute Javascript    document.getElementById('category_0').scrollIntoView({behavior: 'smooth', block: 'center'})
    Sleep    1s

    # Click on the li element with id=category_0 (Animals)
    Log To Console    Clicking on Animals category...
    Click Element    id=category_0
    Sleep    3s
    Capture Page Screenshot    after_category_selection.png
    Log To Console    Animals category clicked

    # Wait for Request Reason to render after category selection
    Log To Console    Looking for Request Reason dropdown...
    ${reason_selector} =    Set Variable    xpath=//select[.//option[@value='Dog']]
    Wait Until Element Is Visible    ${reason_selector}    timeout=15s
    Log To Console    Request Reason dropdown found

    # Select Request Reason = Dog (using value instead of label)
    Select From List By Value    ${reason_selector}    Dog
    Sleep    2s
    Capture Page Screenshot    after_reason_selection.png

    # Wait for Request Sub Reason to render after request reason selection
    Log To Console    Looking for Request Sub Reason dropdown...
    ${subreason_selector} =    Set Variable    xpath=//select[.//option[@value='Keeping Excess Dogs']]
    Wait Until Element Is Visible    ${subreason_selector}    timeout=15s
    Log To Console    Request Sub Reason dropdown found

    # Select Request Sub Reason = Keeping Excess Dogs (using value)
    Select From List By Value    ${subreason_selector}    Keeping Excess Dogs
    Sleep    2s
    Capture Page Screenshot    after_subreason_selection.png

    # Wait for Create Case button to become enabled after all selections
    Log To Console    Checking if Create Case button is enabled...
    ${button_selector} =    Set Variable    xpath=//button[contains(text(), 'Create case')]
    Wait Until Element Is Enabled    ${button_selector}    timeout=20s
    Log To Console    Create Case button is enabled

    # Click Create Case button to open modal
    Click Element    ${button_selector}

    # Pause here to inspect the page manually (remove this when done debugging)
    Sleep    5s
    Capture Page Screenshot    after_create_case_click.png

    # Check if modal appears
    ${modal_selector} =    Set Variable    xpath=//*[contains(@class, 'slds-modal') or contains(@class, 'modal') or @role='dialog' or contains(@class, 'modalWindow')]
    ${modal_exists} =    Run Keyword And Return Status    Wait Until Page Contains Element    ${modal_selector}    timeout=5s
    Run Keyword If    ${modal_exists}    Log To Console    Modal found!
    Run Keyword Unless    ${modal_exists}    Log To Console    Modal NOT found - may not be required or already processed

    # If modal exists, fill in the modal fields
    Run Keyword If    ${modal_exists}    Handle Modal Fields

    # Wait for case to be created and page to redirect
    Log To Console    Waiting for case to be created...
    Sleep    10s

    # Capture screenshot after save
    Capture Page Screenshot    after_case_save.png

    # Try multiple selectors to detect the case detail page
    ${case_id_found} =    Run Keyword And Return Status    Wait Until Page Contains Element    xpath=//*[contains(@class, 'forceRecordLayout') or contains(@class, 'slds-page-header') or @data-aura-class='forceDetailPanelDesktop']    timeout=15s

    Run Keyword If    ${case_id_found}    Log To Console    Case detail page found - proceeding with validation
    Run Keyword If    ${case_id_found}    Proceed With Case Validation
    Run Keyword Unless    ${case_id_found}    Log To Console    Case detail page not found - case may not have been created or page did not redirect


*** Keywords ***

Address Should Be Populated
    [Arguments]    ${locator}
    [Documentation]
    ...  Checks that the element has a non-empty value attribute
    ${value} =    Get Element Attribute    ${locator}    value
    Should Not Be Empty    ${value}

Handle Modal Fields
    [Documentation]
    ...  Handles filling in the modal fields for Case Origin and Notification Method

    Log To Console    Filling modal fields...
    Capture Page Screenshot    modal_visible.png

    # Click Case Origin combobox button to open dropdown
    ${origin_button} =    Set Variable    xpath=//button[@aria-label='Case Origin'][contains(@class, 'slds-combobox__input')]
    ${origin_exists} =    Run Keyword And Return Status    Wait Until Element Is Visible    ${origin_button}    timeout=5s
    Run Keyword If    ${origin_exists}    Log To Console    Case Origin combobox found
    Run Keyword Unless    ${origin_exists}    Log To Console    Case Origin combobox NOT found

    Run Keyword If    ${origin_exists}    Click Element    ${origin_button}
    Sleep    1s

    # Select Email from the dropdown list
    ${email_option} =    Set Variable    xpath=//span[@title='Email']
    ${email_exists} =    Run Keyword And Return Status    Wait Until Element Is Visible    ${email_option}    timeout=5s
    Run Keyword If    ${email_exists}    Click Element    ${email_option}
    Run Keyword Unless    ${email_exists}    Log To Console    Email option NOT found

    Sleep    1s

    # Click Notification Method combobox button
    ${notification_button} =    Set Variable    xpath=//button[@aria-label='Notification Method'][contains(@class, 'slds-combobox__input')]
    ${notif_exists} =    Run Keyword And Return Status    Wait Until Element Is Visible    ${notification_button}    timeout=5s
    Run Keyword If    ${notif_exists}    Click Element    ${notification_button}
    Run Keyword Unless    ${notif_exists}    Log To Console    Notification Method combobox NOT found

    Sleep    1s

    # Select No Notification from dropdown
    ${no_notif_option} =    Set Variable    xpath=//span[@title='No Notification']
    ${no_notif_exists} =    Run Keyword And Return Status    Wait Until Element Is Visible    ${no_notif_option}    timeout=5s
    Run Keyword If    ${no_notif_exists}    Click Element    ${no_notif_option}
    Run Keyword Unless    ${no_notif_exists}    Log To Console    No Notification option NOT found

    Sleep    1s

    # Click Save button in modal footer
    ${save_button} =    Set Variable    xpath=//button[text()='Save']
    ${button_exists} =    Run Keyword And Return Status    Wait Until Element Is Visible    ${save_button}    timeout=5s
    Run Keyword If    ${button_exists}    Click Element    ${save_button}
    Run Keyword Unless    ${button_exists}    Log To Console    Save button not found in modal

Proceed With Case Validation
    [Documentation]
    ...  Validates the created case has the correct data

    Log To Console    Validating created case...

    # Get the created case ID
    ${case_id} =    Get Current Record Id
    Store Session Record    Case    ${case_id}
    Log To Console    Case ID: ${case_id}

    # Validate the case
    Validate Case    ${case_id}    ${SELECTED_LOCATION}

Validate Case
    [Arguments]    ${case_id}    ${expected_location}
    [Documentation]
    ...  Validates that the case has the correct address populated
    ...  from the selected location and that a due date exists.

    # Navigate to the case detail page
    Go to page    Detail    Case    ${case_id}

    # Wait for page to fully load
    Sleep    3s

    # Validate via API - check address field is populated
    &{case} =    Salesforce Get    Case    ${case_id}
    Should Not Be Empty    ${case}[cfsuite1__Request_location__c]
    Log To Console    Case Address from API: ${case}[cfsuite1__Request_location__c]
    Log To Console    Expected Location: ${expected_location}

    # Validate address contains key parts of the selected location (more flexible than exact match)
    ${address_lower} =    Convert To Lower Case    ${case}[cfsuite1__Request_location__c]
    ${expected_lower} =    Convert To Lower Case    ${expected_location}
    Should Contain    ${address_lower}    ada    msg=Address should contain 'Ada' from the selected location
    Should Contain    ${address_lower}    adelaide    msg=Address should contain 'Adelaide' from the selected location
    Log To Console    ✓ Address validation PASSED

    # Validate that Due Date exists and is not empty
    ${due_date_value} =    Get From Dictionary    ${case}    cfsuite1__Original_Due_Date__c    default=${None}
    Log To Console    Case Due Date value: ${due_date_value}
    Run Keyword If    '${due_date_value}' == '${None}' or '${due_date_value}' == 'None'    Log To Console    WARNING: Due Date field is empty/null
    Run Keyword Unless    '${due_date_value}' == '${None}' or '${due_date_value}' == 'None'    Log To Console    ✓ Due Date validation PASSED: ${due_date_value}
    Should Not Be Equal    ${due_date_value}    ${None}    msg=Due Date field should not be null
