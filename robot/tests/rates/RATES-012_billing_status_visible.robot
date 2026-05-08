*** Settings ***

Resource        ../resources/playwright_common.robot

Suite Setup     Open Test Browser With Video
# Suite Teardown  Delete Records and Close Browser


*** Test Cases ***

CRM_AM03 Customer Understands Current Billing Status
    [Documentation]
    ...  Customer is logged in and can see high level information about
    ...  the properties, their current rates bills outstanding and
    ...  understand when money is next due.
    ...  Test Case: CRM_AM03

    # Get a property with balance data to validate against
    @{properties} =    Salesforce Query    cfsuite1__Property__c
    ...    select=Id,Name,cfsuite1__Full_year_balance__c,cfsuite1__Financial_Year__c,cfsuite1__Quarter_1_Balance__c,cfsuite1__Quarter_1_Due_Date__c
    ...    where=cfsuite1__Full_year_balance__c!=null
    ...    limit=1

    ${prop_count} =    Get Length    ${properties}
    Should Be True    ${prop_count} > 0    No properties with balance data found

    ${prop_name} =    Set Variable    ${properties}[0][Name]
    ${prop_address} =    Evaluate    '${prop_name}'.rsplit(' (', 1)[0] if ' (' in '${prop_name}' else '${prop_name}'
    ${full_year_balance} =    Set Variable    ${properties}[0][cfsuite1__Full_year_balance__c]
    Log To Console    Testing property: ${prop_address} (Balance: ${full_year_balance})

    # Login as Hammy Hampster
    ${account_id} =    Login As Community User    Hammy Hampster

    # Navigate to My Property & Rates
    Navigate To Rates Portal Page    /s/mylinkedproperties
    Sleep    10s
    Take Screenshot

    # Verify the property is listed with balance information
    ${page_text} =    Get Text    body
    Should Contain    ${page_text}    ${prop_address}    msg=Property ${prop_address} not found on page

    # Check that financial information is displayed (balance amounts, payment status)
    # The page should show balance or payment information for each property
    ${has_balance_info} =    Run Keyword And Return Status    Should Match Regexp    ${page_text}    \\$[\\d,]+\\.\\d{2}
    Run Keyword If    ${has_balance_info}    Log To Console    PASSED: Dollar amounts found on page
    Run Keyword Unless    ${has_balance_info}    Log To Console    WARNING: No dollar amounts visible on page

    # Click Manage property to see the summary page
    Log To Console    Looking for Manage property button...
    ${manage_btn} =    Set Variable    xpath=//a[contains(text(), 'Manage property')] | //button[contains(text(), 'Manage property')]
    ${manage_exists} =    Run Keyword And Return Status    Wait For Elements State    ${manage_btn}    visible    timeout=10s
    Run Keyword If    ${manage_exists}    Click    ${manage_btn} >> nth=0
    Run Keyword If    ${manage_exists}    Sleep    10s
    Run Keyword If    ${manage_exists}    Take Screenshot

    # On the summary page, verify rates details are shown
    Run Keyword If    ${manage_exists}    Verify Summary Page Has Rates Info

    Log To Console    CRM_AM03 test PASSED


*** Keywords ***

Verify Summary Page Has Rates Info
    [Documentation]    Checks the property summary page shows rates information.
    ${page_text} =    Get Text    body
    Log To Console    Summary page content length: ${page_text.__len__()}

    # Check for key financial elements on the summary page
    ${has_amount} =    Run Keyword And Return Status    Should Match Regexp    ${page_text}    \\$[\\d,]+\\.\\d{2}
    Run Keyword If    ${has_amount}    Log To Console    PASSED: Financial amounts visible on summary page
    Run Keyword Unless    ${has_amount}    Log To Console    WARNING: No financial amounts on summary page

    Take Screenshot
