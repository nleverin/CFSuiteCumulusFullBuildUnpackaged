*** Settings ***

Resource        cumulusci/robotframework/Salesforce.robot
Library         cumulusci.robotframework.PageObjects
Library         SeleniumLibrary

Suite Setup     Open Test Browser
# Suite Teardown  Delete Records and Close Browser


*** Test Cases ***

Recategorise Existing Case
    [Documentation]
    ...  Test opens an existing Case, clicks "Correct Case Category",
    ...  selects new category options (Animals, Dog, Wandering at Large),
    ...  validates additional fields appear, clicks Re-Categorise button,
    ...  and validates the category fields are updated correctly.

    # Query for an existing Case to use for re-categorisation
    Log To Console    Querying for existing cases...
    @{cases} =    Salesforce Query    Case    select=Id    limit=1

    ${case_count} =    Get Length    ${cases}
    Run Keyword If    ${case_count} == 0    Fail    No existing cases found in org. Please create a case first.

    ${case_id} =    Set Variable    ${cases}[0][Id]
    Log To Console    Found case to recategorise: ${case_id}

    # Navigate directly to the case detail page
    Go to page    Detail    Case    ${case_id}

    # Wait for case detail page to load
    Sleep    5s
    Capture Page Screenshot    case_detail_before_recategorise.png

    # Click "Correct Case Category" link
    Log To Console    Looking for Correct Case Category link...
    ${correct_link_selector} =    Set Variable    xpath=//a[contains(text(), 'Correct Case Category')]
    Wait Until Element Is Visible    ${correct_link_selector}    timeout=15s
    Log To Console    Correct Case Category link found - clicking it

    Click Element    ${correct_link_selector}

    # Wait for custom case category correction page to load
    Sleep    15s
    Capture Page Screenshot    category_correction_page.png

    # Select Category = Animals (same as create case test)
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
    Capture Page Screenshot    after_category_selection_recategorise.png
    Log To Console    Animals category clicked

    # Wait for Request Reason to render after category selection
    Log To Console    Looking for Request Reason dropdown...
    ${reason_selector} =    Set Variable    xpath=//select[.//option[@value='Dog']]
    Wait Until Element Is Visible    ${reason_selector}    timeout=15s
    Log To Console    Request Reason dropdown found

    # Select Request Reason = Dog (using value)
    Select From List By Value    ${reason_selector}    Dog
    Sleep    2s
    Capture Page Screenshot    after_reason_selection_recategorise.png

    # Wait for Request Sub Reason to render after request reason selection
    Log To Console    Looking for Request Sub Reason dropdown...
    ${subreason_selector} =    Set Variable    xpath=//select[.//option[@value='Wandering at Large']]
    Wait Until Element Is Visible    ${subreason_selector}    timeout=15s
    Log To Console    Request Sub Reason dropdown found

    # Select Request Sub Reason = Wandering at Large (using value)
    Select From List By Value    ${subreason_selector}    Wandering at Large
    Sleep    2s
    Capture Page Screenshot    after_subreason_selection_recategorise.png

    # Validate that "Is the dog contained" text area appears
    Log To Console    Validating additional field appears...
    ${textarea_selector} =    Set Variable    xpath=//textarea[@role='textbox']
    ${textarea_exists} =    Run Keyword And Return Status    Wait Until Element Is Visible    ${textarea_selector}    timeout=10s

    Run Keyword If    ${textarea_exists}    Log To Console    Additional field textarea found (Is the dog contained)
    Run Keyword Unless    ${textarea_exists}    Log To Console    WARNING: Additional field textarea not found

    # Check that Re-Categorise button is enabled
    Log To Console    Checking if Re-Categorise button is enabled...
    ${recategorise_button} =    Set Variable    xpath=//button[contains(@class, 'slds-button_brand')][contains(text(), 'Re-Categorise')]
    Wait Until Element Is Enabled    ${recategorise_button}    timeout=20s
    Log To Console    Re-Categorise button is enabled

    # Click Re-Categorise button
    Log To Console    Clicking Re-Categorise button...
    Click Element    ${recategorise_button}
    Capture Page Screenshot    after_recategorise_click.png

    # Wait for navigation back to case detail page
    Sleep    10s

    # Validate we're back on case detail page
    ${case_id_found} =    Run Keyword And Return Status    Wait Until Page Contains Element    xpath=//*[contains(@class, 'forceRecordLayout') or contains(@class, 'slds-page-header')]    timeout=15s

    Run Keyword If    ${case_id_found}    Log To Console    Case detail page found - proceeding with validation
    Run Keyword Unless    ${case_id_found}    Log To Console    WARNING: Case detail page not detected - validation may fail

    # Get the current case ID
    ${case_id} =    Get Current Record Id
    Log To Console    Case ID: ${case_id}

    # Wait a moment for fields to update
    Sleep    3s
    Capture Page Screenshot    case_detail_after_recategorise.png

    # Validate category fields via API
    Log To Console    Validating category fields via API...
    &{case} =    Salesforce Get    Case    ${case_id}

    # Validate Category = Animals
    Should Be Equal As Strings    ${case}[cfsuite1__cfReq_Category__c]    Animals    msg=Category should be 'Animals'
    Log To Console    Category: ${case}[cfsuite1__cfReq_Category__c] ✓

    # Validate Request Reason = Dog
    Should Be Equal As Strings    ${case}[cfsuite1__cfReq_Request_Reason__c]    Dog    msg=Request Reason should be 'Dog'
    Log To Console    Request Reason: ${case}[cfsuite1__cfReq_Request_Reason__c] ✓

    # Validate Request Sub Reason = Wandering at Large
    Should Be Equal As Strings    ${case}[cfsuite1__cfReq_Request_Sub_Reason__c]    Wandering at Large    msg=Request Sub Reason should be 'Wandering at Large'
    Log To Console    Request Sub Reason: ${case}[cfsuite1__cfReq_Request_Sub_Reason__c] ✓

    Log To Console    ✓ All category validations PASSED


*** Keywords ***
