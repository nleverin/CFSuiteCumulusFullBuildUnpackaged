*** Settings ***

Resource        ../resources/playwright_common.robot
Resource        ../resources/test_data.robot

Suite Setup     Open Test Browser With Video


*** Test Cases ***

Create Complaint Case As Child Of Existing Request
    [Documentation]
    ...  CFSUITE-SR-065 (CoM-Test-085) - Create complaint as child
    ...  against a request. Verifies that a complaint case can be linked
    ...  to an existing parent case via the standard ParentId field, and
    ...  the parent-child relationship is queryable.

    # Parent request
    ${parent_id} =    Salesforce Insert    Case
    ...    Subject=${TEST_RECORD_PREFIX}SR-065 parent request
    ...    Status=New
    ...    Origin=Web
    Log To Console    Created parent case ${parent_id}

    # Child complaint case
    ${child_id} =    Salesforce Insert    Case
    ...    Subject=${TEST_RECORD_PREFIX}SR-065 complaint child
    ...    Status=New
    ...    Origin=Web
    ...    cfsuite1__cfReq_Category__c=Complaint
    ...    ParentId=${parent_id}
    Log To Console    Created complaint child case ${child_id}

    # Verify the linkage
    &{child} =    Salesforce Get    Case    ${child_id}
    Should Be Equal    ${child}[ParentId]    ${parent_id}
    Should Be Equal    ${child}[cfsuite1__cfReq_Category__c]    Complaint
    Log To Console    Child case is linked to parent and tagged as Complaint

    # Cross-check from parent side via query
    @{children} =    Salesforce Query    Case
    ...    select=Id,Subject
    ...    where=ParentId='${parent_id}'
    ${count} =    Get Length    ${children}
    Should Be Equal As Numbers    ${count}    1
    Log To Console    Parent has 1 child complaint case

    Salesforce Delete    Case    ${child_id}
    Salesforce Delete    Case    ${parent_id}
