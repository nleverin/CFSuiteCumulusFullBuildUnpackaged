*** Settings ***

Resource        ../resources/playwright_common.robot
Resource        ../resources/test_data.robot

Suite Setup     Open Test Browser With Video


*** Test Cases ***

Provide Reason When Due Date Changes
    [Documentation]
    ...  CFSUITE-SR-036 (CoM-Test-050) - Provide Reason for Changes on
    ...  Due Date. Verifies that when a case's due date moves from its
    ...  original value to a revised value, a narrative reason can be
    ...  captured in the Description field and the trio (original /
    ...  revised / reason) persists on the record.
    ...
    ...  Note: enforcement (i.e. preventing the update without a reason)
    ...  is delivered by a validation rule in the managed package. This
    ...  test verifies the happy path; the validation rule would fire on
    ...  an attempt that omits the reason.

    ${case_id} =    Salesforce Insert    Case
    ...    Subject=${TEST_RECORD_PREFIX}SR-036 due-date change reason
    ...    Status=New
    ...    Origin=Web
    Log To Console    Created case ${case_id}

    ${original} =    Evaluate
    ...    (__import__('datetime').date.today() + __import__('datetime').timedelta(days=5)).isoformat()
    Salesforce Update    Case    ${case_id}    cfsuite1__Original_Due_Date__c=${original}

    ${revised} =    Evaluate
    ...    (__import__('datetime').date.today() + __import__('datetime').timedelta(days=12)).isoformat()
    ${reason} =    Set Variable    Customer requested extension due to medical issue.
    Salesforce Update    Case    ${case_id}
    ...    cfsuite1__Revised_Due_Date__c=${revised}
    ...    Description=${reason}

    &{case} =    Salesforce Get    Case    ${case_id}
    Should Be Equal    ${case}[cfsuite1__Original_Due_Date__c]    ${original}
    Should Be Equal    ${case}[cfsuite1__Revised_Due_Date__c]    ${revised}
    Should Be Equal    ${case}[Description]    ${reason}
    Log To Console    Due date ${original} -> ${revised} with narrative captured

    Salesforce Delete    Case    ${case_id}
