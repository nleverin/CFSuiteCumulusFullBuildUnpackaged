*** Settings ***

Resource        cumulusci/robotframework/Salesforce.robot
Library         cumulusci.robotframework.PageObjects
Library         SeleniumLibrary

Suite Setup     Open Test Browser
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
    Run Keyword If    ${case_count} == 0    Fail    No existing cases found in org. Please create a case first.

    ${parent_case_id} =    Set Variable    ${cases}[0][Id]
    Set Test Variable    ${PARENT_CASE_ID}    ${parent_case_id}
    Log To Console    Parent case ID: ${parent_case_id}

    # Navigate directly to the parent case detail page
    Go to page    Detail    Case    ${parent_case_id}

    # Wait for case detail page to load
    Sleep    5s
    Capture Page Screenshot    parent_case_detail.png

    # Click "Create Child Case" link
    Log To Console    Looking for Create Child Case link...
    ${child_link_selector} =    Set Variable    xpath=//a[contains(text(), 'Create Child Case')]
    Wait Until Element Is Visible    ${child_link_selector}    timeout=15s
    Log To Console    Create Child Case link found - clicking it

    Click Element    ${child_link_selector}

    # Wait for case creation page to load
    Sleep    15s
    Capture Page Screenshot    child_case_creation_page.png

    # Select Category = Animals
    Log To Console    Looking for Category element...
    Wait Until Element Is Visible    id=category_0    timeout=10s
    Log To Console    Category element found

    Execute Javascript    document.getElementById('category_0').scrollIntoView({behavior: 'smooth', block: 'center'})
    Sleep    1s

    Log To Console    Clicking on Animals category...
    Click Element    id=category_0
    Sleep    3s
    Capture Page Screenshot    after_category_selection_child.png
    Log To Console    Animals category clicked

    # Select Request Reason = Dog
    Log To Console    Looking for Request Reason dropdown...
    ${reason_selector} =    Set Variable    xpath=//select[.//option[@value='Dog']]
    Wait Until Element Is Visible    ${reason_selector}    timeout=15s
    Log To Console    Request Reason dropdown found

    Select From List By Value    ${reason_selector}    Dog
    Sleep    2s
    Capture Page Screenshot    after_reason_selection_child.png

    # Select Request Sub Reason = Keeping Excess Dogs
    Log To Console    Looking for Request Sub Reason dropdown...
    ${subreason_selector} =    Set Variable    xpath=//select[.//option[@value='Keeping Excess Dogs']]
    Wait Until Element Is Visible    ${subreason_selector}    timeout=15s
    Log To Console    Request Sub Reason dropdown found

    Select From List By Value    ${subreason_selector}    Keeping Excess Dogs
    Sleep    2s
    Capture Page Screenshot    after_subreason_selection_child.png

    # Uncheck "Bring Parent Description" checkbox
    Log To Console    Looking for Bring Parent Description checkbox...
    ${checkbox_selector} =    Set Variable    xpath=//input[@type='checkbox'][following-sibling::label//span[contains(text(), 'Bring Parent Description')]]
    ${checkbox_exists} =    Run Keyword And Return Status    Wait Until Element Is Visible    ${checkbox_selector}    timeout=10s

    Run Keyword If    ${checkbox_exists}    Log To Console    Bring Parent Description checkbox found
    Run Keyword Unless    ${checkbox_exists}    Log To Console    WARNING: Bring Parent Description checkbox not found

    ${is_checked} =    Run Keyword If    ${checkbox_exists}    Run Keyword And Return Status    Checkbox Should Be Selected    ${checkbox_selector}
    Run Keyword If    ${checkbox_exists} and ${is_checked}    Log To Console    Checkbox is checked - unchecking it with JavaScript
    Run Keyword If    ${checkbox_exists} and ${is_checked}    Execute Javascript    var xpath = "//input[@type='checkbox'][following-sibling::label//span[contains(text(), 'Bring Parent Description')]]"; var checkbox = document.evaluate(xpath, document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue; if(checkbox) checkbox.click();
    Run Keyword If    ${checkbox_exists} and ${is_checked}    Sleep    1s
    Capture Page Screenshot    after_checkbox_uncheck.png

    # Set description to "This is the description"
    Log To Console    Setting description...
    ${description_selector} =    Set Variable    xpath=//textarea[@placeholder='DESCRIPTION' or contains(@name, 'input')]
    Wait Until Element Is Visible    ${description_selector}    timeout=10s
    Input Text    ${description_selector}    This is the description
    Sleep    1s
    Capture Page Screenshot    after_description_entry.png
    Log To Console    Description set

    # Wait for Create Case button to be enabled and click it
    Log To Console    Checking if Create Case button is enabled...
    ${create_button} =    Set Variable    xpath=//button[contains(text(), 'Create case')]
    Wait Until Element Is Enabled    ${create_button}    timeout=20s
    Log To Console    Create Case button is enabled

    Click Element    ${create_button}
    Sleep    5s
    Capture Page Screenshot    after_create_button_click.png

    # Check if modal appears
    ${modal_selector} =    Set Variable    xpath=//*[contains(@class, 'slds-modal') or @role='dialog']
    ${modal_exists} =    Run Keyword And Return Status    Wait Until Page Contains Element    ${modal_selector}    timeout=5s

    Run Keyword If    ${modal_exists}    Log To Console    Modal found - filling fields
    Run Keyword If    ${modal_exists}    Handle Modal Fields And Validate Description    This is the description
    Run Keyword Unless    ${modal_exists}    Log To Console    No modal found

    # Wait for navigation to child case detail page
    Sleep    10s
    Capture Page Screenshot    child_case_created.png

    # Get the child case ID
    ${child_case_id} =    Get Current Record Id
    Store Session Record    Case    ${child_case_id}
    Log To Console    Child Case ID: ${child_case_id}

    # Validate the child case via API
    Validate Child Case    ${child_case_id}    ${parent_case_id}    This is the description

    # Store child case ID for next test (use Suite Variable to share between tests)
    Set Suite Variable    ${FIRST_CHILD_CASE_ID}    ${child_case_id}


Create Child Case With Parent Description
    [Documentation]
    ...  Test creates a second child case from the first child case,
    ...  checks "Bring Parent Description", does not set description manually,
    ...  and validates the description is inherited from parent.

    # Use the child case from the previous test as the new parent
    ${new_parent_case_id} =    Set Variable    ${FIRST_CHILD_CASE_ID}
    Log To Console    Creating child from case: ${new_parent_case_id}

    # Navigate to the first child case (now the parent)
    Go to page    Detail    Case    ${new_parent_case_id}
    Sleep    5s
    Capture Page Screenshot    second_parent_case_detail.png

    # Click "Create Child Case" link
    Log To Console    Looking for Create Child Case link...
    ${child_link_selector} =    Set Variable    xpath=//a[contains(text(), 'Create Child Case')]
    Wait Until Element Is Visible    ${child_link_selector}    timeout=15s
    Log To Console    Create Child Case link found - clicking it

    Click Element    ${child_link_selector}
    Sleep    15s
    Capture Page Screenshot    second_child_case_creation_page.png

    # Select Category = Animals
    Log To Console    Selecting category...
    Wait Until Element Is Visible    id=category_0    timeout=10s
    Execute Javascript    document.getElementById('category_0').scrollIntoView({behavior: 'smooth', block: 'center'})
    Sleep    1s
    Click Element    id=category_0
    Sleep    3s

    # Select Request Reason = Dog
    ${reason_selector} =    Set Variable    xpath=//select[.//option[@value='Dog']]
    Wait Until Element Is Visible    ${reason_selector}    timeout=15s
    Select From List By Value    ${reason_selector}    Dog
    Sleep    2s

    # Select Request Sub Reason = Keeping Excess Dogs
    ${subreason_selector} =    Set Variable    xpath=//select[.//option[@value='Keeping Excess Dogs']]
    Wait Until Element Is Visible    ${subreason_selector}    timeout=15s
    Select From List By Value    ${subreason_selector}    Keeping Excess Dogs
    Sleep    2s

    # CHECK "Bring Parent Description" checkbox (opposite of first test)
    Log To Console    Looking for Bring Parent Description checkbox...
    ${checkbox_selector} =    Set Variable    xpath=//input[@type='checkbox'][following-sibling::label//span[contains(text(), 'Bring Parent Description')]]
    Wait Until Element Is Visible    ${checkbox_selector}    timeout=10s
    Log To Console    Bring Parent Description checkbox found

    ${is_checked} =    Run Keyword And Return Status    Checkbox Should Be Selected    ${checkbox_selector}
    Run Keyword If    not ${is_checked}    Log To Console    Checkbox is not checked - checking it with JavaScript
    Run Keyword If    not ${is_checked}    Execute Javascript    var xpath = "//input[@type='checkbox'][following-sibling::label//span[contains(text(), 'Bring Parent Description')]]"; var checkbox = document.evaluate(xpath, document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue; if(checkbox) checkbox.click();
    Run Keyword If    not ${is_checked}    Sleep    1s
    Capture Page Screenshot    after_checkbox_check.png

    # DO NOT set description - it should be inherited from parent

    # Wait for Create Case button to be enabled and click it
    Log To Console    Checking if Create Case button is enabled...
    ${create_button} =    Set Variable    xpath=//button[contains(text(), 'Create case')]
    Wait Until Element Is Enabled    ${create_button}    timeout=20s
    Log To Console    Create Case button is enabled

    Click Element    ${create_button}
    Sleep    5s
    Capture Page Screenshot    after_second_create_button_click.png

    # Check if modal appears
    ${modal_selector} =    Set Variable    xpath=//*[contains(@class, 'slds-modal') or @role='dialog']
    ${modal_exists} =    Run Keyword And Return Status    Wait Until Page Contains Element    ${modal_selector}    timeout=5s

    Run Keyword If    ${modal_exists}    Log To Console    Modal found - filling fields
    Run Keyword If    ${modal_exists}    Handle Modal Fields Only
    Run Keyword Unless    ${modal_exists}    Log To Console    No modal found

    # Wait for navigation to second child case detail page
    Sleep    10s
    Capture Page Screenshot    second_child_case_created.png

    # Get the second child case ID
    ${second_child_case_id} =    Get Current Record Id
    Store Session Record    Case    ${second_child_case_id}
    Log To Console    Second Child Case ID: ${second_child_case_id}

    # Validate the second child case - description should be inherited
    Validate Child Case    ${second_child_case_id}    ${new_parent_case_id}    This is the description


*** Keywords ***

Handle Modal Fields And Validate Description
    [Arguments]    ${expected_description}
    [Documentation]
    ...  Handles filling in the modal fields for Case Origin and Notification Method,
    ...  and validates the description field is pre-filled correctly.

    Log To Console    Filling modal fields...
    Capture Page Screenshot    modal_visible_child.png

    # Validate description is pre-filled
    Log To Console    Validating description is pre-filled...
    ${modal_description_selector} =    Set Variable    xpath=//textarea[@name='Description' or @placeholder='Description']
    ${desc_exists} =    Run Keyword And Return Status    Wait Until Element Is Visible    ${modal_description_selector}    timeout=5s

    Run Keyword If    ${desc_exists}    Log To Console    Description field found in modal
    ${actual_description} =    Run Keyword If    ${desc_exists}    Get Value    ${modal_description_selector}
    Run Keyword If    ${desc_exists}    Log To Console    Description in modal: ${actual_description}
    Run Keyword If    ${desc_exists}    Should Be Equal As Strings    ${actual_description}    ${expected_description}    msg=Description should be pre-filled with '${expected_description}'
    Run Keyword If    ${desc_exists}    Log To Console    ✓ Description validation PASSED

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


Handle Modal Fields Only
    [Documentation]
    ...  Handles filling in the modal fields for Case Origin and Notification Method only.

    Log To Console    Filling modal fields...
    Capture Page Screenshot    modal_visible_second_child.png

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


Validate Child Case
    [Arguments]    ${child_case_id}    ${expected_parent_id}    ${expected_description}
    [Documentation]
    ...  Validates that the child case has the correct ParentId and Description.

    Log To Console    Validating child case...

    # Validate via API
    &{child_case} =    Salesforce Get    Case    ${child_case_id}

    # Validate ParentId
    Should Be Equal As Strings    ${child_case}[ParentId]    ${expected_parent_id}    msg=ParentId should be '${expected_parent_id}'
    Log To Console    ParentId: ${child_case}[ParentId] ✓

    # Validate Description
    Should Be Equal As Strings    ${child_case}[Description]    ${expected_description}    msg=Description should be '${expected_description}'
    Log To Console    Description: ${child_case}[Description] ✓

    Log To Console    ✓ All child case validations PASSED
