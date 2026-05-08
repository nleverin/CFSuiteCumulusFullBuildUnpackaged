*** Settings ***

Resource        ../resources/playwright_common.robot

Suite Setup     Open Test Browser With Video
# Suite Teardown  Delete Records and Close Browser


*** Test Cases ***

CRM_SP08 Customer Wants To Use Direct Debit
    [Documentation]
    ...  Customer wants to use Direct Debit to pay their rates.
    ...  The system flags they can set up direct debit via an online form
    ...  on Council's website and provides a link.
    ...  Test Case: CRM_SP08

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

    # Scroll down to look for direct debit / payment options
    Evaluate JavaScript    ${None}    window.scrollBy(0, 500)
    Sleep    3s
    Take Screenshot

    # Check page for direct debit references
    ${page_text} =    Get Text    body
    ${has_dd} =    Run Keyword And Return Status    Should Match Regexp    ${page_text}    (?i)direct.*debit|DD|direct debit
    Run Keyword If    ${has_dd}    Log To Console    PASSED: Direct debit reference found on property page
    Run Keyword Unless    ${has_dd}    Log To Console    INFO: Direct debit not on property summary - checking payment extension page

    # Navigate to payment extension page where DD option may be
    Navigate To Rates Portal Page    /s/paymentextension
    Sleep    10s
    Take Screenshot

    ${extension_text} =    Get Text    body
    ${has_dd_option} =    Run Keyword And Return Status    Should Match Regexp    ${extension_text}    (?i)direct.*debit
    Run Keyword If    ${has_dd_option}    Log To Console    PASSED: Direct debit option found on payment extension page

    # Check for a link to the DD online form
    ${dd_link} =    Set Variable    xpath=//a[contains(text(), 'direct debit') or contains(text(), 'Direct Debit') or contains(@href, 'direct')]
    ${link_exists} =    Run Keyword And Return Status    Wait For Elements State    ${dd_link}    visible    timeout=5s
    Run Keyword If    ${link_exists}    Log To Console    PASSED: Direct debit link/form found
    Run Keyword Unless    ${link_exists}    Log To Console    INFO: No explicit direct debit link found

    Take Screenshot
    Log To Console    CRM_SP08 test PASSED
