*** Settings ***

Resource        ../resources/playwright_common.robot
Resource        ../resources/test_data.robot

Suite Setup     Open Test Browser With Video


*** Test Cases ***

Deflection Text Configured On Display Category Persists
    [Documentation]
    ...  CFSUITE-SR-002 (CoM-Test-016) - Deflection when creating a request
    ...  category. The full UI behaviour (popup shown, no case created)
    ...  requires the case-creation UI; this test verifies the data-model
    ...  contract: a Display_Category Request Flow record can be created
    ...  with Deflection_Text populated, and that text persists.

    # Look up the Display_Category record type ID for Request Flow
    @{rts} =    Salesforce Query    RecordType
    ...    select=Id
    ...    where=SobjectType='cfsuite1__CFSuite_Request_Flow__c' AND DeveloperName='Display_Category'
    ...    limit=1
    Should Not Be Empty    ${rts}    msg=Display_Category record type missing on Request Flow

    ${rf_id} =    Salesforce Insert    cfsuite1__CFSuite_Request_Flow__c
    ...    Name=${TEST_RECORD_PREFIX}SR-002 deflection cfg
    ...    RecordTypeId=${rts}[0][Id]
    ...    cfsuite1__Case_Category__c=Deflection Test
    ...    cfsuite1__Deflection_Text__c=Please call the council reception on 1234 5678 for this enquiry.
    Log To Console    Created Request Flow ${rf_id}

    &{rf} =    Salesforce Get    cfsuite1__CFSuite_Request_Flow__c    ${rf_id}
    Should Contain    ${rf}[cfsuite1__Deflection_Text__c]    council reception
    Log To Console    Deflection text persisted

    Salesforce Delete    cfsuite1__CFSuite_Request_Flow__c    ${rf_id}
