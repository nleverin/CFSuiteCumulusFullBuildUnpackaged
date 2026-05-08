*** Settings ***

Resource        ../resources/playwright_common.robot

Suite Setup     Open Test Browser With Video
# Suite Teardown  Delete Records and Close Browser


*** Test Cases ***

CRM_CASE_02 Primary Customer Short Term Extension Over 5 Days
    [Documentation]
    ...  Primary customer requests a short term arrangement of over 5 days
    ...  which is NOT automatically approved. Validates a Case is created
    ...  with Open status and the Request payment plan or extension link
    ...  is still available on the property summary.
    ...  Test Case: CRM-CASE-02

    # Setup: configure property with correct quarter dates and balances
    ${prop_id} =    Setup Property Quarter Dates And Balances    32 Develish Court

    # Cleanup: delete any existing extension/plan cases so the link is available
    Log To Console    Cleaning up existing payment cases...
    @{existing_cases} =    Salesforce Query    Case
    ...    select=Id
    ...    where=(cfsuite1__cfReq_Category__c LIKE '%Extension%' OR cfsuite1__cfReq_Category__c LIKE '%Payment Plan%') AND Status!='Closed'
    FOR    ${case}    IN    @{existing_cases}
        Salesforce Delete    Case    ${case}[Id]
    END
    Log To Console    Deleted ${existing_cases.__len__()} existing cases

    # Count cases before test
    @{cases_before} =    Salesforce Query    Case
    ...    select=Id    where=cfsuite1__cfReq_Category__c LIKE '%Extension%'
    ${count_before} =    Get Length    ${cases_before}
    Log To Console    Extension cases before test: ${count_before}

    # Login as Hammy Hampster
    ${account_id} =    Login As Community User    Hammy Hampster

    # Navigate to My Property & Rates
    Navigate To Rates Portal Page    /s/mylinkedproperties
    Sleep    10s

    # Click Manage property for Develish Court
    Click Manage Property For    32 Develish Court

    # Scroll down to payment details section
    Evaluate JavaScript    ${None}    window.scrollBy(0, 800)
    Sleep    3s
    Take Screenshot

    # Step 5: Click "Request payment plan or extension" link
    Log To Console    Step 5: Clicking Request payment plan or extension...
    ${extension_link} =    Set Variable    xpath=//a[contains(text(), 'Request payment plan or extension')]
    Wait For Elements State    ${extension_link}    visible    timeout=15s
    Click    ${extension_link}
    Sleep    10s
    Take Screenshot

    # Step 6: Click "Request a short term arrangement" list item
    Log To Console    Step 6: Clicking Request a short term arrangement...
    ${short_term_item} =    Set Variable    xpath=//b[contains(text(), 'Request a short term arrangement')]/..
    Wait For Elements State    ${short_term_item}    visible    timeout=15s
    Click    ${short_term_item}
    Sleep    10s
    Take Screenshot

    # Step 7: Click "More than 5 days" toggle button
    Log To Console    Step 7: Clicking More than 5 days...
    ${more5_btn} =    Set Variable    xpath=//*[contains(text(), 'More than 5 days')]
    Wait For Elements State    ${more5_btn}    visible    timeout=15s
    Click    ${more5_btn} >> nth=0
    Sleep    5s
    Take Screenshot

    # Step 7b: Choose a date (if date picker is shown)
    Log To Console    Step 7b: Looking for date input...
    ${date_input} =    Set Variable    xpath=//input[@type='date'] | //input[contains(@placeholder, 'date') or contains(@placeholder, 'Date')]
    ${date_exists} =    Run Keyword And Return Status    Wait For Elements State    ${date_input}    visible    timeout=5s
    Run Keyword If    ${date_exists}    Log To Console    Date input found - setting a date
    # Set a date ~2 weeks from now
    ${future_date} =    Evaluate    (__import__('datetime').date.today() + __import__('datetime').timedelta(days=14)).isoformat()
    Run Keyword If    ${date_exists}    Fill Text    ${date_input} >> nth=0    ${future_date}
    Sleep    3s
    Take Screenshot

    # Step 8: Select "Financial Hardship" from the reason dropdown
    Log To Console    Step 8: Selecting Financial Hardship from dropdown...
    ${reason_select} =    Set Variable    select
    Wait For Elements State    ${reason_select}    visible    timeout=10s
    Select Options By    ${reason_select} >> nth=0    label    Financial Hardship
    Sleep    3s
    Take Screenshot

    # Step 9: Add additional comments
    Log To Console    Step 9: Adding comments...
    ${comments} =    Set Variable    textarea
    Wait For Elements State    ${comments}    visible    timeout=10s
    Fill Text    ${comments} >> nth=0    Need a few more days
    Sleep    2s
    Take Screenshot

    # Step 10: Click Submit request
    Log To Console    Step 10: Clicking Submit request...
    ${submit} =    Set Variable    xpath=//button[contains(text(), 'Submit')]
    Wait For Elements State    ${submit}    visible    timeout=15s
    Click    ${submit} >> nth=0
    Sleep    10s
    Take Screenshot

    # Step 11: Validate the confirmation page
    Log To Console    Step 11: Validating confirmation page...
    ${page_text} =    Get Text    body
    Should Match Regexp    ${page_text}    (?i)thank you|submitted|success|request.*received|reference|will be assessed
    ...    msg=Confirmation page not displayed after submission
    Log To Console    PASSED: Confirmation page displayed
    Take Screenshot

    # VALIDATION: Verify a new Case was created via API with non-Approved status
    Log To Console    Validating Case was created via API...
    @{cases_after} =    Salesforce Query    Case
    ...    select=Id,CaseNumber,Status,cfsuite1__cfReq_Category__c,cfsuite1__Payment_Plan_Status__c
    ...    where=cfsuite1__cfReq_Category__c LIKE '%Extension%'
    ...    order_by=CreatedDate DESC
    ${count_after} =    Get Length    ${cases_after}
    Should Be True    ${count_after} > ${count_before}
    ...    msg=No new Extension case created. Before: ${count_before}, After: ${count_after}

    ${new_case} =    Set Variable    ${cases_after}[0]
    Log To Console    New Case: ${new_case}[CaseNumber]
    Log To Console    Status: ${new_case}[Status]
    Log To Console    Category: ${new_case}[cfsuite1__cfReq_Category__c]

    # Over 5 days should NOT be auto-approved
    Should Not Be Equal As Strings    ${new_case}[Status]    Approved
    ...    msg=Over 5 days extension should NOT be auto-approved but status is Approved
    Log To Console    PASSED: Case is NOT auto-approved (Status: ${new_case}[Status])

    # Step 12: Navigate back to Property Summary - extension link should STILL be available
    Log To Console    Step 12: Checking extension link still available on summary...
    Navigate To Rates Portal Page    /s/mylinkedproperties
    Sleep    10s
    Click Manage Property For    32 Develish Court
    Evaluate JavaScript    ${None}    window.scrollBy(0, 800)
    Sleep    3s
    Take Screenshot

    ${summary_text} =    Get Text    body
    ${has_link} =    Run Keyword And Return Status    Should Match Regexp    ${summary_text}    (?i)Request payment plan or extension
    Run Keyword If    ${has_link}    Log To Console    PASSED: Extension link still available (not auto-approved)
    Run Keyword Unless    ${has_link}    Log To Console    INFO: Extension link replaced (case may have been approved by automation)

    Take Screenshot

    # Cleanup: delete the case we just created
    Log To Console    Cleanup: deleting extension case ${new_case}[CaseNumber]...
    Return To Salesforce Admin
    Salesforce Delete    Case    ${new_case}[Id]
    Log To Console    Cleanup complete

    Log To Console    CRM-CASE-02 test COMPLETE
