*** Settings ***

Resource        ../resources/playwright_common.robot
Resource        ../resources/test_data.robot

Suite Setup     Open Test Browser With Video


*** Test Cases ***

Restrict Visibility Of A Complaint Case
    [Documentation]
    ...  CFSUITE-SR-068 (CoM-Test-088) - Restricted Access to complaints.
    ...  Verifies the API contract: a complaint-flavoured case can be
    ...  marked Confidential=Yes and the value persists.
    ...
    ...  Full sharing-rule verification (case visible only to a complaint
    ...  group) requires multi-user testing - out of scope at this level
    ...  but captured in CFSUITE-SR-062 which marks the linked Request
    ...  Flow as Confidential + Restricted_Page_Access.

    ${case_id} =    Salesforce Insert    Case
    ...    Subject=${TEST_RECORD_PREFIX}SR-068 restricted complaint
    ...    Status=New
    ...    Origin=Web
    ...    cfsuite1__cfReq_Category__c=Complaint
    Log To Console    Created complaint case ${case_id}

    # Flip Confidential to Yes
    Salesforce Update    Case    ${case_id}    cfsuite1__Confidential__c=Yes

    &{case} =    Salesforce Get    Case    ${case_id}
    Should Be Equal    ${case}[cfsuite1__Confidential__c]    Yes
    Should Be Equal    ${case}[cfsuite1__cfReq_Category__c]    Complaint
    Log To Console    Complaint case marked Confidential=Yes

    Salesforce Delete    Case    ${case_id}
