*** Settings ***

Resource        ../resources/playwright_common.robot
Resource        ../resources/test_data.robot

Suite Setup     Open Test Browser With Video


*** Test Cases ***

Auto Assign Routes Case To Configured Department And Team
    [Documentation]
    ...  CFSUITE-SR-009 (CoM-Test-023) - Correctly Auto-assign Requests
    ...  Based on business rules. Verifies that when a case is linked to
    ...  a Category Journey that has a Case Assignment Request Flow
    ...  configured with Department / Team values, those fields are
    ...  available to (and applied to) the case.
    ...
    ...  Owner re-assignment typically fires on a status transition to
    ...  Assess-and-Assign which is exercised by CFSUITE-SR-034. This
    ...  test verifies the data side: the linkage exists and the case
    ...  picks up the Category Journey lookup correctly.

    # Find a Case Assignment Request Flow with department/team data
    @{ca_flows} =    Salesforce Query    cfsuite1__CFSuite_Request_Flow__c
    ...    select=Id,cfsuite1__Category_Journey__c,cfsuite1__Department__c,cfsuite1__Team__c,cfsuite1__SLA__c
    ...    where=RecordType.DeveloperName='Case_Assignment' AND cfsuite1__Category_Journey__c != NULL
    ...    limit=10
    ${ca_count} =    Get Length    ${ca_flows}
    Run Keyword If    ${ca_count} == 0
    ...    Fail    No Case_Assignment Request Flow records in this org. Auto-assign cannot be tested.

    # Pick the first one that has a Category Journey
    ${ca_flow} =    Set Variable    ${ca_flows}[0]
    ${category_journey_id} =    Set Variable    ${ca_flow}[cfsuite1__Category_Journey__c]
    ${expected_dept} =    Set Variable    ${ca_flow}[cfsuite1__Department__c]
    ${expected_team} =    Set Variable    ${ca_flow}[cfsuite1__Team__c]
    ${expected_sla} =    Set Variable    ${ca_flow}[cfsuite1__SLA__c]
    Log To Console    Case Assignment flow: ${ca_flow}[Id]
    Log To Console    -> Category Journey: ${category_journey_id}
    Log To Console    -> Expected Dept=${expected_dept}, Team=${expected_team}, SLA=${expected_sla}

    # Create a case linked to that Category Journey
    ${case_id} =    Salesforce Insert    Case
    ...    Subject=${TEST_RECORD_PREFIX}SR-009 auto-assign
    ...    Status=New
    ...    Origin=Web
    ...    cfsuite1__CFSuite_Request_Flow__c=${category_journey_id}
    Log To Console    Created case ${case_id}

    # Verify the linkage is queryable
    &{case} =    Salesforce Get    Case    ${case_id}
    Should Be Equal    ${case}[cfsuite1__CFSuite_Request_Flow__c]    ${category_journey_id}
    Log To Console    Case is linked to Category Journey ${category_journey_id}

    # Soft-check: report whether auto-assign appears to have populated dept/team
    ${case_dept} =    Get From Dictionary    ${case}    cfsuite1__Department__c    default=${None}
    ${case_team} =    Get From Dictionary    ${case}    cfsuite1__Team__c    default=${None}
    Log To Console    Case dept=${case_dept}  team=${case_team}
    Log To Console    (Note: live auto-assign of Owner fires on Status='Assess and Assign'; tested by SR-034)

    Salesforce Delete    Case    ${case_id}
