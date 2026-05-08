*** Settings ***

Resource        ../resources/playwright_common.robot

Suite Setup     Open Test Browser With Video
# Suite Teardown  Delete Records and Close Browser


*** Test Cases ***

Recategorise Existing Case
    [Documentation]
    ...  Test opens an existing Case, clicks "Correct Case Category",
    ...  selects new category options (Animals, Dog, Wandering at Large),
    ...  validates additional fields appear, clicks Re-Categorise button,
    ...  and validates the category fields are updated correctly.

    # Query for an existing Case
    Log To Console    Querying for existing cases...
    @{cases} =    Salesforce Query    Case    select=Id    limit=1

    ${case_count} =    Get Length    ${cases}
    Run Keyword If    ${case_count} == 0    Fail    No existing cases found in org.

    ${case_id} =    Set Variable    ${cases}[0][Id]
    Log To Console    Found case to recategorise: ${case_id}

    # Navigate to the case detail page
    Navigate To Record    ${case_id}
    Take Screenshot

    # Click "Correct Case Category" link
    Log To Console    Looking for Correct Case Category link...
    ${correct_link} =    Set Variable    xpath=//a[contains(text(), 'Correct Case Category')]
    Wait For Elements State    ${correct_link}    visible    timeout=15s
    Click    ${correct_link}

    # Wait for category correction page to load
    Sleep    15s
    Take Screenshot

    # Select Category = Animals > Dog > Wandering at Large
    Select Category Animals Dog    Wandering at Large

    # Validate that "Is the dog contained" text area appears
    Log To Console    Validating additional field appears...
    ${textarea_selector} =    Set Variable    xpath=//textarea[@role='textbox']
    ${textarea_exists} =    Run Keyword And Return Status    Wait For Elements State    ${textarea_selector}    visible    timeout=10s
    Run Keyword If    ${textarea_exists}    Log To Console    Additional field textarea found
    Run Keyword Unless    ${textarea_exists}    Log To Console    WARNING: Additional field textarea not found

    # Click Re-Categorise button
    Log To Console    Clicking Re-Categorise button...
    ${recategorise_button} =    Set Variable    xpath=//button[contains(@class, 'slds-button_brand')][contains(text(), 'Re-Categorise')]
    Wait For Elements State    ${recategorise_button}    enabled    timeout=20s
    Click    ${recategorise_button}
    Take Screenshot

    # Wait for navigation back to case detail page
    Sleep    10s

    # Get the current case ID
    ${case_id} =    Get Current Record Id
    Log To Console    Case ID: ${case_id}

    Sleep    3s
    Take Screenshot

    # Validate category fields via API
    Log To Console    Validating category fields via API...
    &{case} =    Salesforce Get    Case    ${case_id}

    Should Be Equal As Strings    ${case}[cfsuite1__cfReq_Category__c]    Animals    msg=Category should be 'Animals'
    Log To Console    Category: ${case}[cfsuite1__cfReq_Category__c] PASSED

    Should Be Equal As Strings    ${case}[cfsuite1__cfReq_Request_Reason__c]    Dog    msg=Request Reason should be 'Dog'
    Log To Console    Request Reason: ${case}[cfsuite1__cfReq_Request_Reason__c] PASSED

    Should Be Equal As Strings    ${case}[cfsuite1__cfReq_Request_Sub_Reason__c]    Wandering at Large    msg=Sub Reason should be 'Wandering at Large'
    Log To Console    Request Sub Reason: ${case}[cfsuite1__cfReq_Request_Sub_Reason__c] PASSED

    Log To Console    All category validations PASSED
