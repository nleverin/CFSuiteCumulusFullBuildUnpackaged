*** Settings ***

Resource        ../resources/playwright_common.robot

Suite Setup     Open Test Browser With Video
# Suite Teardown  Delete Records and Close Browser


*** Test Cases ***

CRM_AM02 Customer Cannot See Properties They No Longer Own
    [Documentation]
    ...  A customer who owns a property can see it in the portal.
    ...  A SF administrator marks the property customer inactive.
    ...  The customer logs in and cannot see the property.
    ...  Test Case: CRM_AM02

    # Find a property with an Active Primary relationship to deactivate
    @{active_pcs} =    Salesforce Query    cfsuite1__Property_Customer__c
    ...    select=Id,cfsuite1__Property__r.Name,cfsuite1__Relationship_Type__c,cfsuite1__Relationship_Status__c
    ...    where=cfsuite1__Relationship_Status__c='Active' AND cfsuite1__Relationship_Type__c='Primary'
    ...    limit=1

    ${pc_count} =    Get Length    ${active_pcs}
    Should Be True    ${pc_count} > 0    No Active Primary property customer records found

    ${pc_id} =    Set Variable    ${active_pcs}[0][Id]
    ${prop_full_name} =    Set Variable    ${active_pcs}[0][cfsuite1__Property__r][Name]
    ${prop_address} =    Evaluate    '${prop_full_name}'.rsplit(' (', 1)[0] if ' (' in '${prop_full_name}' else '${prop_full_name}'
    Log To Console    Will deactivate property customer for: ${prop_address} (ID: ${pc_id})

    # Step 1: Deactivate the property customer via API
    Log To Console    Setting property customer to Inactive...
    Salesforce Update    cfsuite1__Property_Customer__c    ${pc_id}
    ...    cfsuite1__Relationship_Status__c=Inactive

    # Step 2: Login as community user and check the property is NOT visible
    ${account_id} =    Login As Community User    Hammy Hampster
    Navigate To Rates Portal Page    /s/mylinkedproperties
    Sleep    10s
    Take Screenshot

    ${page_text} =    Get Text    body
    ${property_visible} =    Run Keyword And Return Status    Should Contain    ${page_text}    ${prop_address}
    Run Keyword If    ${property_visible}    Fail    Property ${prop_address} should NOT be visible after deactivation
    Log To Console    PASSED: Property ${prop_address} is NOT visible after deactivation

    # Step 3: Reactivate the property customer (cleanup)
    Log To Console    Reactivating property customer...
    Return To Salesforce Admin
    Salesforce Update    cfsuite1__Property_Customer__c    ${pc_id}
    ...    cfsuite1__Relationship_Status__c=Active
    Log To Console    Property customer reactivated

    Log To Console    CRM_AM02 test PASSED
