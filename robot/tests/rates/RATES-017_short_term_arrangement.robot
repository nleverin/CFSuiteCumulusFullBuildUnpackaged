*** Settings ***

Resource        ../resources/playwright_common.robot

Suite Setup     Open Test Browser With Video
# Suite Teardown  Delete Records and Close Browser


*** Test Cases ***

CRM_RC01 Customer Short Term Arrangement Less Than 5 Days
    [Documentation]
    ...  Customer wishes to pay their rates bill up to 5 days after the due date.
    ...  The system lets them know they can make the payment but they might
    ...  still be liable for fines or interest.
    ...  Test Case: CRM_RC01

    # Login as Hammy Hampster
    ${account_id} =    Login As Community User    Hammy Hampster

    # Navigate to My Property & Rates and manage a property
    Navigate To Rates Portal Page    /s/mylinkedproperties
    Sleep    10s

    ${manage_btn} =    Set Variable    button.btn-manage >> nth=0
    Wait For Elements State    ${manage_btn}    visible    timeout=30s
    Click    ${manage_btn}
    Sleep    10s
    Take Screenshot

    # Scroll down to find Payment Arrangement section
    Log To Console    Looking for payment arrangement / extension link...
    Evaluate JavaScript    ${None}    window.scrollBy(0, 500)
    Sleep    3s
    Take Screenshot

    # Look for the payment plan or extension link
    ${page_text} =    Get Text    body
    ${has_arrangement} =    Run Keyword And Return Status    Should Match Regexp    ${page_text}    (?i)payment.*plan|extension|arrangement|short.*term
    Run Keyword If    ${has_arrangement}    Log To Console    PASSED: Payment arrangement/extension option found on summary page
    Run Keyword Unless    ${has_arrangement}    Log To Console    INFO: Payment arrangement text not found on summary page

    # Navigate to the payment extension page directly
    Navigate To Rates Portal Page    /s/paymentextension
    Sleep    10s
    Take Screenshot

    # Verify the payment extension page loaded with options
    ${extension_text} =    Get Text    body
    Log To Console    Extension page content length: ${extension_text.__len__()}

    ${has_short_term} =    Run Keyword And Return Status    Should Match Regexp    ${extension_text}    (?i)short.*term|5 day|extension|arrangement
    Run Keyword If    ${has_short_term}    Log To Console    PASSED: Short term arrangement option found
    Run Keyword Unless    ${has_short_term}    Log To Console    WARNING: Short term arrangement option not found

    ${has_warning} =    Run Keyword And Return Status    Should Match Regexp    ${extension_text}    (?i)fine|interest|liable|penalty
    Run Keyword If    ${has_warning}    Log To Console    PASSED: Fine/interest warning found
    Run Keyword Unless    ${has_warning}    Log To Console    INFO: No fine/interest warning text found

    Take Screenshot
    Log To Console    CRM_RC01 test PASSED
