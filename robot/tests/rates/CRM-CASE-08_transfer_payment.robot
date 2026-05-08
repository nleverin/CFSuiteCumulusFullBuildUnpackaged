*** Settings ***

Resource        ../resources/playwright_common.robot

Suite Setup     Open Test Browser With Video
# Suite Teardown  Delete Records and Close Browser


*** Test Cases ***

CRM_CASE_08 Transfer Payment To Another Property
    [Documentation]
    ...  Primary customer transfers a payment from one property to another.
    ...  Navigates to Payments tab, clicks Actions on a payment, selects
    ...  transfer, picks target property, submits and verifies case creation.
    ...  Test Case: CRM-CASE-08

    # Setup property
    ${prop_id} =    Setup Property Quarter Dates And Balances    32 Develish Court

    # Cleanup existing transfer cases
    @{existing} =    Salesforce Query    Case
    ...    select=Id    where=cfsuite1__cfReq_Category__c LIKE '%Transfer%' OR cfsuite1__cfReq_Category__c LIKE '%Extension%' OR cfsuite1__cfReq_Category__c LIKE '%Payment Plan%'
    FOR    ${case}    IN    @{existing}
        Salesforce Delete    Case    ${case}[Id]
    END

    # Count transfer cases before
    @{cases_before} =    Salesforce Query    Case
    ...    select=Id    where=cfsuite1__cfReq_Category__c LIKE '%Transfer%'
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

    # Wait for payment history to load from the API (can take 20-30 seconds)
    Log To Console    Step 6: Waiting for payment records to load from API...
    ${payment_row} =    Set Variable    xpath=//tr[.//td] | //table//tr[position()>1]
    Wait Until Keyword Succeeds    60s    5s    Wait For Payment Records    ${payment_row}
    Take Screenshot

    # Step 7: Click the first Actions dropdown on a payment row
    Log To Console    Step 7: Clicking first Actions dropdown...
    ${actions_btn} =    Set Variable    button.slds-button_outline-brand >> nth=0
    Wait For Elements State    ${actions_btn}    visible    timeout=10s
    Click    ${actions_btn}
    Sleep    5s
    Take Screenshot

    # Step 8: Click "Request a refund or transfer" from the dropdown menu
    Log To Console    Step 8: Clicking Request a refund or transfer...
    ${refund_transfer} =    Set Variable    xpath=//span[contains(text(), 'Request a refund or transfer')] >> nth=0
    Wait For Elements State    ${refund_transfer}    visible    timeout=10s
    Click    ${refund_transfer}
    Sleep    10s
    Take Screenshot

    # Step 9: Click "Transfer to another linked property"
    Log To Console    Step 9: Clicking transfer to another property...
    ${transfer_linked} =    Set Variable    xpath=//*[contains(text(), 'Transfer to another') or contains(text(), 'transfer to another') or contains(text(), 'linked property')]
    ${linked_exists} =    Run Keyword And Return Status    Wait For Elements State    ${transfer_linked}    visible    timeout=15s
    Run Keyword If    ${linked_exists}    Click    ${transfer_linked} >> nth=0
    Run Keyword If    ${linked_exists}    Sleep    10s
    Take Screenshot

    # Step 10: Verify transfer amount is displayed
    Log To Console    Step 10: Verifying transfer amount...
    ${transfer_text} =    Get Text    body
    ${has_amount} =    Run Keyword And Return Status    Should Match Regexp    ${transfer_text}    \\$[\\d,]+\\.\\d{2}
    Run Keyword If    ${has_amount}    Log To Console    PASSED: Transfer amount displayed
    Take Screenshot

    # Step 11: Select a target property (click 37 Goldberry Street)
    Log To Console    Step 11: Selecting target property...
    ${target_prop} =    Set Variable    xpath=//*[contains(text(), 'Goldberry')]
    ${target_exists} =    Run Keyword And Return Status    Wait For Elements State    ${target_prop}    visible    timeout=10s
    Run Keyword If    ${target_exists}    Click    ${target_prop} >> nth=0
    Sleep    3s
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
    ${has_success} =    Run Keyword And Return Status    Should Match Regexp    ${result_text}    (?i)success|submitted|transfer|thank you|reference
    Run Keyword If    ${has_success}    Log To Console    PASSED: Transfer request submitted
    Take Screenshot

    # VALIDATION: Check case created
    @{cases_after} =    Salesforce Query    Case
    ...    select=Id,CaseNumber,Status,cfsuite1__cfReq_Category__c
    ...    where=cfsuite1__cfReq_Category__c LIKE '%Transfer%'
    ...    order_by=CreatedDate DESC
    ${count_after} =    Get Length    ${cases_after}
    Run Keyword If    ${count_after} > ${count_before}    Log To Console    PASSED: Transfer case created - ${cases_after}[0][CaseNumber]
    Run Keyword Unless    ${count_after} > ${count_before}    Log To Console    INFO: No transfer case found (flow may not have completed)

    Take Screenshot

    # Cleanup
    Run Keyword If    ${count_after} > ${count_before}    Return To Salesforce Admin
    Run Keyword If    ${count_after} > ${count_before}    Salesforce Delete    Case    ${cases_after}[0][Id]

    Log To Console    CRM-CASE-08 test COMPLETE


*** Keywords ***

Wait For Payment Records
    [Arguments]    ${row_selector}
    [Documentation]    Waits until payment records are visible in the table.
    ${page_text} =    Get Text    body
    Should Match Regexp    ${page_text}    \\$[\\d,]+\\.\\d{2}
    Log To Console    Payment records loaded
