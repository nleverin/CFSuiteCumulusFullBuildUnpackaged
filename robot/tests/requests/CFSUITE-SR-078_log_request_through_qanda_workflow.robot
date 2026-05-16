*** Settings ***

Resource        ../resources/playwright_common.robot
Resource        ../resources/test_data.robot

Suite Setup     Open Test Browser With Video


*** Test Cases ***

Flow Form Type Request Flow Supports Q And A Configuration
    [Documentation]
    ...  CFSUITE-SR-078 (CoM-Test-098) - Log a Request through Q&A
    ...  Workflow. The Q&A SMARTForm in CFSuite is implemented as a
    ...  Category Journey Request Flow whose Form_Type = 'Flow'. The
    ...  full guest / authenticated walkthrough requires browser
    ...  interaction; this test verifies the data-model contract: a
    ...  Flow-typed Request Flow can be created and queried.

    @{rts} =    Salesforce Query    RecordType
    ...    select=Id
    ...    where=SobjectType='cfsuite1__CFSuite_Request_Flow__c' AND DeveloperName='Category_Journey'
    ...    limit=1
    Should Not Be Empty    ${rts}

    ${rf_id} =    Salesforce Insert    cfsuite1__CFSuite_Request_Flow__c
    ...    Name=${TEST_RECORD_PREFIX}SR-078 q&a cfg
    ...    RecordTypeId=${rts}[0][Id]
    ...    cfsuite1__Case_Category__c=Q&A Test
    ...    cfsuite1__Form_Type__c=Flow
    Log To Console    Created Flow-typed Request Flow ${rf_id}

    &{rf} =    Salesforce Get    cfsuite1__CFSuite_Request_Flow__c    ${rf_id}
    Should Be Equal    ${rf}[cfsuite1__Form_Type__c]    Flow
    Log To Console    Form_Type='Flow' persisted on Category Journey

    Salesforce Delete    cfsuite1__CFSuite_Request_Flow__c    ${rf_id}
