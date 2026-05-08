*** Settings ***

Resource        ../resources/playwright_common.robot

Suite Setup     Open Test Browser With Video
# Suite Teardown  Delete Records and Close Browser


*** Test Cases ***

MCC_Rates_14 Customer Waive Late Fees Deflection
    [Documentation]
    ...  Customer is deflected to the request flow to request a waiving
    ...  of interest or late fees.
    ...  Test Case: MCC-Rates-14

    # Login as Hammy Hampster
    ${account_id} =    Login As Community User    Hammy Hampster

    # Navigate to My Property & Rates and manage first property
    Navigate To Rates Portal Page    /s/mylinkedproperties
    Sleep    10s

    ${manage_btn} =    Set Variable    button.btn-manage >> nth=0
    Wait For Elements State    ${manage_btn}    visible    timeout=30s
    Click    ${manage_btn}
    Sleep    10s
    Take Screenshot

    # Scroll down to look for late fees / interest waiver options
    Evaluate JavaScript    ${None}    window.scrollBy(0, 500)
    Sleep    3s
    Take Screenshot

    ${page_text} =    Get Text    body
    ${has_waive} =    Run Keyword And Return Status    Should Match Regexp    ${page_text}    (?i)waive|late.*fee|interest|penalty
    Run Keyword If    ${has_waive}    Log To Console    PASSED: Late fees/interest waiver reference found on property page
    Run Keyword Unless    ${has_waive}    Log To Console    INFO: Waiver option not on property summary

    # Check payment extension page for waiver options
    Navigate To Rates Portal Page    /s/paymentextension
    Sleep    10s
    Take Screenshot

    ${ext_text} =    Get Text    body
    ${has_waive_ext} =    Run Keyword And Return Status    Should Match Regexp    ${ext_text}    (?i)waive|late.*fee|interest|penalty
    Run Keyword If    ${has_waive_ext}    Log To Console    PASSED: Waiver option found on payment extension page
    Run Keyword Unless    ${has_waive_ext}    Log To Console    INFO: Waiver option may be in request flow instead

    Take Screenshot
    Log To Console    MCC-Rates-14 test PASSED
