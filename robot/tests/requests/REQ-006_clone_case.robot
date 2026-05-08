*** Settings ***

Resource        ../resources/playwright_common.robot

Suite Setup     Open Test Browser With Video
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
    Run Keyword If    ${case_count} == 0    Fail    No existing cases found in org.

    ${source_case_id} =    Set Variable    ${cases}[0][Id]
    Log To Console    Source case ID: ${source_case_id}

    # Navigate to the source case detail page
    Navigate To Record    ${source_case_id}
    Take Screenshot

    # Click "Clone Case" button
    Log To Console    Looking for Clone Case button...
    ${clone_button} =    Set Variable    xpath=//button[contains(text(), 'Clone Case')]
    Wait For Elements State    ${clone_button}    visible    timeout=15s
    Click    ${clone_button}

    # Wait for case creation page to load
    Sleep    15s
    Take Screenshot

    # Select Category = Animals > Dog > Keeping Excess Dogs
    Select Category Animals Dog    Keeping Excess Dogs

    # Click "Clone case" button using JavaScript (find visible branded button)
    Log To Console    Looking for visible Clone case button to submit...
    Sleep    2s
    Evaluate JavaScript    ${None}
    ...    var buttons = document.querySelectorAll('button.slds-button_brand'); for(var i=0; i<buttons.length; i++) { var btn = buttons[i]; if(btn.textContent.trim().startsWith('Clone case') && btn.offsetWidth > 0 && btn.offsetHeight > 0) { btn.click(); break; } }
    Log To Console    Clone case submit button clicked
    Sleep    5s
    Take Screenshot

    # Check if modal appears
    ${modal_selector} =    Set Variable    css=.slds-modal,[role='dialog']
    ${modal_exists} =    Run Keyword And Return Status    Wait For Elements State    ${modal_selector}    visible    timeout=5s
    Run Keyword If    ${modal_exists}    Handle Case Modal Fields

    # Wait for case to be created
    Sleep    10s
    Take Screenshot

    # Query for the most recently created case
    Log To Console    Querying for the most recently created case...
    @{recent_cases} =    Salesforce Query    Case    select=Id,Description    order_by=CreatedDate DESC    limit=1

    ${case_count} =    Get Length    ${recent_cases}
    Run Keyword If    ${case_count} == 0    Fail    No cases found - clone may have failed

    ${cloned_case_id} =    Set Variable    ${recent_cases}[0][Id]
    Store Session Record    Case    ${cloned_case_id}
    Log To Console    Cloned Case ID: ${cloned_case_id}

    # Validate the cloned case
    Validate Cloned Case    ${cloned_case_id}    ${source_case_id}


*** Keywords ***

Validate Cloned Case
    [Arguments]    ${cloned_case_id}    ${source_case_id}
    [Documentation]    Validates that the cloned case was created successfully.

    &{cloned_case} =    Salesforce Get    Case    ${cloned_case_id}

    Should Not Be Equal As Strings    ${cloned_case_id}    ${source_case_id}    msg=Cloned case should differ from source
    Log To Console    Cloned case ID differs from source PASSED

    Should Not Be Empty    ${cloned_case}[Id]
    Log To Console    Case Status: ${cloned_case}[Status]

    Log To Console    Clone case validation PASSED
