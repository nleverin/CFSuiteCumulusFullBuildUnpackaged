*** Settings ***

Resource        ../resources/playwright_common.robot
Resource        ../resources/test_data.robot

Suite Setup     Open Test Browser With Video


*** Test Cases ***

Provide Completion Comment When Closing A Case
    [Documentation]
    ...  CFSUITE-SR-045 (CoM-Test-059) - Provide Comment when Closing
    ...  Requests. Verifies that cfsuite1__Completion_Comment__c can be
    ...  set in the same update that moves Status to Closed and the
    ...  comment is queryable afterwards.

    ${case_id} =    Salesforce Insert    Case
    ...    Subject=${TEST_RECORD_PREFIX}SR-045 closing comment
    ...    Status=New
    ...    Origin=Web
    Log To Console    Created case ${case_id}

    ${comment} =    Set Variable    Resolved on site; customer was happy with outcome.
    Salesforce Update    Case    ${case_id}
    ...    Status=Closed
    ...    cfsuite1__Close_Reason__c=Work Complete
    ...    cfsuite1__Completion_Comment__c=${comment}

    &{case} =    Salesforce Get    Case    ${case_id}
    Should Be Equal    ${case}[Status]    Closed
    Should Be Equal    ${case}[cfsuite1__Completion_Comment__c]    ${comment}
    Log To Console    Closed case carries completion comment

    Salesforce Delete    Case    ${case_id}
