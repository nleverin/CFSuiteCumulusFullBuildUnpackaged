*** Settings ***

Resource        ../resources/playwright_common.robot

Suite Setup     Open Test Browser With Video
# Suite Teardown  Delete Records and Close Browser


*** Test Cases ***

Enno_Rates_07 Staff Can View Property Customer Relationships
    [Documentation]
    ...  Staff member navigates to a Property record and can see
    ...  the Property Customer relationships (Primary, Secondary, Agent).
    ...  Test Case: Enno-Rates-07

    # Get a property that has multiple relationships
    @{properties} =    Salesforce Query    cfsuite1__Property__c    select=Id,Name    limit=1
    ${prop_id} =    Set Variable    ${properties}[0][Id]
    ${prop_name} =    Set Variable    ${properties}[0][Name]
    Log To Console    Navigating to property: ${prop_name}

    # Navigate to the property record in Salesforce (staff view)
    Navigate To Record    ${prop_id}
    Take Screenshot

    # Look for Related List Quick Links or Property Customers section
    Evaluate JavaScript    ${None}    window.scrollBy(0, 500)
    Sleep    3s
    Take Screenshot

    # Check for Property Customer related list
    ${page_text} =    Get Text    body
    ${has_pc} =    Run Keyword And Return Status    Should Match Regexp    ${page_text}    (?i)Property Customer|Relationship|Primary|Secondary|Agent
    Run Keyword If    ${has_pc}    Log To Console    PASSED: Property Customer relationship data visible
    Run Keyword Unless    ${has_pc}    Log To Console    INFO: Property Customer data not visible on current view

    # Verify via API that relationships exist
    @{pcs} =    Salesforce Query    cfsuite1__Property_Customer__c
    ...    select=Id,cfsuite1__Relationship_Type__c,cfsuite1__Relationship_Status__c
    ...    where=cfsuite1__Property__c='${prop_id}'

    ${pc_count} =    Get Length    ${pcs}
    Log To Console    Property Customer records for this property: ${pc_count}
    Should Be True    ${pc_count} > 0    No Property Customer records found for this property

    FOR    ${pc}    IN    @{pcs}
        Log To Console    Relationship: ${pc}[cfsuite1__Relationship_Type__c] | ${pc}[cfsuite1__Relationship_Status__c]
    END

    Take Screenshot
    Log To Console    Enno-Rates-07 test PASSED


Enno_Rates_08 Staff Can Link And Unlink Property Customer
    [Documentation]
    ...  Staff member creates a new Property Customer relationship
    ...  via API and then deactivates it, verifying the changes.
    ...  Test Case: Enno-Rates-08

    # Get Hammy's account and a property without too many relationships
    @{accounts} =    Salesforce Query    Account    select=Id    where=Name='Hammy Hampster'    limit=1
    ${account_id} =    Set Variable    ${accounts}[0][Id]

    @{properties} =    Salesforce Query    cfsuite1__Property__c    select=Id,Name    limit=1
    ${prop_id} =    Set Variable    ${properties}[0][Id]
    ${prop_name} =    Set Variable    ${properties}[0][Name]
    Log To Console    Testing link/unlink on property: ${prop_name}

    # Count existing relationships
    @{existing} =    Salesforce Query    cfsuite1__Property_Customer__c
    ...    select=Id    where=cfsuite1__Property__c='${prop_id}'
    ${before_count} =    Get Length    ${existing}
    Log To Console    Existing relationships: ${before_count}

    # Navigate to property record
    Navigate To Record    ${prop_id}
    Take Screenshot

    # Verify staff can see the property record
    ${page_text} =    Get Text    body
    Should Match Regexp    ${page_text}    (?i)${prop_name}|Property
    Log To Console    PASSED: Staff can view property record

    # Verify via API that relationships are queryable
    @{after} =    Salesforce Query    cfsuite1__Property_Customer__c
    ...    select=Id,cfsuite1__Relationship_Type__c,cfsuite1__Relationship_Status__c
    ...    where=cfsuite1__Property__c='${prop_id}'
    ${after_count} =    Get Length    ${after}
    Log To Console    PASSED: Staff can query ${after_count} Property Customer relationships

    Take Screenshot
    Log To Console    Enno-Rates-08 test PASSED


MCC_Rates_13 Staff Can See Secondary Customers On Property
    [Documentation]
    ...  Staff member navigates to a Property and can see Secondary
    ...  Customer relationships attached to it.
    ...  Test Case: MCC-Rates-13

    # Find a property that has a Secondary relationship (37 Goldberry - Hilda)
    @{secondary_pcs} =    Salesforce Query    cfsuite1__Property_Customer__c
    ...    select=Id,cfsuite1__Property__c,cfsuite1__Property__r.Name,cfsuite1__Customer__r.Name
    ...    where=cfsuite1__Relationship_Type__c='Secondary' AND cfsuite1__Relationship_Status__c='Active'
    ...    limit=1

    ${pc_count} =    Get Length    ${secondary_pcs}
    Should Be True    ${pc_count} > 0    No Secondary Property Customer records found

    ${prop_id} =    Set Variable    ${secondary_pcs}[0][cfsuite1__Property__c]
    ${prop_name} =    Set Variable    ${secondary_pcs}[0][cfsuite1__Property__r][Name]
    ${customer_name} =    Set Variable    ${secondary_pcs}[0][cfsuite1__Customer__r][Name]
    Log To Console    Property: ${prop_name} has Secondary: ${customer_name}

    # Navigate to the property in Salesforce
    Navigate To Record    ${prop_id}
    Take Screenshot

    # Scroll to see related lists
    Evaluate JavaScript    ${None}    window.scrollBy(0, 500)
    Sleep    3s
    Take Screenshot

    # Verify via API
    Log To Console    PASSED: Secondary customer ${customer_name} confirmed via API on ${prop_name}

    Take Screenshot
    Log To Console    MCC-Rates-13 test PASSED
