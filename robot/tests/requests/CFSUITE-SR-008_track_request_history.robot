*** Settings ***

Resource        ../resources/playwright_common.robot

Suite Setup     Open Test Browser With Video


*** Test Cases ***

Track Case Field History After Update
    [Documentation]
    ...  CFSUITE-SR-008 (CoM-Test-052) - Track Request History.
    ...  Verifies that updating a tracked Case field produces a CaseHistory
    ...  row visible both via the API and on the record detail page.

    # 1. Create a fresh case
    ${case_id} =    Salesforce Insert    Case
    ...    Subject=CFSUITE-SR-008 history test
    ...    Status=New
    ...    Origin=Web
    Log To Console    Created case ${case_id}

    # 2. Capture history rows count BEFORE the update
    @{history_before} =    Salesforce Query    CaseHistory
    ...    select=Id,Field,OldValue,NewValue
    ...    where=CaseId='${case_id}'
    ${count_before} =    Get Length    ${history_before}

    # 3. Update a known-tracked field on the case (Status is tracked by default)
    Salesforce Update    Case    ${case_id}    Status=Working
    Sleep    3s

    # 4. Re-query history; expect at least one new row referencing Status
    @{history_after} =    Salesforce Query    CaseHistory
    ...    select=Id,Field,OldValue,NewValue
    ...    where=CaseId='${case_id}'
    ${count_after} =    Get Length    ${history_after}
    Should Be True    ${count_after} > ${count_before}
    ...    msg=No new CaseHistory rows after Status update

    ${found_status} =    Set Variable    ${False}
    FOR    ${row}    IN    @{history_after}
        IF    '${row}[Field]' == 'Status'
            ${found_status} =    Set Variable    ${True}
            Log To Console    Status history row: ${row}[OldValue] -> ${row}[NewValue]
        END
    END
    Should Be True    ${found_status}    msg=Expected Status field history row not present

    # 5. Visual check: navigate to the case and confirm the History related list renders
    Navigate To Record    ${case_id}
    Take Screenshot
    ${page_text} =    Get Text    body
    Should Contain Any    ${page_text}    Case History    History
    ...    msg=Case History related list not found on record page
    Log To Console    UI shows History related list on record page

    # 6. Cleanup
    Salesforce Delete    Case    ${case_id}
    Log To Console    CFSUITE-SR-008 complete
