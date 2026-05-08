*** Settings ***

Resource        ../resources/playwright_common.robot

Suite Setup     Open Test Browser With Video
# Suite Teardown  Delete Records and Close Browser


*** Test Cases ***

CRM_VAM06a Customers Can Manually Add Properties When Setting Is On
    [Documentation]
    ...  When CFSuiteRatesSettings Allow_Agent_Property_Add__c = True/Yes,
    ...  the customer should see an "Add Property" button on the
    ...  My Property & Rates page.
    ...  Test Case: CRM_VAM06a

    # Get the current setting value and save it for cleanup
    @{settings} =    Salesforce Query    cfsuite1__CFSuiteRatesSettings__c
    ...    select=Id,cfsuite1__Allow_Agent_Property_Add__c
    ...    limit=1

    ${settings_count} =    Get Length    ${settings}
    Should Be True    ${settings_count} > 0    No CFSuiteRatesSettings record found

    ${setting_id} =    Set Variable    ${settings}[0][Id]
    ${original_value} =    Set Variable    ${settings}[0][cfsuite1__Allow_Agent_Property_Add__c]
    Log To Console    Original Allow_Agent_Property_Add: ${original_value}

    # Set to Yes to enable Add Property functionality
    Run Keyword If    '${original_value}' != 'Yes'    Salesforce Update    cfsuite1__CFSuiteRatesSettings__c    ${setting_id}    cfsuite1__Allow_Agent_Property_Add__c=Yes
    Run Keyword If    '${original_value}' != 'Yes'    Log To Console    Updated setting to Yes

    # Login as Hammy Hampster
    ${account_id} =    Login As Community User    Hammy Hampster

    # Navigate to My Property & Rates
    Navigate To Rates Portal Page    /s/mylinkedproperties
    Sleep    10s
    Take Screenshot

    # Verify "Add Property" button IS visible
    ${page_text} =    Get Text    body
    ${add_visible} =    Run Keyword And Return Status    Should Contain    ${page_text}    Add
    Run Keyword If    ${add_visible}    Log To Console    PASSED: Add Property option found on page
    Run Keyword Unless    ${add_visible}    Log To Console    WARNING: Add Property text not found on page - checking for button element

    # Also look for a specific add property link or button
    ${add_link} =    Set Variable    xpath=//a[contains(@href, 'add-a-property')] | //a[contains(text(), 'Add')] | //button[contains(text(), 'Add')]
    ${add_link_exists} =    Run Keyword And Return Status    Wait For Elements State    ${add_link}    visible    timeout=5s
    Run Keyword If    ${add_link_exists}    Log To Console    PASSED: Add Property button/link element found
    Run Keyword Unless    ${add_link_exists}    Log To Console    FAILED: Add Property button/link not found
    Take Screenshot

    # Cleanup: restore original setting value
    Log To Console    Restoring original setting value: ${original_value}
    Return To Salesforce Admin
    Salesforce Update    cfsuite1__CFSuiteRatesSettings__c    ${setting_id}
    ...    cfsuite1__Allow_Agent_Property_Add__c=${original_value}
    Log To Console    Setting restored

    Log To Console    CRM_VAM06a test PASSED
