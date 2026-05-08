*** Settings ***

Resource        ../resources/playwright_common.robot

Suite Setup     Open Test Browser With Video
# Suite Teardown  Delete Records and Close Browser


*** Test Cases ***

CRM_AM06 Customers Cannot Manually Add Properties When Setting Is Off
    [Documentation]
    ...  When CFSuiteRatesSettings Allow_Agent_Property_Add__c = False,
    ...  the customer should NOT see an "Add Property" button on the
    ...  My Property & Rates page.
    ...  Test Case: CRM_AM06

    # Ensure the setting is set to No/False
    @{settings} =    Salesforce Query    cfsuite1__CFSuiteRatesSettings__c
    ...    select=Id,cfsuite1__Allow_Agent_Property_Add__c
    ...    limit=1

    ${settings_count} =    Get Length    ${settings}
    Should Be True    ${settings_count} > 0    No CFSuiteRatesSettings record found

    ${setting_id} =    Set Variable    ${settings}[0][Id]
    ${current_value} =    Set Variable    ${settings}[0][cfsuite1__Allow_Agent_Property_Add__c]
    Log To Console    Current Allow_Agent_Property_Add: ${current_value}

    # Set to No if not already
    Run Keyword If    '${current_value}' != 'No'    Salesforce Update    cfsuite1__CFSuiteRatesSettings__c    ${setting_id}    cfsuite1__Allow_Agent_Property_Add__c=No
    Run Keyword If    '${current_value}' != 'No'    Log To Console    Updated setting to No

    # Login as Hammy Hampster
    ${account_id} =    Login As Community User    Hammy Hampster

    # Navigate to My Property & Rates
    Navigate To Rates Portal Page    /s/mylinkedproperties
    Sleep    10s
    Take Screenshot

    # Verify "Add Property" button is NOT visible
    ${page_text} =    Get Text    body
    ${add_property_visible} =    Run Keyword And Return Status    Should Contain    ${page_text}    Add Property
    Run Keyword If    ${add_property_visible}    Fail    "Add Property" button should NOT be visible when setting is off
    Log To Console    PASSED: "Add Property" button is NOT visible when Allow_Agent_Property_Add = No

    # Also check for any add property link/button element
    ${add_btn} =    Set Variable    xpath=//a[contains(text(), 'Add')] | //button[contains(text(), 'Add')]
    ${add_btn_exists} =    Run Keyword And Return Status    Wait For Elements State    ${add_btn}    visible    timeout=3s
    Run Keyword Unless    ${add_btn_exists}    Log To Console    PASSED: No Add button found on page

    Log To Console    CRM_AM06 test PASSED
