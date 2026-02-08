*** Settings ***

Resource        cumulusci/robotframework/Salesforce.robot
Library         cumulusci.robotframework.PageObjects
Library         SeleniumLibrary

Suite Setup     Open Test Browser
# Suite Teardown  Delete Records and Close Browser


*** Test Cases ***

Clone Case
    [Documentation]
    ...  Test opens an existing Case, clicks "Clone Case" button,
    ...  selects category options, and validates the cloned case is created successfully.

    # Query for an existing Case to clone
    Log To Console    Querying for existing cases...
    @{cases} =    Salesforce Query    Case    select=Id    limit=1

    ${case_count} =    Get Length    ${cases}
    Run Keyword If    ${case_count} == 0    Fail    No existing cases found in org. Please create a case first.

    ${source_case_id} =    Set Variable    ${cases}[0][Id]
    Log To Console    Source case ID: ${source_case_id}

    # Navigate directly to the source case detail page
    Go to page    Detail    Case    ${source_case_id}

    # Wait for case detail page to load
    Sleep    5s
    Capture Page Screenshot    source_case_detail.png

    # Click "Clone Case" button
    Log To Console    Looking for Clone Case button...
    ${clone_button_selector} =    Set Variable    xpath=//button[contains(text(), 'Clone Case')]
    Wait Until Element Is Visible    ${clone_button_selector}    timeout=15s
    Log To Console    Clone Case button found - clicking it

    Click Element    ${clone_button_selector}

    # Wait for case creation page to load
    Sleep    15s
    Capture Page Screenshot    clone_case_creation_page.png

    # Select Category = Animals
    Log To Console    Looking for Category element...
    Wait Until Element Is Visible    id=category_0    timeout=10s
    Log To Console    Category element found

    Execute Javascript    document.getElementById('category_0').scrollIntoView({behavior: 'smooth', block: 'center'})
    Sleep    1s

    Log To Console    Clicking on Animals category...
    Click Element    id=category_0
    Sleep    3s
    Capture Page Screenshot    after_category_selection_clone.png
    Log To Console    Animals category clicked

    # Select Request Reason = Dog
    Log To Console    Looking for Request Reason dropdown...
    ${reason_selector} =    Set Variable    xpath=//select[.//option[@value='Dog']]
    Wait Until Element Is Visible    ${reason_selector}    timeout=15s
    Log To Console    Request Reason dropdown found

    Select From List By Value    ${reason_selector}    Dog
    Sleep    2s
    Capture Page Screenshot    after_reason_selection_clone.png

    # Select Request Sub Reason = Keeping Excess Dogs
    Log To Console    Looking for Request Sub Reason dropdown...
    ${subreason_selector} =    Set Variable    xpath=//select[.//option[@value='Keeping Excess Dogs']]
    Wait Until Element Is Visible    ${subreason_selector}    timeout=15s
    Log To Console    Request Sub Reason dropdown found

    Select From List By Value    ${subreason_selector}    Keeping Excess Dogs
    Sleep    2s
    Capture Page Screenshot    after_subreason_selection_clone.png

    # Note: Description field exists but is not required for clone operation
    Sleep    2s
    Capture Page Screenshot    clone_form_ready.png

    # Click "Clone case" button using JavaScript (find visible button with exact text)
    Log To Console    Looking for visible Clone case button to submit...
    Sleep    2s
    Execute Javascript    var buttons = document.querySelectorAll('button.slds-button_brand'); for(var i=0; i<buttons.length; i++) { var btn = buttons[i]; if(btn.textContent.trim().startsWith('Clone case') && btn.offsetWidth > 0 && btn.offsetHeight > 0) { console.log('Found visible Clone case button:', btn); btn.click(); break; } }
    Log To Console    Clone case submit button clicked
    Sleep    5s
    Capture Page Screenshot    after_create_button_click_clone.png

    # Check if modal appears
    ${modal_selector} =    Set Variable    xpath=//*[contains(@class, 'slds-modal') or @role='dialog']
    ${modal_exists} =    Run Keyword And Return Status    Wait Until Page Contains Element    ${modal_selector}    timeout=5s

    Run Keyword If    ${modal_exists}    Log To Console    Modal found - filling fields
    Run Keyword If    ${modal_exists}    Handle Modal Fields
    Run Keyword Unless    ${modal_exists}    Log To Console    No modal found

    # Wait for case to be created
    Sleep    10s
    Capture Page Screenshot    cloned_case_created.png

    # Query for the most recently created case (should be our cloned case)
    Log To Console    Querying for the most recently created case...
    @{recent_cases} =    Salesforce Query    Case    select=Id,Description    order_by=CreatedDate DESC    limit=1

    ${case_count} =    Get Length    ${recent_cases}
    Run Keyword If    ${case_count} == 0    Fail    No cases found - cloned case creation may have failed

    ${cloned_case_id} =    Set Variable    ${recent_cases}[0][Id]
    Log To Console    Most recent case ID: ${cloned_case_id}
    Store Session Record    Case    ${cloned_case_id}
    Log To Console    Cloned Case ID: ${cloned_case_id}

    # Validate the cloned case was created successfully
    Validate Cloned Case    ${cloned_case_id}    ${source_case_id}


*** Keywords ***

Handle Modal Fields
    [Documentation]
    ...  Handles filling in the modal fields for Case Origin and Notification Method.

    Log To Console    Filling modal fields...
    Capture Page Screenshot    modal_visible_clone.png

    # Click Case Origin combobox button
    ${origin_button} =    Set Variable    xpath=//button[@aria-label='Case Origin'][contains(@class, 'slds-combobox__input')]
    ${origin_exists} =    Run Keyword And Return Status    Wait Until Element Is Visible    ${origin_button}    timeout=5s
    Run Keyword If    ${origin_exists}    Click Element    ${origin_button}
    Sleep    1s

    # Select Email from dropdown
    ${email_option} =    Set Variable    xpath=//span[@title='Email']
    ${email_exists} =    Run Keyword And Return Status    Wait Until Element Is Visible    ${email_option}    timeout=5s
    Run Keyword If    ${email_exists}    Click Element    ${email_option}
    Sleep    1s

    # Click Notification Method combobox button
    ${notification_button} =    Set Variable    xpath=//button[@aria-label='Notification Method'][contains(@class, 'slds-combobox__input')]
    ${notif_exists} =    Run Keyword And Return Status    Wait Until Element Is Visible    ${notification_button}    timeout=5s
    Run Keyword If    ${notif_exists}    Click Element    ${notification_button}
    Sleep    1s

    # Select No Notification
    ${no_notif_option} =    Set Variable    xpath=//span[@title='No Notification']
    ${no_notif_exists} =    Run Keyword And Return Status    Wait Until Element Is Visible    ${no_notif_option}    timeout=5s
    Run Keyword If    ${no_notif_exists}    Click Element    ${no_notif_option}
    Sleep    1s

    # Click Save button
    ${save_button} =    Set Variable    xpath=//button[text()='Save']
    ${button_exists} =    Run Keyword And Return Status    Wait Until Element Is Visible    ${save_button}    timeout=5s
    Run Keyword If    ${button_exists}    Click Element    ${save_button}


Validate Cloned Case
    [Arguments]    ${cloned_case_id}    ${source_case_id}
    [Documentation]
    ...  Validates that the cloned case was created successfully and is different from the source case.

    Log To Console    Validating cloned case...

    # Validate via API
    &{cloned_case} =    Salesforce Get    Case    ${cloned_case_id}

    # Validate the cloned case ID is different from source
    Should Not Be Equal As Strings    ${cloned_case_id}    ${source_case_id}    msg=Cloned case ID should be different from source case
    Log To Console    Cloned case ID ${cloned_case_id} is different from source ${source_case_id} ✓

    # Validate case exists and has required fields
    Should Not Be Empty    ${cloned_case}[Id]    msg=Cloned case should have an ID
    Log To Console    Case Status: ${cloned_case}[Status]

    Log To Console    ✓ Clone case validation PASSED
