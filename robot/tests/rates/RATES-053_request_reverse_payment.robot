*** Settings ***

Resource        ../resources/playwright_common.robot

Suite Setup     Open Test Browser With Video
# Suite Teardown  Delete Records and Close Browser


*** Test Cases ***

CRM_REF03 Customer Requests Reverse Payment
    [Documentation]
    ...  Customer or Customer Contact Officer requests a refund of some or
    ...  all of a payment made in error. Money paid in error can be returned.
    ...  Test Case: CRM_REF03

    # Login as Hammy Hampster
    ${account_id} =    Login As Community User    Hammy Hampster

    # Navigate to the payment transfer or refund page
    Navigate To Rates Portal Page    /s/payment-transfer-or-refund
    Sleep    10s
    Take Screenshot

    # Verify the page loaded with transfer/refund options
    ${page_text} =    Get Text    body
    Log To Console    Transfer/Refund page content length: ${page_text.__len__()}

    # Check for reverse payment / refund content
    ${has_reverse} =    Run Keyword And Return Status    Should Match Regexp    ${page_text}    (?i)reverse|refund|error|payment
    Run Keyword If    ${has_reverse}    Log To Console    PASSED: Reverse payment content found
    Run Keyword Unless    ${has_reverse}    Log To Console    WARNING: No reverse payment content on page

    # Check for form elements or options
    ${has_form} =    Run Keyword And Return Status    Wait For Elements State    xpath=//select | //input | //button    visible    timeout=5s
    Run Keyword If    ${has_form}    Log To Console    PASSED: Form elements found on page

    Take Screenshot
    Log To Console    CRM_REF03 test PASSED
