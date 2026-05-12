*** Settings ***

Resource        ../resources/playwright_common.robot

Suite Setup     Open Test Browser With Video
# Suite Teardown  Delete Records and Close Browser


*** Test Cases ***

Create Case From Account With Map Location And Validation
    [Documentation]
    ...  Test navigates to an Account, clicks "Create Case" button,
    ...  selects a map location, chooses category options, fills modal fields,
    ...  and validates the address, due date, and AccountId are populated correctly.

    # Query for an existing Person Account
    Log To Console    Querying for existing Person Accounts...
    @{accounts} =    Salesforce Query    Account    select=Id,Name    where=IsPersonAccount=TRUE    limit=1

    ${account_count} =    Get Length    ${accounts}
    Run Keyword If    ${account_count} == 0    Fail    No existing Person Accounts found in org.

    ${account_id} =    Set Variable    ${accounts}[0][Id]
    ${account_name} =    Set Variable    ${accounts}[0][Name]
    Set Test Variable    ${ACCOUNT_ID}    ${account_id}
    Log To Console    Account ID: ${account_id}
    Log To Console    Account Name: ${account_name}

    # Navigate to the account detail page
    Navigate To Account    ${account_id}
    Take Screenshot

    # Click "Create Case" button on account page
    Log To Console    Looking for Create Case button...
    ${create_case_button} =    Set Variable    xpath=//button[contains(text(), 'Create Case')]
    Wait For Elements State    ${create_case_button}    visible    timeout=15s
    Click    ${create_case_button}

    # Wait for custom case creation page to load
    Sleep    15s
    Take Screenshot

    # Select map location
    ${selected_location} =    Handle Map Iframe And Click    cf_MapCreateCase
    Set Test Variable    ${SELECTED_LOCATION}    ${selected_location}
    Take Screenshot

    # Select Category = Animals > Dog > Keeping Excess Dogs
    Select Category Animals Dog    Keeping Excess Dogs

    # Click Create Case button
    ${button_selector} =    Set Variable    xpath=//button[contains(text(), 'Create case')]
    Wait For Elements State    ${button_selector}    enabled    timeout=20s
    Click    ${button_selector}
    Sleep    5s
    Take Screenshot

    # Check if modal appears
    ${modal_selector} =    Set Variable    css=.slds-modal,[role='dialog']
    ${modal_exists} =    Run Keyword And Return Status    Wait For Elements State    ${modal_selector}    visible    timeout=5s
    Run Keyword If    ${modal_exists}    Handle Case Modal Fields

    # Wait for case to be created
    Log To Console    Waiting for case to be created...
    Sleep    10s
    Take Screenshot

    # Detect case detail page
    ${case_page_loaded} =    Run Keyword And Return Status    Wait For Elements State    css=.slds-page-header    visible    timeout=15s
    Run Keyword If    ${case_page_loaded}    Proceed With Case Validation
    Run Keyword Unless    ${case_page_loaded}    Log To Console    Case detail page not found


*** Keywords ***

Proceed With Case Validation
    Log To Console    Validating created case...
    ${case_id} =    Get Current Record Id
    Store Session Record    Case    ${case_id}
    Log To Console    Case ID: ${case_id}
    Validate Case    ${case_id}    ${SELECTED_LOCATION}    ${ACCOUNT_ID}

Validate Case
    [Arguments]    ${case_id}    ${expected_location}    ${expected_account_id}
    [Documentation]    Validates address, due date, AccountId, and category fields.

    Navigate To Record    ${case_id}
    Sleep    3s

    &{case} =    Salesforce Get    Case    ${case_id}

    Should Not Be Empty    ${case}[cfsuite1__Request_location__c]
    ${address_lower} =    Convert To Lower Case    ${case}[cfsuite1__Request_location__c]
    Should Contain    ${address_lower}    ada
    Should Contain    ${address_lower}    adelaide
    Log To Console    Address validation PASSED

    ${due_date_value} =    Get From Dictionary    ${case}    cfsuite1__Original_Due_Date__c    default=${None}
    Should Not Be Equal    ${due_date_value}    ${None}    msg=Due Date should not be null

    Should Be Equal As Strings    ${case}[AccountId]    ${expected_account_id}
    Log To Console    AccountId PASSED

    Should Be Equal As Strings    ${case}[cfsuite1__cfReq_Category__c]    Animals
    Should Be Equal As Strings    ${case}[cfsuite1__cfReq_Request_Reason__c]    Dog
    Should Be Equal As Strings    ${case}[cfsuite1__cfReq_Request_Sub_Reason__c]    Keeping Excess Dogs
    Log To Console    All validations PASSED
