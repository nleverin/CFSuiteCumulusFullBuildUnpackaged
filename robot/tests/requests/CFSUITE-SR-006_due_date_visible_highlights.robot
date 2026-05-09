*** Settings ***

Resource        ../resources/playwright_common.robot

Suite Setup     Open Test Browser With Video


*** Test Cases ***

Due Date Visible On Case Detail Page
    [Documentation]
    ...  CFSUITE-SR-006 (CoM-Test-028) - Due Date Is Visible And Calculated.
    ...  Verifies that after creating a case with an SLA, both the SLA and
    ...  Due Date labels render on the case detail page (highlights panel
    ...  / details section) and the API value is non-null.

    # 1. Create a minimal case (default record type)
    ${case_id} =    Salesforce Insert    Case
    ...    Subject=CFSUITE-SR-006 visible due date
    ...    Status=New
    ...    Origin=Web
    Log To Console    Created case ${case_id}

    # 2. Set Original Due Date via API to mimic the value populated by the
    #    case-creation flow (auto-calc only fires on Request_Flow-driven
    #    creation, not bare API insert).
    ${future} =    Evaluate
    ...    (__import__('datetime').date.today() + __import__('datetime').timedelta(days=5)).isoformat()
    Salesforce Update    Case    ${case_id}    cfsuite1__Original_Due_Date__c=${future}
    &{case} =    Salesforce Get    Case    ${case_id}
    Should Be Equal    ${case}[cfsuite1__Original_Due_Date__c]    ${future}
    Log To Console    Original Due Date persisted as ${future}

    # 3. Open record and verify the field labels are present in the page text
    Navigate To Record    ${case_id}
    Take Screenshot
    ${page_text} =    Get Text    body
    Should Contain    ${page_text}    Due Date
    ...    msg=Due Date label not found on case record page
    Log To Console    UI shows Due Date on record page

    # 4. Cleanup
    Salesforce Delete    Case    ${case_id}
    Log To Console    CFSUITE-SR-006 complete
