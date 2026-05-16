*** Settings ***

Resource        ../resources/playwright_common.robot
Resource        ../resources/test_data.robot

Suite Setup     Open Test Browser With Video


*** Test Cases ***

Require Customer Flag Persists On Request Flow
    [Documentation]
    ...  CFSUITE-SR-079 (CoM-Test-099) - Restrict user to submit a
    ...  request. The mechanism: a Request Flow record with
    ...  Require_Customer = TRUE forces the portal to require a
    ...  logged-in customer before the user can submit. The portal-side
    ...  enforcement (login required, can't submit as guest) is a
    ...  community-UI test; here we verify the data-model contract that
    ...  the flag persists on a Category Journey flow.

    @{rts} =    Salesforce Query    RecordType
    ...    select=Id
    ...    where=SobjectType='cfsuite1__CFSuite_Request_Flow__c' AND DeveloperName='Category_Journey'
    ...    limit=1
    Should Not Be Empty    ${rts}

    ${rf_id} =    Salesforce Insert    cfsuite1__CFSuite_Request_Flow__c
    ...    Name=${TEST_RECORD_PREFIX}SR-079 login required cfg
    ...    RecordTypeId=${rts}[0][Id]
    ...    cfsuite1__Case_Category__c=Login Required Test
    ...    cfsuite1__Require_Customer__c=true
    Log To Console    Created restricted-to-login Request Flow ${rf_id}

    &{rf} =    Salesforce Get    cfsuite1__CFSuite_Request_Flow__c    ${rf_id}
    Should Be Equal    ${rf}[cfsuite1__Require_Customer__c]    ${True}
    Log To Console    Require_Customer = TRUE persisted

    Salesforce Delete    cfsuite1__CFSuite_Request_Flow__c    ${rf_id}
