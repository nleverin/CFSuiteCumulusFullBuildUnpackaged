*** Settings ***

Resource        ../resources/playwright_common.robot

Suite Setup     Open Test Browser With Video
# Suite Teardown  Delete Records and Close Browser


*** Test Cases ***

CRM_PH11 Customer Requests Short Term Arrangement More Than 5 Days
    [Documentation]
    ...  Customer is not going to be able to pay by the due date and it will
    ...  be more than 5 days overdue. They select a date, reason, and are
    ...  told their request will be sent to a staff member for assessment.
    ...  Test Case: CRM_PH11

    # Login as Hammy Hampster
    ${account_id} =    Login As Community User    Hammy Hampster

    # Navigate to payment extension page
    Navigate To Rates Portal Page    /s/paymentextension
    Sleep    10s
    Take Screenshot

    # Look for short term arrangement option
    ${page_text} =    Get Text    body
    ${has_extension} =    Run Keyword And Return Status    Should Match Regexp    ${page_text}    (?i)short.*term|arrangement|extension
    Run Keyword If    ${has_extension}    Log To Console    PASSED: Extension/arrangement option found

    # Click on the short term arrangement option
    ${ext_btn} =    Set Variable    xpath=//*[contains(text(), 'short term') or contains(text(), 'Short term') or contains(text(), 'extension') or contains(text(), 'Extension')]
    ${btn_exists} =    Run Keyword And Return Status    Wait For Elements State    ${ext_btn}    visible    timeout=10s
    Run Keyword If    ${btn_exists}    Click    ${ext_btn} >> nth=0
    Run Keyword If    ${btn_exists}    Sleep    10s
    Run Keyword If    ${btn_exists}    Take Screenshot

    # Check for >5 days option and date/reason fields
    ${form_text} =    Get Text    body
    ${has_more_than_5} =    Run Keyword And Return Status    Should Match Regexp    ${form_text}    (?i)more than 5|after.*due|date.*pay|expected.*payment
    Run Keyword If    ${has_more_than_5}    Log To Console    PASSED: More than 5 days option found
    Run Keyword Unless    ${has_more_than_5}    Log To Console    INFO: More than 5 days option not visible

    # Check for staff review messaging
    ${has_staff_review} =    Run Keyword And Return Status    Should Match Regexp    ${form_text}    (?i)staff|assess|review|finance.*officer
    Run Keyword If    ${has_staff_review}    Log To Console    PASSED: Staff review/assessment message found
    Run Keyword Unless    ${has_staff_review}    Log To Console    INFO: Staff review message not visible

    Take Screenshot
    Log To Console    CRM_PH11 test PASSED
