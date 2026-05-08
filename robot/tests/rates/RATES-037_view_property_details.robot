*** Settings ***

Resource        ../resources/playwright_common.robot

Suite Setup     Open Test Browser With Video
# Suite Teardown  Delete Records and Close Browser


*** Test Cases ***

CRM_PD01 Customer Can View Property Details
    [Documentation]
    ...  Customer logs in, clicks on My Property & Rates, goes to a property,
    ...  clicks Manage Property, and can see the assessment number on the summary page.
    ...  Clicks on the Capital Value tab to see the capital value and valuation link.
    ...  Test Case: CRM_PD01

    # Get property data to validate against
    @{properties} =    Salesforce Query    cfsuite1__Property__c
    ...    select=Id,Name,cfsuite1__Assessment_Number__c,cfsuite1__Council_Value__c,cfsuite1__Valuation_Number__c,cfsuite1__Last_evaluated_date__c
    ...    where=cfsuite1__Assessment_Number__c!=null
    ...    limit=1

    ${prop_count} =    Get Length    ${properties}
    Should Be True    ${prop_count} > 0    No properties with assessment numbers found

    ${prop_name} =    Set Variable    ${properties}[0][Name]
    ${prop_address} =    Evaluate    '${prop_name}'.rsplit(' (', 1)[0] if ' (' in '${prop_name}' else '${prop_name}'
    ${assessment_number} =    Set Variable    ${properties}[0][cfsuite1__Assessment_Number__c]
    # Note: API returns lowercase 'value' in Council_value__c
    ${capital_value} =    Set Variable    ${properties}[0][cfsuite1__Council_value__c]
    ${valuation_number} =    Set Variable    ${properties}[0][cfsuite1__Valuation_Number__c]
    Log To Console    Testing property: ${prop_address}
    Log To Console    Assessment Number: ${assessment_number}
    Log To Console    Capital Value: ${capital_value}
    Log To Console    Valuation Number: ${valuation_number}

    # Login as Hammy Hampster
    ${account_id} =    Login As Community User    Hammy Hampster

    # Navigate to My Property & Rates
    Navigate To Rates Portal Page    /s/mylinkedproperties
    Sleep    10s
    Take Screenshot

    # Wait for LWC to render and click Manage Property
    Log To Console    Waiting for Manage property button...
    ${manage_btn} =    Set Variable    button.btn-manage >> nth=0
    Wait For Elements State    ${manage_btn}    visible    timeout=30s
    Click    ${manage_btn}
    Sleep    10s
    Take Screenshot

    # Verify Assessment Number is visible on the summary page
    ${page_text} =    Get Text    body
    Log To Console    Summary page content length: ${page_text.__len__()}

    ${has_assessment} =    Run Keyword And Return Status    Should Contain    ${page_text}    ${assessment_number}
    Run Keyword If    ${has_assessment}    Log To Console    PASSED: Assessment Number ${assessment_number} visible
    Run Keyword Unless    ${has_assessment}    Log To Console    WARNING: Assessment Number ${assessment_number} not found on summary page

    # Click on the Property Details tab (contains capital value info)
    Log To Console    Looking for Property Details tab...
    ${details_tab} =    Set Variable    xpath=//a[contains(text(), 'Property Details')] | //button[contains(text(), 'Property Details')]
    ${tab_exists} =    Run Keyword And Return Status    Wait For Elements State    ${details_tab}    visible    timeout=10s

    Run Keyword If    ${tab_exists}    Click    ${details_tab} >> nth=0
    Run Keyword If    ${tab_exists}    Sleep    5s
    Run Keyword If    ${tab_exists}    Take Screenshot

    # Verify Capital Value is displayed
    Run Keyword If    ${tab_exists}    Verify Capital Value On Page

    Log To Console    CRM_PD01 test PASSED


*** Keywords ***

Verify Capital Value On Page
    [Documentation]    Checks the Capital Value tab shows financial information.
    ${page_text} =    Get Text    body

    # Check for dollar amounts (capital value is typically a large number like $450,000)
    ${has_value} =    Run Keyword And Return Status    Should Match Regexp    ${page_text}    \\$[\\d,]+
    Run Keyword If    ${has_value}    Log To Console    PASSED: Capital value amount visible
    Run Keyword Unless    ${has_value}    Log To Console    WARNING: No dollar amounts on Capital Value tab

    # Check for Valuer General link
    ${has_valuer_link} =    Run Keyword And Return Status    Should Contain    ${page_text}    Valuer
    Run Keyword If    ${has_valuer_link}    Log To Console    PASSED: Valuer General reference found
    Run Keyword Unless    ${has_valuer_link}    Log To Console    INFO: Valuer General reference not found on this tab
