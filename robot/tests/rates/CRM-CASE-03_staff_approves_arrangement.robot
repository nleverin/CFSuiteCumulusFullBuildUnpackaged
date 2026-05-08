*** Settings ***

Resource        ../resources/playwright_common.robot

Suite Setup     Open Test Browser With Video
# Suite Teardown  Delete Records and Close Browser


*** Test Cases ***

CRM_CASE_03 Staff Approves Short Term Arrangement
    [Documentation]
    ...  Staff member approves a short term arrangement by setting the
    ...  Status to Approved. Verifies the arrangement then shows on
    ...  the Property Summary screen for the customer.
    ...  Pre-condition: An Open extension case must exist (test creates one first).
    ...  Test Case: CRM-CASE-03

    # Setup property
    ${prop_id} =    Setup Property Quarter Dates And Balances    32 Develish Court

    # Cleanup: delete any existing extension cases
    Log To Console    Cleaning up existing cases...
    @{existing} =    Salesforce Query    Case
    ...    select=Id    where=cfsuite1__cfReq_Category__c LIKE '%Extension%' OR cfsuite1__cfReq_Category__c LIKE '%Payment Plan%'
    FOR    ${case}    IN    @{existing}
        Salesforce Delete    Case    ${case}[Id]
    END
    Log To Console    Deleted ${existing.__len__()} cases

    # Step 1: Create an Over 5 Days extension case (will be Open, not auto-approved)
    Log To Console    Step 1: Creating an Open extension case via portal...
    ${account_id} =    Login As Community User    Hammy Hampster
    Navigate To Rates Portal Page    /s/mylinkedproperties
    Sleep    10s
    Click Manage Property For    32 Develish Court
    Evaluate JavaScript    ${None}    window.scrollBy(0, 800)
    Sleep    3s

    # Click extension link
    ${extension_link} =    Set Variable    xpath=//a[contains(text(), 'Request payment plan or extension')]
    Wait For Elements State    ${extension_link}    visible    timeout=15s
    Click    ${extension_link}
    Sleep    10s

    # Click short term arrangement
    ${short_term} =    Set Variable    xpath=//b[contains(text(), 'Request a short term arrangement')]/..
    Wait For Elements State    ${short_term}    visible    timeout=15s
    Click    ${short_term}
    Sleep    10s

    # Click More than 5 days (so it's NOT auto-approved)
    ${more5} =    Set Variable    xpath=//*[contains(text(), 'More than 5 days')]
    Wait For Elements State    ${more5}    visible    timeout=15s
    Click    ${more5} >> nth=0
    Sleep    5s

    # Set date and reason
    ${future_date} =    Evaluate    (__import__('datetime').date.today() + __import__('datetime').timedelta(days=14)).isoformat()
    ${date_input} =    Set Variable    xpath=//input[@type='date'] | //input[contains(@placeholder, 'date')]
    ${date_exists} =    Run Keyword And Return Status    Wait For Elements State    ${date_input}    visible    timeout=5s
    Run Keyword If    ${date_exists}    Fill Text    ${date_input} >> nth=0    ${future_date}
    Sleep    2s

    ${reason_select} =    Set Variable    select
    Wait For Elements State    ${reason_select}    visible    timeout=10s
    Select Options By    ${reason_select} >> nth=0    label    Financial Hardship
    Sleep    2s

    ${comments} =    Set Variable    textarea
    Wait For Elements State    ${comments}    visible    timeout=10s
    Fill Text    ${comments} >> nth=0    Over 5 days test for staff approval
    Sleep    2s

    # Submit
    ${submit} =    Set Variable    xpath=//button[contains(text(), 'Submit')]
    Wait For Elements State    ${submit}    visible    timeout=15s
    Click    ${submit} >> nth=0
    Sleep    10s
    Take Screenshot

    # Verify case was created with Open status
    @{open_cases} =    Salesforce Query    Case
    ...    select=Id,CaseNumber,Status
    ...    where=cfsuite1__cfReq_Category__c LIKE '%Extension%' AND Status='Open'
    ...    order_by=CreatedDate DESC    limit=1
    ${open_count} =    Get Length    ${open_cases}
    Should Be True    ${open_count} > 0    No Open extension case found after submission
    ${case_id} =    Set Variable    ${open_cases}[0][Id]
    ${case_number} =    Set Variable    ${open_cases}[0][CaseNumber]
    Log To Console    Created Open case: ${case_number}

    # Step 4: Verify extension link is still available (not approved yet)
    Log To Console    Step 4: Verifying extension link still available before approval...
    Navigate To Rates Portal Page    /s/mylinkedproperties
    Sleep    10s
    Click Manage Property For    32 Develish Court
    Evaluate JavaScript    ${None}    window.scrollBy(0, 800)
    Sleep    3s
    Take Screenshot

    ${summary_before} =    Get Text    body
    ${has_link_before} =    Run Keyword And Return Status    Should Match Regexp    ${summary_before}    (?i)Request payment plan or extension
    Run Keyword If    ${has_link_before}    Log To Console    PASSED: Extension link still available (case not yet approved)

    # Step 5-6: Return to admin and approve the case
    Log To Console    Step 5-6: Approving case as admin...
    Return To Salesforce Admin
    Salesforce Update    Case    ${case_id}    Status=Approved
    Log To Console    Case ${case_number} approved via API
    Sleep    3s

    # Step 7-8: Login as Hammy and verify arrangement shows on summary
    Log To Console    Step 7-8: Verifying arrangement shows after approval...
    ${account_id} =    Login As Community User    Hammy Hampster
    Navigate To Rates Portal Page    /s/mylinkedproperties
    Sleep    10s
    Click Manage Property For    32 Develish Court
    Evaluate JavaScript    ${None}    window.scrollBy(0, 800)
    Sleep    3s
    Take Screenshot

    ${summary_after} =    Get Text    body
    ${has_arrangement} =    Run Keyword And Return Status    Should Match Regexp    ${summary_after}    (?i)Arrangement
    Should Be True    ${has_arrangement}    Arrangement text should be visible after staff approval
    Log To Console    PASSED: Arrangement visible on property summary after approval

    # Step 9: Check Property Requests tab
    Log To Console    Step 9: Checking Property Requests tab...
    ${requests_tab} =    Set Variable    xpath=//a[contains(text(), 'Property Requests')]
    ${tab_exists} =    Run Keyword And Return Status    Wait For Elements State    ${requests_tab}    visible    timeout=10s
    Run Keyword If    ${tab_exists}    Click    ${requests_tab} >> nth=0
    Run Keyword If    ${tab_exists}    Sleep    10s
    Run Keyword If    ${tab_exists}    Take Screenshot
    Run Keyword If    ${tab_exists}    Log To Console    PASSED: Property Requests tab accessible

    Take Screenshot

    # Cleanup: delete the case
    Log To Console    Cleanup: deleting case ${case_number}...
    Return To Salesforce Admin
    Salesforce Delete    Case    ${case_id}
    Log To Console    Cleanup complete

    Log To Console    CRM-CASE-03 test COMPLETE
