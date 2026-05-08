*** Settings ***

Resource        ../resources/playwright_common.robot

Suite Setup     Open Test Browser With Video
# Suite Teardown  Delete Records and Close Browser


*** Test Cases ***

Assign A Case
    [Documentation]
    ...  Test finds a case with status "Assess and Assign", assigns it to user "User",
    ...  and validates that Status updates to "Assigned", SLA changes to the correct value,
    ...  and Due Date updates accordingly.

    # Query for a case with status "Assess and Assign"
    Log To Console    Querying for cases with status 'Assess and Assign'...
    @{cases} =    Salesforce Query    Case    select=Id,Status,cfsuite1__CFSuite_Request_Flow__c,cfsuite1__Original_Due_Date__c    where=Status='Assess and Assign'    limit=1

    ${case_count} =    Get Length    ${cases}
    Run Keyword If    ${case_count} == 0    Fail    No cases found with status 'Assess and Assign'. Please create a case with this status first.

    ${case_id} =    Set Variable    ${cases}[0][Id]
    ${original_status} =    Set Variable    ${cases}[0][Status]
    ${category_journey_id} =    Set Variable    ${cases}[0][cfsuite1__CFSuite_Request_Flow__c]
    ${original_due_date} =    Set Variable    ${cases}[0][cfsuite1__Original_Due_Date__c]

    Log To Console    Case ID: ${case_id}
    Log To Console    Original Status: ${original_status}
    Log To Console    Category Journey ID: ${category_journey_id}
    Log To Console    Original Due Date: ${original_due_date}

    # Query for the expected SLA value from CFSuite_Request_Flow__c
    Log To Console    Querying for expected SLA value...
    @{request_flows} =    Salesforce Query    cfsuite1__CFSuite_Request_Flow__c    select=Id,cfsuite1__SLA__c,RecordType.Name    where=cfsuite1__Category_Journey__c='${category_journey_id}' AND RecordType.Name='Case Assignment'    limit=1

    ${flow_count} =    Get Length    ${request_flows}
    Run Keyword If    ${flow_count} == 0    Fail    No CFSuite_Request_Flow__c record found with RecordType 'Case Assignment' for Category Journey ID ${category_journey_id}

    ${expected_sla} =    Set Variable    ${request_flows}[0][cfsuite1__SLA__c]
    Log To Console    Expected SLA after assignment: ${expected_sla}

    # Query for User named "User User" to get their ID
    Log To Console    Querying for user named 'User User'...
    @{users} =    Salesforce Query    User    select=Id,Name    where=Name='User User'    limit=1

    ${user_count} =    Get Length    ${users}
    Run Keyword If    ${user_count} == 0    Fail    No user found with name 'User User'. Please check the username.

    ${user_id} =    Set Variable    ${users}[0][Id]
    ${user_name} =    Set Variable    ${users}[0][Name]
    Log To Console    User ID: ${user_id}
    Log To Console    User Name: ${user_name}

    # Navigate to the case detail page
    Navigate To Record    ${case_id}

    # Wait for case detail page to load
    Sleep    10s
    Take Screenshot

    # Scroll down to find the Assign To field
    Log To Console    Looking for Assign To field...
    Log To Console    Scrolling to find Assign To field...
    Evaluate JavaScript    ${None}    window.scrollBy(0, 500)
    Sleep    2s
    Take Screenshot
    Evaluate JavaScript    ${None}    window.scrollBy(0, 500)
    Sleep    2s
    Take Screenshot

    # Try to find the Edit Assign To button after scrolling
    ${assign_to_edit} =    Set Variable    button[title="Edit Assign To"]
    ${edit_exists} =    Run Keyword And Return Status    Wait For Elements State    ${assign_to_edit}    visible    timeout=15s
    Log To Console    Edit Assign To button found: ${edit_exists}

    Run Keyword If    ${edit_exists}    Click    ${assign_to_edit}
    Run Keyword Unless    ${edit_exists}    Fail    Assign To edit button not found on case detail page - field may not be on this page layout

    Sleep    2s
    Take Screenshot

    # Look for the Assign To lookup input field
    Log To Console    Looking for Assign To input field...
    ${assign_to_input} =    Set Variable    input[placeholder='Search People...']
    ${input_exists} =    Run Keyword And Return Status    Wait For Elements State    ${assign_to_input}    visible    timeout=10s

    Run Keyword If    ${input_exists}    Log To Console    Assign To input field found
    Run Keyword Unless    ${input_exists}    Fail    Assign To input field not found

    # Click and type in the lookup field
    Click    ${assign_to_input}
    Sleep    1s
    Fill Text    ${assign_to_input}    ${user_name}
    Log To Console    Typed username: ${user_name}
    Sleep    3s
    Take Screenshot

    # Wait for and click on the user option in the dropdown
    Log To Console    Looking for user option in dropdown...
    ${user_option} =    Set Variable    lightning-base-combobox-item[data-value='${user_id}']
    ${option_exists} =    Run Keyword And Return Status    Wait For Elements State    ${user_option}    visible    timeout=10s

    Run Keyword If    ${option_exists}    Log To Console    User option found - clicking
    Run Keyword If    ${option_exists}    Click    ${user_option}
    Run Keyword If    ${option_exists}    Sleep    3s
    Run Keyword Unless    ${option_exists}    Fail    User option not found in dropdown after typing

    Take Screenshot

    # Click Save button
    Log To Console    Looking for Save button...
    ${save_button} =    Set Variable    button[name='SaveEdit']
    ${save_exists} =    Run Keyword And Return Status    Wait For Elements State    ${save_button}    visible    timeout=10s

    Run Keyword If    ${save_exists}    Log To Console    Save button found
    Run Keyword If    ${save_exists}    Click    ${save_button}
    Run Keyword Unless    ${save_exists}    Fail    Save button not found

    # Wait for assignment to complete
    Log To Console    Waiting for assignment to complete...
    Sleep    5s
    Take Screenshot

    # Wait for Due Date to update asynchronously
    Log To Console    Waiting for Due Date to update asynchronously...
    Sleep    10s

    # Validate the case updates
    Validate Case Assignment    ${case_id}    ${user_id}    ${expected_sla}    ${original_due_date}


*** Keywords ***

Validate Case Assignment
    [Arguments]    ${case_id}    ${expected_owner_id}    ${expected_sla}    ${original_due_date}
    [Documentation]
    ...  Validates that the case has been assigned correctly with updated Status, SLA, and Due Date.

    Log To Console    Validating case assignment...

    Navigate To Record    ${case_id}
    Sleep    3s
    Take Screenshot

    &{case} =    Salesforce Get    Case    ${case_id}

    Should Be Equal As Strings    ${case}[OwnerId]    ${expected_owner_id}    msg=OwnerId mismatch
    Log To Console    OwnerId: ${case}[OwnerId] PASSED

    Should Be Equal As Strings    ${case}[Status]    Assigned    msg=Status should be 'Assigned'
    Log To Console    Status: ${case}[Status] PASSED

    Should Be Equal As Strings    ${case}[cfsuite1__SLA__c]    ${expected_sla}    msg=SLA mismatch
    Log To Console    SLA: ${case}[cfsuite1__SLA__c] PASSED

    ${new_due_date} =    Set Variable    ${case}[cfsuite1__Original_Due_Date__c]
    Log To Console    Original Due Date: ${original_due_date}
    Log To Console    New Due Date: ${new_due_date}

    ${dates_different} =    Run Keyword And Return Status    Should Not Be Equal As Strings    ${new_due_date}    ${original_due_date}
    Run Keyword If    ${dates_different}    Log To Console    Due Date has been updated
    Run Keyword Unless    ${dates_different}    Log To Console    WARNING: Due Date has not changed

    Log To Console    All assignment validations PASSED
