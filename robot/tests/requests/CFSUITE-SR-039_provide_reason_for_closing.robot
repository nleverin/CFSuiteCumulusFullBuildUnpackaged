*** Settings ***

Resource        ../resources/playwright_common.robot
Resource        ../resources/test_data.robot

Suite Setup     Open Test Browser With Video


*** Test Cases ***

Provide Reason When Closing A Case
    [Documentation]
    ...  CFSUITE-SR-039 (CoM-Test-053) - Provide Reason for Closing Requests.
    ...  Verifies that a Close Reason picklist value can be set on a Case
    ...  alongside Status=Closed, and the values persist on the record.

    ${case_id} =    Salesforce Insert    Case
    ...    Subject=${TEST_RECORD_PREFIX}SR-039 close reason
    ...    Status=New
    ...    Origin=Web
    Log To Console    Created case ${case_id}

    Salesforce Update    Case    ${case_id}
    ...    Status=Closed
    ...    cfsuite1__Close_Reason__c=Duplicate Request

    &{case} =    Salesforce Get    Case    ${case_id}
    Should Be Equal    ${case}[Status]    Closed
    Should Be Equal    ${case}[cfsuite1__Close_Reason__c]    Duplicate Request
    Log To Console    Closed case with reason 'Duplicate Request'

    Salesforce Delete    Case    ${case_id}
