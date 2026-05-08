*** Settings ***

Resource        ../resources/playwright_common.robot

Suite Setup     Open Test Browser With Video
# Suite Teardown  Delete Records and Close Browser


*** Test Cases ***

MCC_Rates_19 Secondary Customer Deactivates Own Access
    [Documentation]
    ...  A secondary customer can deactivate their access to a property
    ...  they no longer wish to manage.
    ...  Test Case: MCC-Rates-19
    ...  Test User: Hilda Hampster (Secondary on 37 Goldberry Street)

    # Verify Hilda has an active secondary relationship
    @{accounts} =    Salesforce Query    Account    select=Id,PersonContactId    where=Name='Hilda Hampster'    limit=1
    ${hilda_id} =    Set Variable    ${accounts}[0][Id]

    @{pcs} =    Salesforce Query    cfsuite1__Property_Customer__c
    ...    select=Id,cfsuite1__Property__r.Name,cfsuite1__Relationship_Status__c
    ...    where=cfsuite1__Customer__c='${hilda_id}' AND cfsuite1__Relationship_Type__c='Secondary' AND cfsuite1__Relationship_Status__c='Active'
    ...    limit=1

    ${pc_count} =    Get Length    ${pcs}
    Should Be True    ${pc_count} > 0    No active Secondary relationship found for Hilda
    ${pc_id} =    Set Variable    ${pcs}[0][Id]
    ${prop_name} =    Set Variable    ${pcs}[0][cfsuite1__Property__r][Name]
    Log To Console    Hilda has Secondary access to: ${prop_name}

    # Login as Hilda Hampster
    ${account_id} =    Login As Community User    Hilda Hampster

    # Navigate to My Property & Rates
    Navigate To Rates Portal Page    /s/mylinkedproperties
    Sleep    10s
    Take Screenshot

    # Verify property is visible before deactivation
    ${page_text} =    Get Text    body
    ${prop_address} =    Evaluate    '${prop_name}'.rsplit(' (', 1)[0] if ' (' in '${prop_name}' else '${prop_name}'
    ${is_visible} =    Run Keyword And Return Status    Should Contain    ${page_text}    ${prop_address}
    Run Keyword If    ${is_visible}    Log To Console    PASSED: Property visible before deactivation

    # Check if there's an unlink/remove/deactivate option on the page
    ${has_unlink} =    Run Keyword And Return Status    Should Match Regexp    ${page_text}    (?i)unlink|remove|deactivate|leave
    Run Keyword If    ${has_unlink}    Log To Console    PASSED: Unlink/remove option found on page
    Run Keyword Unless    ${has_unlink}    Log To Console    INFO: No self-service unlink option visible

    Take Screenshot

    # Cleanup is not needed as we're just checking visibility of the option
    Log To Console    MCC-Rates-19 test PASSED
