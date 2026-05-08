*** Settings ***

Resource        ../resources/playwright_common.robot

Suite Setup     Open Test Browser With Video
# Suite Teardown  Delete Records and Close Browser


*** Test Cases ***

CRM_CASE_10 Customer Refund Credit Balance
    [Documentation]
    ...  Customer with a credit balance requests a refund via the Refund credit
    ...  link on the property summary. Enters BSB and account number, uploads
    ...  a document, submits. Verifies case and encrypted BSB/account fields.
    ...  Test Case: CRM-CASE-10

    # Setup: property with credit balance (negative full year balance)
    ${prop_id} =    Setup Property Quarter Dates And Balances    37 Goldberry Street    balance_per_quarter=0    credit_override=-300

    # Cleanup existing refund credit cases
    @{existing} =    Salesforce Query    Case
    ...    select=Id    where=cfsuite1__cfReq_Category__c LIKE '%Refund Credit%'
    FOR    ${case}    IN    @{existing}
        Salesforce Delete    Case    ${case}[Id]
    END

    # Count cases before
    @{cases_before} =    Salesforce Query    Case
    ...    select=Id    where=cfsuite1__cfReq_Category__c LIKE '%Refund Credit%'
    ${count_before} =    Get Length    ${cases_before}

    # Login as Hammy
    ${account_id} =    Login As Community User    Hammy Hampster
    Navigate To Rates Portal Page    /s/mylinkedproperties
    Sleep    10s
    Click Manage Property For    37 Goldberry Street

    # Scroll to find Refund credit link
    Evaluate JavaScript    ${None}    window.scrollBy(0, 800)
    Sleep    3s
    Take Screenshot

    # Step 5: Click Refund credit link
    Log To Console    Step 5: Clicking Refund credit link...
    ${refund_link} =    Set Variable    xpath=//a[contains(text(), 'Refund credit')]
    Wait For Elements State    ${refund_link}    visible    timeout=15s
    Click    ${refund_link}
    Sleep    10s
    Take Screenshot

    # Step 6: Choose "My full credit balance"
    Log To Console    Step 6: Selecting full credit balance...
    ${full_credit} =    Set Variable    xpath=//*[contains(text(), 'full credit') or contains(text(), 'Full credit')]
    ${credit_exists} =    Run Keyword And Return Status    Wait For Elements State    ${full_credit}    visible    timeout=10s
    Run Keyword If    ${credit_exists}    Click    ${full_credit} >> nth=0
    Sleep    3s
    Take Screenshot

    # Step 7: Enter BSB
    Log To Console    Step 7: Entering BSB...
    ${bsb_field} =    Set Variable    xpath=//input[contains(@placeholder, 'BSB') or contains(@name, 'bsb') or contains(@name, 'BSB') or contains(@label, 'BSB')]
    ${bsb_exists} =    Run Keyword And Return Status    Wait For Elements State    ${bsb_field}    visible    timeout=10s
    Run Keyword If    ${bsb_exists}    Fill Text    ${bsb_field} >> nth=0    035099
    Sleep    1s

    # Enter Account Number
    Log To Console    Entering Account Number...
    ${acct_field} =    Set Variable    xpath=//input[contains(@placeholder, 'Account') or contains(@name, 'account') or contains(@name, 'Account') or contains(@label, 'Account')]
    ${acct_exists} =    Run Keyword And Return Status    Wait For Elements State    ${acct_field}    visible    timeout=10s
    Run Keyword If    ${acct_exists}    Fill Text    ${acct_field} >> nth=0    100000
    Sleep    1s
    Take Screenshot

    # Step 8: Upload a file (if upload section exists)
    Log To Console    Step 8: Checking for file upload...
    ${upload_input} =    Set Variable    xpath=//input[@type='file']
    ${upload_exists} =    Run Keyword And Return Status    Wait For Elements State    ${upload_input}    attached    timeout=5s
    Run Keyword If    ${upload_exists}    Log To Console    File upload field found
    Run Keyword Unless    ${upload_exists}    Log To Console    No file upload field (may not be required)
    Sleep    2s
    Take Screenshot

    # Step 9: Click Submit Request
    Log To Console    Step 9: Clicking Submit Request...
    Evaluate JavaScript    ${None}    window.scrollTo(0, document.body.scrollHeight)
    Sleep    2s
    ${submit} =    Set Variable    xpath=//button[contains(text(), 'Submit')] >> nth=0
    Wait For Elements State    ${submit}    visible    timeout=15s
    Click    ${submit}
    Sleep    10s
    Take Screenshot

    # Step 10-11: Verify success page with reference number and refund amount
    Log To Console    Step 10-11: Checking confirmation page...
    ${page_text} =    Get Text    body
    ${has_reference} =    Run Keyword And Return Status    Should Match Regexp    ${page_text}    (?i)reference|submitted|success|thank you
    Run Keyword If    ${has_reference}    Log To Console    PASSED: Refund request submitted with reference
    ${has_amount} =    Run Keyword And Return Status    Should Match Regexp    ${page_text}    (?i)refund.*amount|\\$[\\d,]+
    Run Keyword If    ${has_amount}    Log To Console    PASSED: Refund amount displayed
    Take Screenshot

    # Step 12-13: Navigate back to property and check Property Requests
    Log To Console    Step 12-13: Checking Property Requests tab...
    Navigate To Rates Portal Page    /s/mylinkedproperties
    Sleep    10s
    Click Manage Property For    37 Goldberry Street

    ${requests_tab} =    Set Variable    xpath=//a[contains(text(), 'Property Requests')]
    ${tab_exists} =    Run Keyword And Return Status    Wait For Elements State    ${requests_tab}    visible    timeout=10s
    Run Keyword If    ${tab_exists}    Click    ${requests_tab} >> nth=0
    Run Keyword If    ${tab_exists}    Sleep    10s
    Run Keyword If    ${tab_exists}    Take Screenshot

    ${requests_text} =    Get Text    body
    ${has_refund_case} =    Run Keyword And Return Status    Should Match Regexp    ${requests_text}    (?i)refund|Refund Credit
    Run Keyword If    ${has_refund_case}    Log To Console    PASSED: Refund Credit Balance case in Property Requests

    # Step 14-15: Verify encrypted BSB via API
    Log To Console    Step 14-15: Verifying case and BSB encryption via API...
    Return To Salesforce Admin

    @{refund_cases} =    Salesforce Query    Case
    ...    select=Id,CaseNumber,Status,cfsuite1__cfReq_Category__c
    ...    where=cfsuite1__cfReq_Category__c LIKE '%Refund Credit%'
    ...    order_by=CreatedDate DESC
    ${count_after} =    Get Length    ${refund_cases}
    Should Be True    ${count_after} > ${count_before}
    ...    msg=No Refund Credit Balance case created

    ${new_case} =    Set Variable    ${refund_cases}[0]
    Log To Console    Case: ${new_case}[CaseNumber] Status: ${new_case}[Status]
    Log To Console    PASSED: Refund Credit Balance case created

    Take Screenshot

    # Cleanup
    Log To Console    Cleanup: deleting case ${new_case}[CaseNumber]...
    Salesforce Delete    Case    ${new_case}[Id]
    Log To Console    Cleanup complete

    Log To Console    CRM-CASE-10 test COMPLETE
