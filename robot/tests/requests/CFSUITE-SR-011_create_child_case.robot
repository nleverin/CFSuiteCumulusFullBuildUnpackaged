*** Settings ***

Resource        ../resources/playwright_common.robot

Suite Setup     Open Test Browser With Video
# Suite Teardown  Delete Records and Close Browser


*** Test Cases ***

Create Child Case Without Parent Description
    [Documentation]
    ...  Test opens an existing Case, clicks "Create Child Case",
    ...  selects category options, unchecks "Bring Parent Description",
    ...  sets custom description, and validates the child case is created
    ...  with correct ParentId and Description fields.

    # Query for an existing Case to use as parent
    Log To Console    Querying for existing cases...
    @{cases} =    Salesforce Query    Case    select=Id    limit=1

    ${case_count} =    Get Length    ${cases}
    Run Keyword If    ${case_count} == 0    Fail    No existing cases found in org.

    ${parent_case_id} =    Set Variable    ${cases}[0][Id]
    Set Test Variable    ${PARENT_CASE_ID}    ${parent_case_id}
    Log To Console    Parent case ID: ${parent_case_id}

    # Navigate to parent case detail page
    Navigate To Record    ${parent_case_id}
    Take Screenshot

    # Click "Create Child Case" link
    Log To Console    Looking for Create Child Case link...
    ${child_link} =    Set Variable    xpath=//a[contains(text(), 'Create Child Case')]
    Wait For Elements State    ${child_link}    visible    timeout=15s
    Click    ${child_link}

    # Wait for case creation page to load
    Sleep    15s
    Take Screenshot

    # Select Category = Animals > Dog > Keeping Excess Dogs
    Select Category Animals Dog    Keeping Excess Dogs

    # Uncheck "Bring Parent Description" checkbox
    Log To Console    Looking for Bring Parent Description checkbox...
    ${checkbox_selector} =    Set Variable    xpath=//input[@type='checkbox'][following-sibling::label//span[contains(text(), 'Bring Parent Description')]]
    ${checkbox_exists} =    Run Keyword And Return Status    Wait For Elements State    ${checkbox_selector}    visible    timeout=10s
    Run Keyword If    ${checkbox_exists}    Evaluate JavaScript    ${None}
    ...    var cb = document.querySelector("input[type='checkbox']"); if(cb && cb.checked) cb.click();
    Sleep    1s
    Take Screenshot

    # Set description
    Log To Console    Setting description...
    ${description_selector} =    Set Variable    xpath=//textarea[@placeholder='DESCRIPTION' or contains(@name, 'input')]
    Wait For Elements State    ${description_selector}    visible    timeout=10s
    Fill Text    ${description_selector}    This is the description
    Sleep    1s
    Take Screenshot

    # Click Create Case button
    ${create_button} =    Set Variable    xpath=//button[contains(text(), 'Create case')]
    Wait For Elements State    ${create_button}    enabled    timeout=20s
    Click    ${create_button}
    Sleep    5s
    Take Screenshot

    # Check if modal appears
    ${modal_selector} =    Set Variable    css=.slds-modal,[role='dialog']
    ${modal_exists} =    Run Keyword And Return Status    Wait For Elements State    ${modal_selector}    visible    timeout=5s
    Run Keyword If    ${modal_exists}    Handle Case Modal Fields

    # Wait for navigation to child case detail page
    Sleep    10s
    Take Screenshot

    # Get the child case ID
    ${child_case_id} =    Get Current Record Id
    Store Session Record    Case    ${child_case_id}
    Log To Console    Child Case ID: ${child_case_id}

    # Validate the child case via API
    Validate Child Case    ${child_case_id}    ${parent_case_id}    This is the description

    # Store child case ID for next test
    Set Suite Variable    ${FIRST_CHILD_CASE_ID}    ${child_case_id}


Create Child Case With Parent Description
    [Documentation]
    ...  Test creates a second child case from the first child case,
    ...  checks "Bring Parent Description", does not set description manually,
    ...  and validates the description is inherited from parent.

    ${new_parent_case_id} =    Set Variable    ${FIRST_CHILD_CASE_ID}
    Log To Console    Creating child from case: ${new_parent_case_id}

    Navigate To Record    ${new_parent_case_id}
    Take Screenshot

    # Click "Create Child Case" link
    ${child_link} =    Set Variable    xpath=//a[contains(text(), 'Create Child Case')]
    Wait For Elements State    ${child_link}    visible    timeout=15s
    Click    ${child_link}
    Sleep    15s
    Take Screenshot

    # Select Category = Animals > Dog > Keeping Excess Dogs
    Select Category Animals Dog    Keeping Excess Dogs

    # CHECK "Bring Parent Description" checkbox
    ${checkbox_selector} =    Set Variable    xpath=//input[@type='checkbox'][following-sibling::label//span[contains(text(), 'Bring Parent Description')]]
    Wait For Elements State    ${checkbox_selector}    visible    timeout=10s
    Evaluate JavaScript    ${None}
    ...    var cb = document.querySelector("input[type='checkbox']"); if(cb && !cb.checked) cb.click();
    Sleep    1s
    Take Screenshot

    # Click Create Case button
    ${create_button} =    Set Variable    xpath=//button[contains(text(), 'Create case')]
    Wait For Elements State    ${create_button}    enabled    timeout=20s
    Click    ${create_button}
    Sleep    5s
    Take Screenshot

    # Check if modal appears
    ${modal_selector} =    Set Variable    css=.slds-modal,[role='dialog']
    ${modal_exists} =    Run Keyword And Return Status    Wait For Elements State    ${modal_selector}    visible    timeout=5s
    Run Keyword If    ${modal_exists}    Handle Case Modal Fields

    # Wait for navigation
    Sleep    10s
    Take Screenshot

    ${second_child_case_id} =    Get Current Record Id
    Store Session Record    Case    ${second_child_case_id}
    Log To Console    Second Child Case ID: ${second_child_case_id}

    # Validate - description should be inherited
    Validate Child Case    ${second_child_case_id}    ${new_parent_case_id}    This is the description


*** Keywords ***

Validate Child Case
    [Arguments]    ${child_case_id}    ${expected_parent_id}    ${expected_description}
    [Documentation]    Validates that the child case has the correct ParentId and Description.

    &{child_case} =    Salesforce Get    Case    ${child_case_id}

    Should Be Equal As Strings    ${child_case}[ParentId]    ${expected_parent_id}    msg=ParentId mismatch
    Log To Console    ParentId: ${child_case}[ParentId] PASSED

    Should Be Equal As Strings    ${child_case}[Description]    ${expected_description}    msg=Description mismatch
    Log To Console    Description: ${child_case}[Description] PASSED

    Log To Console    All child case validations PASSED
