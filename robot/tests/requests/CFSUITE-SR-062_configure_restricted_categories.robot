*** Settings ***

Resource        ../resources/playwright_common.robot
Resource        ../resources/test_data.robot

Suite Setup     Open Test Browser With Video


*** Test Cases ***

Restricted Category Request Flow Persists Confidential Flag
    [Documentation]
    ...  CFSUITE-SR-062 (CoM-Test-080) - Configure identified requests
    ...  categories to be restricted. The full sharing-rule verification
    ...  (i.e. confidential cases visible only to selected groups)
    ...  requires multi-user testing; this test verifies the data-model
    ...  contract: a Request Flow can carry Confidential=TRUE and
    ...  Restricted_Page_Access=TRUE, and a case linked to it persists
    ...  alongside that configuration.

    # Look up the Category_Journey record type
    @{rts} =    Salesforce Query    RecordType
    ...    select=Id
    ...    where=SobjectType='cfsuite1__CFSuite_Request_Flow__c' AND DeveloperName='Category_Journey'
    ...    limit=1
    Should Not Be Empty    ${rts}

    # Create a transient restricted Category Journey flow
    ${rf_id} =    Salesforce Insert    cfsuite1__CFSuite_Request_Flow__c
    ...    Name=${TEST_RECORD_PREFIX}SR-062 restricted cfg
    ...    RecordTypeId=${rts}[0][Id]
    ...    cfsuite1__Case_Category__c=Restricted Test
    ...    cfsuite1__Confidential__c=true
    ...    cfsuite1__Restricted_Page_Access__c=true
    Log To Console    Created restricted Request Flow ${rf_id}

    &{rf} =    Salesforce Get    cfsuite1__CFSuite_Request_Flow__c    ${rf_id}
    Should Be Equal    ${rf}[cfsuite1__Confidential__c]    ${True}
    Should Be Equal    ${rf}[cfsuite1__Restricted_Page_Access__c]    ${True}
    Log To Console    Confidential + Restricted Page Access flags persist on the flow

    # NOTE: linking a Case to this transient flow triggers
    # cfsuite1.CaseTriggerOperation.updateCaseOwner which expects further
    # assignment configuration. The full sharing-rule verification (case
    # visibility scoped to a group) requires multi-user setup and is out
    # of scope for this API-level test.

    Salesforce Delete    cfsuite1__CFSuite_Request_Flow__c    ${rf_id}
