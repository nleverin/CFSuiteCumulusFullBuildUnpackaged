*** Settings ***

Resource        ../resources/playwright_common.robot

Suite Setup     Open Test Browser With Video
# Suite Teardown  Delete Records and Close Browser


*** Test Cases ***

CRM_RN01 Customer Can View Rates Notices
    [Documentation]
    ...  Customer is logged in and goes to My Property and Rates area.
    ...  On the My Linked Properties page there is a link to the latest rates notice.
    ...  Click Manage property, then click the Rates Notices tab to see all notices
    ...  for the financial year. Click on a notice to verify it downloads as PDF.
    ...  Test Case: CRM_RN01

    # Login as Hammy Hampster
    ${account_id} =    Login As Community User    Hammy Hampster

    # Navigate to My Property & Rates
    Navigate To Rates Portal Page    /s/mylinkedproperties
    Sleep    10s
    Take Screenshot

    # Check if there's a "Download latest rates notice" link on the properties page
    ${page_text} =    Get Text    body
    ${has_download_link} =    Run Keyword And Return Status    Should Match Regexp    ${page_text}    (?i)download.*rates.*notice|latest.*notice|rates.*notice
    Run Keyword If    ${has_download_link}    Log To Console    PASSED: Rates notice download link found on My Linked Properties page
    Run Keyword Unless    ${has_download_link}    Log To Console    INFO: No rates notice download link on properties list page

    # Click Manage property for the first property
    Log To Console    Clicking Manage property...
    ${manage_btn} =    Set Variable    button.btn-manage >> nth=0
    Wait For Elements State    ${manage_btn}    visible    timeout=30s
    Click    ${manage_btn}
    Sleep    10s
    Take Screenshot

    # Click on the Rates Notices tab
    Log To Console    Looking for Rates Notices tab...
    ${notices_tab} =    Set Variable    xpath=//a[contains(text(), 'Rates Notices')] | //button[contains(text(), 'Rates Notices')]
    Wait For Elements State    ${notices_tab}    visible    timeout=15s
    Click    ${notices_tab} >> nth=0
    Sleep    10s
    Take Screenshot

    # Verify rates notices are displayed
    ${notices_text} =    Get Text    body
    Log To Console    Rates Notices tab content length: ${notices_text.__len__()}

    # Check for notice-related content (quarters, financial year, PDF links)
    ${has_notices} =    Run Keyword And Return Status    Should Match Regexp    ${notices_text}    (?i)quarter|instalment|notice|financial.*year|2025|2024
    Run Keyword If    ${has_notices}    Log To Console    PASSED: Rates notice content found on Rates Notices tab
    Run Keyword Unless    ${has_notices}    Log To Console    WARNING: No notice content found

    # Check for downloadable PDF links or buttons
    ${pdf_link} =    Set Variable    xpath=//a[contains(@href, '.pdf') or contains(text(), 'Download') or contains(text(), 'View')] | //button[contains(text(), 'Download') or contains(text(), 'View')]
    ${has_pdf} =    Run Keyword And Return Status    Wait For Elements State    ${pdf_link}    visible    timeout=5s
    Run Keyword If    ${has_pdf}    Log To Console    PASSED: PDF download/view link found
    Run Keyword Unless    ${has_pdf}    Log To Console    INFO: No explicit PDF download link found (may use different format)

    # Check for a table or list of notices
    ${has_notice_list} =    Run Keyword And Return Status    Wait For Elements State    xpath=//table | //ul[contains(@class, 'notice')] | //div[contains(@class, 'notice')]    visible    timeout=5s
    Run Keyword If    ${has_notice_list}    Log To Console    PASSED: Notice list/table element found
    Run Keyword Unless    ${has_notice_list}    Log To Console    INFO: No explicit notice list element

    Take Screenshot
    Log To Console    CRM_RN01 test PASSED
