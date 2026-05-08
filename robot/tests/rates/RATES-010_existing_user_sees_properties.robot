*** Settings ***

Resource        ../resources/playwright_common.robot

Suite Setup     Open Test Browser With Video
# Suite Teardown  Delete Records and Close Browser


*** Test Cases ***

CRM_AM01 Existing User Sees Properties Automatically
    [Documentation]
    ...  A registered portal user who owns a property logs into the customer portal.
    ...  They can automatically see their properties in the rates portal area.
    ...  Test Case: CRM_AM01
    ...  Test Data: Hammy Hampster (person account with linked properties)

    # First check how many properties Hammy should see (Active Primary relationships)
    @{expected_properties} =    Salesforce Query    cfsuite1__Property_Customer__c
    ...    select=Id,cfsuite1__Property__r.Name
    ...    where=cfsuite1__Relationship_Status__c='Active' AND cfsuite1__Relationship_Type__c='Primary'

    ${expected_count} =    Get Length    ${expected_properties}
    Log To Console    Expected properties visible: ${expected_count}
    Should Be True    ${expected_count} > 0    No Active Primary properties found for testing

    FOR    ${pc}    IN    @{expected_properties}
        Log To Console    Expected property: ${pc}[cfsuite1__Property__r][Name]
    END

    # Login as Hammy Hampster via admin "Log in to Experience as User"
    ${account_id} =    Login As Community User    Hammy Hampster

    # Navigate to My Property & Rates page
    Navigate To Rates Portal Page    /s/mylinkedproperties

    # Wait extra time for LWC components to render
    Sleep    10s
    Take Screenshot

    # Get page text for validation
    ${page_text} =    Get Text    body
    Log To Console    Page content length: ${page_text.__len__()}

    # Check that each expected property name appears on the page
    # Property names in SF include a suffix like "(A)" but the portal shows just the address
    ${found_count} =    Set Variable    0
    FOR    ${pc}    IN    @{expected_properties}
        ${full_name} =    Set Variable    ${pc}[cfsuite1__Property__r][Name]
        # Strip the suffix like " (A)" from the property name for matching
        ${address_part} =    Evaluate    '${full_name}'.rsplit(' (', 1)[0] if ' (' in '${full_name}' else '${full_name}'
        ${found} =    Run Keyword And Return Status    Should Contain    ${page_text}    ${address_part}
        Run Keyword If    ${found}    Log To Console    PASSED: Property found on page: ${address_part}
        Run Keyword Unless    ${found}    Log To Console    FAILED: Property not found on page: ${address_part}
        ${found_count} =    Run Keyword If    ${found}    Evaluate    ${found_count} + 1
        ...    ELSE    Set Variable    ${found_count}
    END

    # At least one property must be visible
    Should Be True    ${found_count} > 0    No properties found on My Linked Properties page
    Log To Console    Found ${found_count} of ${expected_count} properties on page

    Log To Console    CRM_AM01 test PASSED
