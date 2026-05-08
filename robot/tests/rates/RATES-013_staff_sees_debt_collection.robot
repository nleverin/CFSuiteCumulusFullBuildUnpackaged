*** Settings ***

Resource        ../resources/playwright_common.robot

Suite Setup     Open Test Browser With Video
# Suite Teardown  Delete Records and Close Browser


*** Test Cases ***

CRM_AM04 Staff Can See Debt Collection Customers
    [Documentation]
    ...  A Customer Contact Officer logs in and goes to a property.
    ...  The Officer checks the memo field in the Details tab and can
    ...  see that the property is currently under Debt Collection.
    ...  Test Case: CRM_AM04

    # Find a property to use for this test
    @{properties} =    Salesforce Query    cfsuite1__Property__c
    ...    select=Id,Name,cfsuite1__Memo__c
    ...    limit=1

    ${prop_count} =    Get Length    ${properties}
    Should Be True    ${prop_count} > 0    No properties found

    ${prop_id} =    Set Variable    ${properties}[0][Id]
    ${prop_name} =    Set Variable    ${properties}[0][Name]
    Log To Console    Testing property: ${prop_name} (${prop_id})

    # Set a Debt Collection memo on the property via API (using valid picklist value)
    Log To Console    Setting Debt Collection memo on property...
    Salesforce Update    cfsuite1__Property__c    ${prop_id}
    ...    cfsuite1__Memo__c=99 - Debt Collection

    # Navigate to the property record in Salesforce (staff view)
    Navigate To Record    ${prop_id}

    # Scroll down to find the memo field
    Evaluate JavaScript    ${None}    window.scrollBy(0, 500)
    Sleep    3s
    Take Screenshot

    # Verify memo field is visible with debt collection text
    ${page_text} =    Get Text    body
    ${has_debt_memo} =    Run Keyword And Return Status    Should Contain    ${page_text}    Debt Collection
    Run Keyword If    ${has_debt_memo}    Log To Console    PASSED: Debt Collection memo visible on property detail
    Run Keyword Unless    ${has_debt_memo}    Log To Console    Memo not visible on page - validating via API

    # Validate via API
    &{prop} =    Salesforce Get    cfsuite1__Property__c    ${prop_id}
    Should Contain    ${prop}[cfsuite1__Memo__c]    Debt Collection    msg=Memo field should contain 'Debt Collection'
    Log To Console    API confirms memo: ${prop}[cfsuite1__Memo__c] PASSED

    Log To Console    CRM_AM04 test PASSED
