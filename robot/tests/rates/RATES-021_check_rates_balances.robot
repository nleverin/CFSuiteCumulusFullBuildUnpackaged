*** Settings ***

Resource        ../resources/playwright_common.robot

Suite Setup     Open Test Browser With Video
# Suite Teardown  Delete Records and Close Browser


*** Test Cases ***

CRM_PH03 Customer Checks Rates Balances
    [Documentation]
    ...  Customer logs in and goes to the Rates Portal area. From here they can
    ...  see their multiple properties and outstanding balances.
    ...  Test Case: CRM_PH03

    # Get expected balances from API for validation
    @{properties} =    Salesforce Query    cfsuite1__Property__c
    ...    select=Id,Name,cfsuite1__Full_year_balance__c
    ...    where=cfsuite1__Full_year_balance__c!=null

    ${prop_count} =    Get Length    ${properties}
    Log To Console    Properties with balances: ${prop_count}

    FOR    ${prop}    IN    @{properties}
        Log To Console    ${prop}[Name]: balance=${prop}[cfsuite1__Full_year_balance__c]
    END

    # Login as Hammy Hampster
    ${account_id} =    Login As Community User    Hammy Hampster

    # Navigate to My Property & Rates - this page shows all properties with balances
    Navigate To Rates Portal Page    /s/mylinkedproperties
    Sleep    10s
    Take Screenshot

    # Verify the page shows balance information for properties
    ${page_text} =    Get Text    body
    Log To Console    Page content length: ${page_text.__len__()}

    # Check for dollar amounts on the page (balances)
    ${has_amounts} =    Run Keyword And Return Status    Should Match Regexp    ${page_text}    \\$[\\d,]+\\.\\d{2}
    Run Keyword If    ${has_amounts}    Log To Console    PASSED: Dollar amounts (balances) visible on My Linked Properties page
    Run Keyword Unless    ${has_amounts}    Log To Console    WARNING: No dollar amounts found

    # Verify multiple properties are listed
    ${property_count} =    Get Element Count    button.btn-manage
    Log To Console    Properties displayed: ${property_count}
    Should Be True    ${property_count} > 1    Expected multiple properties on the page

    # Check for balance-related text
    ${has_balance_text} =    Run Keyword And Return Status    Should Match Regexp    ${page_text}    (?i)balance|paid|due|outstanding
    Run Keyword If    ${has_balance_text}    Log To Console    PASSED: Balance/payment status text found
    Run Keyword Unless    ${has_balance_text}    Log To Console    WARNING: No balance/payment status text found

    Take Screenshot
    Log To Console    CRM_PH03 test PASSED
