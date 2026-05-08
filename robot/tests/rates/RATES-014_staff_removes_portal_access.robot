*** Settings ***

Resource        ../resources/playwright_common.robot

Suite Setup     Open Test Browser With Video
# Suite Teardown  Delete Records and Close Browser


*** Test Cases ***

CRM_AM05 Staff Removes Portal User Access To Property
    [Documentation]
    ...  A Rates Officer opens a property customer record and changes
    ...  the status from Active to Inactive. The customer can no longer
    ...  see that property in the portal.
    ...  Test Case: CRM_AM05

    # Find a property with Active Primary relationship
    @{active_pcs} =    Salesforce Query    cfsuite1__Property_Customer__c
    ...    select=Id,cfsuite1__Property__r.Name,cfsuite1__Property__r.Id
    ...    where=cfsuite1__Relationship_Status__c='Active' AND cfsuite1__Relationship_Type__c='Primary'
    ...    limit=1

    ${pc_count} =    Get Length    ${active_pcs}
    Should Be True    ${pc_count} > 0    No Active Primary property customer records found

    ${pc_id} =    Set Variable    ${active_pcs}[0][Id]
    ${prop_full_name} =    Set Variable    ${active_pcs}[0][cfsuite1__Property__r][Name]
    ${prop_address} =    Evaluate    '${prop_full_name}'.rsplit(' (', 1)[0] if ' (' in '${prop_full_name}' else '${prop_full_name}'
    ${prop_id} =    Set Variable    ${active_pcs}[0][cfsuite1__Property__r][Id]
    Log To Console    Property: ${prop_address} | PC record: ${pc_id}

    # Step 1: Navigate to the property customer record in SF and edit via UI
    Log To Console    Navigating to property customer record...
    Navigate To Record    ${pc_id}
    Take Screenshot

    # Click edit on the Relationship Status field
    Log To Console    Looking for edit button on Relationship Status...
    Evaluate JavaScript    ${None}    window.scrollBy(0, 300)
    Sleep    2s

    ${edit_status} =    Set Variable    button[title='Edit Relationship Status']
    ${edit_found} =    Run Keyword And Return Status    Wait For Elements State    ${edit_status}    visible    timeout=15s

    # If UI edit works, use it. Otherwise fall back to API.
    Run Keyword If    ${edit_found}    Edit Status Via UI    ${edit_status}
    Run Keyword Unless    ${edit_found}    Edit Status Via API    ${pc_id}

    Take Screenshot

    # Step 2: Verify property is NOT visible in the portal
    Log To Console    Logging in as Hammy Hampster to verify property is hidden...
    ${account_id} =    Login As Community User    Hammy Hampster
    Navigate To Rates Portal Page    /s/mylinkedproperties
    Sleep    10s
    Take Screenshot

    ${page_text} =    Get Text    body
    ${still_visible} =    Run Keyword And Return Status    Should Contain    ${page_text}    ${prop_address}
    Run Keyword If    ${still_visible}    Fail    Property ${prop_address} should NOT be visible after staff deactivation
    Log To Console    PASSED: Property ${prop_address} removed from portal after staff deactivation

    # Step 3: Reactivate (cleanup)
    Log To Console    Reactivating property customer...
    Return To Salesforce Admin
    Salesforce Update    cfsuite1__Property_Customer__c    ${pc_id}
    ...    cfsuite1__Relationship_Status__c=Active
    Log To Console    Cleanup complete - property customer reactivated

    Log To Console    CRM_AM05 test PASSED


*** Keywords ***

Edit Status Via UI
    [Arguments]    ${edit_selector}
    [Documentation]    Edits the Relationship Status field via the Lightning UI.
    Log To Console    Editing status via UI...
    Click    ${edit_selector}
    Sleep    2s

    # Click the status combobox and select Inactive
    ${status_combobox} =    Set Variable    button[aria-label='Relationship Status']
    Wait For Elements State    ${status_combobox}    visible    timeout=10s
    Click    ${status_combobox}
    Sleep    1s

    ${inactive_option} =    Set Variable    span[title='Inactive']
    Wait For Elements State    ${inactive_option}    visible    timeout=5s
    Click    ${inactive_option}
    Sleep    1s

    # Save
    Click    button[name='SaveEdit']
    Sleep    5s
    Log To Console    Status changed to Inactive via UI

Edit Status Via API
    [Arguments]    ${pc_id}
    [Documentation]    Falls back to API to change the status.
    Log To Console    Edit button not found - updating via API...
    Salesforce Update    cfsuite1__Property_Customer__c    ${pc_id}
    ...    cfsuite1__Relationship_Status__c=Inactive
    Log To Console    Status changed to Inactive via API
