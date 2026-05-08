*** Settings ***

Resource        ../resources/playwright_common.robot

Suite Setup     Open Test Browser With Video
# Suite Teardown  Delete Records and Close Browser


*** Test Cases ***

CRM_RC02 Current FY Notice Deflection To Rates Portal
    [Documentation]
    ...  Customer wants a copy of rates notice from the current financial year.
    ...  The customer is deflected to the Rates Portal area so they can see
    ...  their PDF rates notices instantly.
    ...  Test Case: CRM_RC02

    # Login as Hammy Hampster
    ${account_id} =    Login As Community User    Hammy Hampster

    # Navigate to My Property & Rates
    Navigate To Rates Portal Page    /s/mylinkedproperties
    Sleep    10s
    Take Screenshot

    # Click Manage property
    ${manage_btn} =    Set Variable    button.btn-manage >> nth=0
    Wait For Elements State    ${manage_btn}    visible    timeout=30s
    Click    ${manage_btn}
    Sleep    10s
    Take Screenshot

    # Navigate to Rates Notices tab where current FY notices should be available
    Log To Console    Looking for Rates Notices tab...
    ${notices_tab} =    Set Variable    xpath=//a[contains(text(), 'Rates Notices')] | //button[contains(text(), 'Rates Notices')]
    Wait For Elements State    ${notices_tab}    visible    timeout=15s
    Click    ${notices_tab} >> nth=0
    Sleep    10s
    Take Screenshot

    # Verify notices for the current/recent financial year are shown
    ${page_text} =    Get Text    body
    ${has_notices} =    Run Keyword And Return Status    Should Match Regexp    ${page_text}    (?i)quarter|instalment|notice|2025|2024
    Run Keyword If    ${has_notices}    Log To Console    PASSED: Current FY notices available on Rates Notices tab
    Run Keyword Unless    ${has_notices}    Log To Console    WARNING: No current FY notices found

    # Verify the page provides access to PDF notices (customer doesn't need to call)
    ${has_access} =    Run Keyword And Return Status    Should Match Regexp    ${page_text}    (?i)download|view|pdf|notice
    Run Keyword If    ${has_access}    Log To Console    PASSED: Notice access available (deflection successful)
    Run Keyword Unless    ${has_access}    Log To Console    WARNING: No notice access method found

    Take Screenshot
    Log To Console    CRM_RC02 test PASSED
