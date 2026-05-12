*** Settings ***

Resource        ../resources/playwright_common.robot
Resource        ../resources/test_data.robot

Suite Setup     Open Test Browser With Video


*** Test Cases ***

Provide Completion Comment When Closing A Complaint
    [Documentation]
    ...  CFSUITE-SR-067 (CoM-Test-087) - Enforce a comment when closing a
    ...  complaint. Same close-with-comment pattern as SR-045 but on a
    ...  case explicitly flagged as a complaint via Type='Question' OR via
    ...  a complaint-flavoured Subject. Verifies Completion_Comment
    ...  persists on close.
    ...
    ...  Note: full "enforcement" (validation rule) is asserted in the org
    ...  by a Process Builder / validation rule; this test verifies the
    ...  field can be set and persisted on the happy path.

    ${case_id} =    Salesforce Insert    Case
    ...    Subject=${TEST_RECORD_PREFIX}SR-067 complaint about service quality
    ...    Status=New
    ...    Origin=Web
    ...    Type=Question
    Log To Console    Created complaint-flavoured case ${case_id}

    ${comment} =    Set Variable    Complainant contacted, apology delivered, no further action required.
    Salesforce Update    Case    ${case_id}
    ...    Status=Closed
    ...    cfsuite1__Close_Reason__c=Work Complete
    ...    cfsuite1__Completion_Comment__c=${comment}

    &{case} =    Salesforce Get    Case    ${case_id}
    Should Be Equal    ${case}[Status]    Closed
    Should Be Equal    ${case}[cfsuite1__Completion_Comment__c]    ${comment}
    Log To Console    Complaint closed with comment

    Salesforce Delete    Case    ${case_id}
