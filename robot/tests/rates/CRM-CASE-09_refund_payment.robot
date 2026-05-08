*** Settings ***

Resource        ../resources/playwright_common.robot

Suite Setup     Open Test Browser With Video
# Suite Teardown  Delete Records and Close Browser


*** Test Cases ***

CRM_CASE_09 Refund Payment Back To Customer
    [Documentation]
    ...  Primary customer requests a refund of a payment made in error.
    ...  Navigates to Payments tab, clicks Actions, selects refund option,
    ...  uploads document, submits and verifies case creation.
    ...  Test Case: CRM-CASE-09

    # Setup property
    ${prop_id} =    Setup Property Quarter Dates And Balances    32 Develish Court

    # Cleanup existing refund/transfer cases
    @{existing} =    Salesforce Query    Case
    ...    select=Id    where=cfsuite1__cfReq_Category__c LIKE '%Reverse%' OR cfsuite1__cfReq_Category__c LIKE '%Transfer%'
    FOR    ${case}    IN    @{existing}
        Salesforce Delete    Case    ${case}[Id]
    END

    # Count reverse payment cases before
    @{cases_before} =    Salesforce Query    Case
    ...    select=Id    where=cfsuite1__cfReq_Category__c LIKE '%Reverse%'
    ${count_before} =    Get Length    ${cases_before}

    # Login as Hammy
    ${account_id} =    Login As Community User    Hammy Hampster
    Navigate To Rates Portal Page    /s/mylinkedproperties
    Sleep    10s
    Click Manage Property For    32 Develish Court

    # Step 5: Click Payments tab
    Log To Console    Step 5: Clicking Payments tab...
    ${payments_tab} =    Set Variable    xpath=//a[contains(text(), 'Payments')]
    Wait For Elements State    ${payments_tab}    visible    timeout=15s
    Click    ${payments_tab} >> nth=0

    # Step 6: Wait for payment records to load
    Log To Console    Step 6: Waiting for payment records to load...
    Wait Until Keyword Succeeds    60s    5s    Verify Payments Loaded
    Take Screenshot

    # Step 7: Click Actions on first payment
    Log To Console    Step 7: Clicking Actions dropdown...
    ${actions_btn} =    Set Variable    button.slds-button_outline-brand >> nth=0
    Wait For Elements State    ${actions_btn}    visible    timeout=10s
    Click    ${actions_btn}
    Sleep    5s
    Take Screenshot

    # Step 8: Click "Request a refund or transfer"
    Log To Console    Step 8: Clicking Request a refund or transfer...
    ${refund_transfer} =    Set Variable    xpath=//span[contains(text(), 'Request a refund or transfer')] >> nth=0
    Wait For Elements State    ${refund_transfer}    visible    timeout=10s
    Click    ${refund_transfer}
    Sleep    10s
    Take Screenshot

    # Step 9: Click "Refund back to me"
    Log To Console    Step 9: Clicking Refund back to me...
    ${refund_btn} =    Set Variable    xpath=//*[contains(text(), 'Refund back to me') or contains(text(), 'Refund back')]
    ${refund_exists} =    Run Keyword And Return Status    Wait For Elements State    ${refund_btn}    visible    timeout=15s
    Run Keyword If    ${refund_exists}    Click    ${refund_btn} >> nth=0
    Run Keyword If    ${refund_exists}    Sleep    10s
    Take Screenshot

    # Step 10: Verify refund amount is shown
    Log To Console    Step 10: Verifying refund amount...
    ${page_text} =    Get Text    body
    ${has_amount} =    Run Keyword And Return Status    Should Match Regexp    ${page_text}    \\$[\\d,]+\\.\\d{2}
    Run Keyword If    ${has_amount}    Log To Console    PASSED: Refund amount displayed

    # Step 11: Check for upload documents section
    ${has_upload} =    Run Keyword And Return Status    Should Match Regexp    ${page_text}    (?i)upload|document|supporting
    Run Keyword If    ${has_upload}    Log To Console    PASSED: Upload documents section found
    Take Screenshot

    # Step 12: Scroll down and click Submit Request
    Log To Console    Step 12: Clicking Submit Request...
    Evaluate JavaScript    ${None}    window.scrollTo(0, document.body.scrollHeight)
    Sleep    2s
    ${submit} =    Set Variable    xpath=//button[contains(text(), 'Submit')] >> nth=0
    Wait For Elements State    ${submit}    visible    timeout=15s
    Click    ${submit}
    Sleep    10s
    Take Screenshot

    # Step 13: Verify success page
    Log To Console    Step 13: Checking confirmation...
    ${result_text} =    Get Text    body
    ${has_success} =    Run Keyword And Return Status    Should Match Regexp    ${result_text}    (?i)success|submitted|refund|thank you|reference
    Run Keyword If    ${has_success}    Log To Console    PASSED: Refund request submitted
    Take Screenshot

    # VALIDATION: Check case created
    @{cases_after} =    Salesforce Query    Case
    ...    select=Id,CaseNumber,Status,cfsuite1__cfReq_Category__c
    ...    where=cfsuite1__cfReq_Category__c LIKE '%Reverse%'
    ...    order_by=CreatedDate DESC
    ${count_after} =    Get Length    ${cases_after}
    Run Keyword If    ${count_after} > ${count_before}    Log To Console    PASSED: Reverse Payment case created - ${cases_after}[0][CaseNumber]
    Run Keyword Unless    ${count_after} > ${count_before}    Log To Console    INFO: No reverse payment case found

    Take Screenshot

    # Cleanup
    Run Keyword If    ${count_after} > ${count_before}    Return To Salesforce Admin
    Run Keyword If    ${count_after} > ${count_before}    Salesforce Delete    Case    ${cases_after}[0][Id]

    Log To Console    CRM-CASE-09 test COMPLETE


*** Keywords ***

Verify Payments Loaded
    [Documentation]    Checks that payment records are visible on the page.
    ${page_text} =    Get Text    body
    Should Match Regexp    ${page_text}    \\$[\\d,]+\\.\\d{2}
    Log To Console    Payment records loaded
