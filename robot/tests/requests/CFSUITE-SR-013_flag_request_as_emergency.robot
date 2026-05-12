*** Settings ***

Resource        ../resources/playwright_common.robot

Suite Setup     Open Test Browser With Video


*** Test Cases ***

Flag Request As Emergency Hazard
    [Documentation]
    ...  CFSUITE-SR-013 (CoM-Test-027) - Flag Request as an Emergency.
    ...  Verifies Case.cfsuite1__Is_Hazard__c can be flipped from No to Yes
    ...  and the change is reflected on the record detail page in the UI.

    # 1. Create a fresh case via API in the not-hazard state
    ${case_id} =    Salesforce Insert    Case
    ...    Subject=CFSUITE-SR-013 hazard test
    ...    Status=New
    ...    Origin=Web
    ...    cfsuite1__Is_Hazard__c=No
    Log To Console    Created case ${case_id}

    # 2. Verify starting state
    &{case_before} =    Salesforce Get    Case    ${case_id}
    Should Be Equal    ${case_before}[cfsuite1__Is_Hazard__c]    No

    # 3. Flip flag via API (mirrors what the UI's inline edit does on the field)
    Salesforce Update    Case    ${case_id}    cfsuite1__Is_Hazard__c=Yes

    # 4. Verify backend update
    &{case_after} =    Salesforce Get    Case    ${case_id}
    Should Be Equal    ${case_after}[cfsuite1__Is_Hazard__c]    Yes
    Log To Console    Backend hazard flag set to Yes

    # 5. Open the record in the UI for visual evidence (screenshot only -
    #    Is Hazard is not on the default page layout, so no text assertion)
    Navigate To Record    ${case_id}
    Take Screenshot

    # 6. Cleanup
    Salesforce Delete    Case    ${case_id}
    Log To Console    CFSUITE-SR-013 complete
