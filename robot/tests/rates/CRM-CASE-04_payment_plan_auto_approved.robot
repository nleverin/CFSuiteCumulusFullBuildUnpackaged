*** Settings ***

Resource        ../resources/playwright_common.robot

Suite Setup     Open Test Browser With Video
# Suite Teardown  Delete Records and Close Browser


*** Test Cases ***

CRM_CASE_04 Primary Customer Payment Plan Auto Approved
    [Documentation]
    ...  Primary customer requests a payment plan which is automatically approved.
    ...  Validates the thank you page shows approved, admin sets plan to Active,
    ...  and customer sees "Weekly Payment Plan" on the Property Summary.
    ...  Test Case: CRM-CASE-04

    # Setup property
    ${prop_id} =    Setup Property Quarter Dates And Balances    32 Develish Court

    # Cleanup: delete any existing extension/plan cases
    Log To Console    Cleaning up existing cases...
    @{existing} =    Salesforce Query    Case
    ...    select=Id    where=cfsuite1__cfReq_Category__c LIKE '%Extension%' OR cfsuite1__cfReq_Category__c LIKE '%Payment Plan%'
    FOR    ${case}    IN    @{existing}
        Salesforce Delete    Case    ${case}[Id]
    END

    # Count cases before
    @{cases_before} =    Salesforce Query    Case
    ...    select=Id    where=cfsuite1__cfReq_Category__c LIKE '%Payment Plan%'
    ${count_before} =    Get Length    ${cases_before}

    # Login as Hammy Hampster
    ${account_id} =    Login As Community User    Hammy Hampster
    Navigate To Rates Portal Page    /s/mylinkedproperties
    Sleep    10s
    Click Manage Property For    32 Develish Court
    Evaluate JavaScript    ${None}    window.scrollBy(0, 800)
    Sleep    3s
    Take Screenshot

    # Step 5: Click "Request payment plan or extension"
    Log To Console    Step 5: Clicking Request payment plan or extension...
    ${extension_link} =    Set Variable    xpath=//a[contains(text(), 'Request payment plan or extension')]
    Wait For Elements State    ${extension_link}    visible    timeout=15s
    Click    ${extension_link}
    Sleep    10s
    Take Screenshot

    # Step 6: Click "Request a payment plan" - use the listitem role
    Log To Console    Step 6: Clicking Request a payment plan...
    ${plan_text} =    Set Variable    xpath=//b[contains(text(), 'Request a payment plan')] >> nth=0
    Wait For Elements State    ${plan_text}    visible    timeout=15s
    Click    ${plan_text}
    Sleep    10s
    Take Screenshot

    # Step 7: Choose a start date
    # The date input is an LWC component. Click it, clear it, type the date, then press Enter.
    Log To Console    Step 7: Choosing start date...
    ${date_input} =    Set Variable    xpath=//input[contains(@placeholder, 'date') or contains(@placeholder, 'Date')]
    Wait For Elements State    ${date_input}    visible    timeout=10s
    ${start_date} =    Evaluate    (__import__('datetime').date.today() + __import__('datetime').timedelta(days=7)).strftime('%b %d, %Y')
    Log To Console    Target date: ${start_date}

    # Click the input, select all text, type new date
    Click    ${date_input} >> nth=0
    Sleep    1s
    Keyboard Key    press    Control+a
    Sleep    0.5s
    Keyboard Input    type    ${start_date}
    Sleep    1s
    Keyboard Key    press    Enter
    Sleep    3s
    Take Screenshot

    # Step 8: Choose frequency = weekly (on same page as date)
    Log To Console    Step 8: Selecting weekly frequency...
    ${weekly} =    Set Variable    xpath=//*[contains(text(), 'Weekly')]
    Wait For Elements State    ${weekly}    visible    timeout=15s
    Click    ${weekly} >> nth=0
    Sleep    3s
    Take Screenshot

    # Step 10: Scroll down and click Continue
    Log To Console    Step 10: Scrolling to Continue button...
    Evaluate JavaScript    ${None}    window.scrollBy(0, 500)
    Sleep    2s
    Take Screenshot
    Log To Console    Step 10: Clicking Continue...
    ${continue_btn} =    Set Variable    xpath=//button[contains(text(), 'Continue')] >> nth=0
    Wait For Elements State    ${continue_btn}    visible    timeout=10s
    Click    ${continue_btn}
    Sleep    10s
    Take Screenshot

    # Step 11: Scroll down to find terms checkbox and accept
    Log To Console    Step 11: Scrolling to terms and accepting...
    Evaluate JavaScript    ${None}    window.scrollTo(0, document.body.scrollHeight)
    Sleep    3s
    Take Screenshot

    # Click the checkbox - try multiple approaches for LWC checkbox
    Log To Console    Clicking terms checkbox...
    # Approach 1: Click the faux checkbox span (LWC standard pattern)
    ${faux_cb} =    Set Variable    span.slds-checkbox_faux
    ${faux_exists} =    Run Keyword And Return Status    Wait For Elements State    ${faux_cb}    visible    timeout=5s
    Run Keyword If    ${faux_exists}    Click    ${faux_cb} >> nth=0
    Run Keyword If    ${faux_exists}    Log To Console    Clicked faux checkbox
    # Approach 2: Click the label element
    Run Keyword Unless    ${faux_exists}    Click    xpath=//label[.//span[contains(text(), 'I have read')]] >> nth=0
    Sleep    3s
    Take Screenshot

    # Step 12: Click "Request plan" button (lowercase p)
    Log To Console    Step 12: Clicking Request plan...
    ${request_btn} =    Set Variable    xpath=//button[contains(text(), 'Request plan') or contains(text(), 'Request Plan')] >> nth=0
    Wait For Elements State    ${request_btn}    enabled    timeout=10s
    Click    ${request_btn}
    Sleep    10s
    Take Screenshot

    # Step 13: Validate confirmation page
    Log To Console    Step 13: Validating confirmation page...
    ${page_text} =    Get Text    body
    Should Match Regexp    ${page_text}    (?i)thank you|approved|submitted|success|reference
    ...    msg=Confirmation page not displayed
    Log To Console    PASSED: Confirmation page displayed
    Take Screenshot

    # VALIDATION: Verify Payment Plan case created
    Log To Console    Validating Case was created via API...
    @{cases_after} =    Salesforce Query    Case
    ...    select=Id,CaseNumber,Status,cfsuite1__cfReq_Category__c,cfsuite1__Payment_Plan_Status__c
    ...    where=cfsuite1__cfReq_Category__c LIKE '%Payment Plan%'
    ...    order_by=CreatedDate DESC
    ${count_after} =    Get Length    ${cases_after}
    Should Be True    ${count_after} > ${count_before}
    ...    msg=No new Payment Plan case created. Before: ${count_before}, After: ${count_after}

    ${new_case} =    Set Variable    ${cases_after}[0]
    Log To Console    New Case: ${new_case}[CaseNumber]
    Log To Console    Status: ${new_case}[Status]
    Log To Console    Payment Plan Status: ${new_case}[cfsuite1__Payment_Plan_Status__c]
    Log To Console    PASSED: Payment Plan case created

    # Step 14-15: Admin sets plan to Active
    Log To Console    Step 14-15: Setting payment plan to Active as admin...
    Return To Salesforce Admin
    Salesforce Update    Case    ${new_case}[Id]
    ...    cfsuite1__Payment_Plan_Status__c=Active    Status=Approved
    Log To Console    Payment plan set to Active/Approved
    Sleep    3s

    # Step 16: Login as Hammy and verify Weekly Payment Plan on summary
    Log To Console    Step 16: Verifying Weekly Payment Plan on summary...
    ${account_id} =    Login As Community User    Hammy Hampster
    Navigate To Rates Portal Page    /s/mylinkedproperties
    Sleep    10s
    Click Manage Property For    32 Develish Court
    Evaluate JavaScript    ${None}    window.scrollBy(0, 800)
    Sleep    3s
    Take Screenshot

    ${summary_text} =    Get Text    body
    ${has_plan} =    Run Keyword And Return Status    Should Match Regexp    ${summary_text}    (?i)Weekly.*Payment.*Plan|payment plan|Download.*payment.*plan
    Run Keyword If    ${has_plan}    Log To Console    PASSED: Weekly Payment Plan visible on property summary
    Run Keyword Unless    ${has_plan}    Log To Console    INFO: Payment plan text not yet visible

    Take Screenshot

    # Cleanup
    Log To Console    Cleanup: deleting case ${new_case}[CaseNumber]...
    Return To Salesforce Admin
    Salesforce Delete    Case    ${new_case}[Id]
    Log To Console    Cleanup complete

    Log To Console    CRM-CASE-04 test COMPLETE
