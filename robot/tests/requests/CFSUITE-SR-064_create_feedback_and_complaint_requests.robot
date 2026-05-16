*** Settings ***

Resource        ../resources/playwright_common.robot
Resource        ../resources/test_data.robot

Suite Setup     Open Test Browser With Video


*** Test Cases ***

Create Feedback Cases For Each Sub Type
    [Documentation]
    ...  CFSUITE-SR-064 (CoM-Test-084) - Create feedback and complaint
    ...  requests. Verifies that three cases can be created representing
    ...  the sub-types Comment / Complaint / Compliment - tagged via the
    ...  cfReq_Category and Subject fields - and each persists as
    ...  queryable.
    ...
    ...  Note: this org has no dedicated Complaint record type. The
    ...  sub-type is recorded textually until a metadata-level complaint
    ...  model is introduced.

    @{sub_types} =    Create List    Comment    Complaint    Compliment
    @{case_ids} =    Create List

    FOR    ${sub_type}    IN    @{sub_types}
        ${case_id} =    Salesforce Insert    Case
        ...    Subject=${TEST_RECORD_PREFIX}SR-064 ${sub_type}
        ...    Status=New
        ...    Origin=Web
        ...    cfsuite1__cfReq_Category__c=Feedback - ${sub_type}
        Append To List    ${case_ids}    ${case_id}
        Log To Console    Created ${sub_type} case ${case_id}
    END

    # Verify all 3 are present and tagged correctly
    FOR    ${i}    IN RANGE    3
        ${case_id} =    Set Variable    ${case_ids}[${i}]
        ${sub_type} =    Set Variable    ${sub_types}[${i}]
        &{case} =    Salesforce Get    Case    ${case_id}
        Should Be Equal    ${case}[cfsuite1__cfReq_Category__c]    Feedback - ${sub_type}
        Should Contain    ${case}[Subject]    ${sub_type}
    END
    Log To Console    All 3 feedback sub-types persisted

    # Cleanup
    FOR    ${case_id}    IN    @{case_ids}
        Salesforce Delete    Case    ${case_id}
    END
