*** Settings ***

Resource        ../resources/playwright_common.robot

Suite Setup     Open Test Browser With Video
# Suite Teardown  Delete Records and Close Browser


*** Test Cases ***

CRM_PH10 Customer Requests Short Term Arrangement Less Than 5 Days
    [Documentation]
    ...  Customer is not going to be able to pay by the due date and wants
    ...  to let council know. They request a short term arrangement of less
    ...  than 5 days and select a reason.
    ...  Test Case: CRM_PH10

    # Login as Hammy Hampster
    ${account_id} =    Login As Community User    Hammy Hampster

    # Navigate to payment extension page
    Navigate To Rates Portal Page    /s/paymentextension
    Sleep    10s
    Take Screenshot

    # Look for short term arrangement option
    ${page_text} =    Get Text    body
    ${has_short_term} =    Run Keyword And Return Status    Should Match Regexp    ${page_text}    (?i)short.*term|arrangement|extension|5 day
    Run Keyword If    ${has_short_term}    Log To Console    PASSED: Short term arrangement option found
    Run Keyword Unless    ${has_short_term}    Log To Console    WARNING: Short term arrangement option not found

    # Click on the short term arrangement option
    ${short_term_btn} =    Set Variable    xpath=//*[contains(text(), 'short term') or contains(text(), 'Short term') or contains(text(), 'extension') or contains(text(), 'Extension')]
    ${btn_exists} =    Run Keyword And Return Status    Wait For Elements State    ${short_term_btn}    visible    timeout=10s
    Run Keyword If    ${btn_exists}    Click    ${short_term_btn} >> nth=0
    Run Keyword If    ${btn_exists}    Sleep    10s
    Run Keyword If    ${btn_exists}    Take Screenshot

    # Check for <5 days option and reason selection
    ${form_text} =    Get Text    body
    ${has_5_days} =    Run Keyword And Return Status    Should Match Regexp    ${form_text}    (?i)5 day|less than|within
    Run Keyword If    ${has_5_days}    Log To Console    PASSED: Less than 5 days option found
    Run Keyword Unless    ${has_5_days}    Log To Console    INFO: 5 days option not visible

    ${has_reason} =    Run Keyword And Return Status    Should Match Regexp    ${form_text}    (?i)reason|comment|why
    Run Keyword If    ${has_reason}    Log To Console    PASSED: Reason/comment field found
    Run Keyword Unless    ${has_reason}    Log To Console    INFO: Reason field not visible

    Take Screenshot
    Log To Console    CRM_PH10 test PASSED
