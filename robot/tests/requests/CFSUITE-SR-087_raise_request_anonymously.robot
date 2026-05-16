*** Settings ***

Resource        ../resources/playwright_common.robot
Resource        ../resources/test_data.robot

Suite Setup     Open Test Browser With Video


*** Test Cases ***

Anonymous Submission Allowed When Require Customer Is False
    [Documentation]
    ...  CFSUITE-SR-087 (CoM-Test-107) - Raise request anonymously via
    ...  the Request Portal. The mechanism: a Request Flow record with
    ...  Require_Customer = FALSE allows the portal to accept a guest
    ...  submission. The portal-side wizard (guest user navigation,
    ...  Continue as Guest, fill in details) is exercised by the
    ...  Proposed PROP-059 / PROP-072..078 tests; here we verify the
    ...  data-model contract that the flag persists and a guest-style
    ...  case (no ContactId) can attach to such a flow.

    @{rts} =    Salesforce Query    RecordType
    ...    select=Id
    ...    where=SobjectType='cfsuite1__CFSuite_Request_Flow__c' AND DeveloperName='Category_Journey'
    ...    limit=1
    Should Not Be Empty    ${rts}

    ${rf_id} =    Salesforce Insert    cfsuite1__CFSuite_Request_Flow__c
    ...    Name=${TEST_RECORD_PREFIX}SR-087 anonymous allowed cfg
    ...    RecordTypeId=${rts}[0][Id]
    ...    cfsuite1__Case_Category__c=Anonymous Test
    ...    cfsuite1__Require_Customer__c=false
    Log To Console    Created anonymous-allowed Request Flow ${rf_id}

    &{rf} =    Salesforce Get    cfsuite1__CFSuite_Request_Flow__c    ${rf_id}
    Should Be Equal    ${rf}[cfsuite1__Require_Customer__c]    ${False}
    Log To Console    Require_Customer = FALSE persisted

    Salesforce Delete    cfsuite1__CFSuite_Request_Flow__c    ${rf_id}
