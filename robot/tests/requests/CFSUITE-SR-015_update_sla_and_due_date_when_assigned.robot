*** Settings ***

Resource        ../resources/playwright_common.robot
Resource        ../resources/test_data.robot

Suite Setup     Open Test Browser With Video


*** Test Cases ***

Update SLA Updates Original Due Date On Case
    [Documentation]
    ...  CFSUITE-SR-015 (CoM-Test-029) - Update SLA and Due Date when
    ...  Assigned. The full UI-driven recalc (assign -> SLA -> Due Date)
    ...  is exercised by CFSUITE-SR-034. This test verifies the API
    ...  contract: when SLA is set to a value and the Original Due Date
    ...  is updated alongside it, both fields persist together.
    ...
    ...  Auto-calc of Original_Due_Date from SLA only fires for cases
    ...  created via the CFSuite Request Flow path - bare API inserts
    ...  don't trigger it. See documentation/test-data-strategy.md.

    ${case_id} =    Salesforce Insert    Case
    ...    Subject=${TEST_RECORD_PREFIX}SR-015 sla due date update
    ...    Status=New
    ...    Origin=Web
    Log To Console    Created case ${case_id}

    # SLA values 1-5 are accepted on every default Case record type we
    # checked. Higher values (7, 10) are record-type-restricted.
    ${initial_due} =    Evaluate
    ...    (__import__('datetime').date.today() + __import__('datetime').timedelta(days=2)).isoformat()
    Salesforce Update    Case    ${case_id}
    ...    cfsuite1__SLA__c=2
    ...    cfsuite1__Original_Due_Date__c=${initial_due}

    &{case_initial} =    Salesforce Get    Case    ${case_id}
    Should Be Equal    ${case_initial}[cfsuite1__SLA__c]    2
    Should Be Equal    ${case_initial}[cfsuite1__Original_Due_Date__c]    ${initial_due}

    # Simulate assignment moving to a longer SLA - both fields update together
    ${revised_due} =    Evaluate
    ...    (__import__('datetime').date.today() + __import__('datetime').timedelta(days=5)).isoformat()
    Salesforce Update    Case    ${case_id}
    ...    cfsuite1__SLA__c=5
    ...    cfsuite1__Original_Due_Date__c=${revised_due}

    &{case_revised} =    Salesforce Get    Case    ${case_id}
    Should Be Equal    ${case_revised}[cfsuite1__SLA__c]    5
    Should Be Equal    ${case_revised}[cfsuite1__Original_Due_Date__c]    ${revised_due}
    Log To Console    SLA 2 -> 5, Due Date ${initial_due} -> ${revised_due}

    Salesforce Delete    Case    ${case_id}
