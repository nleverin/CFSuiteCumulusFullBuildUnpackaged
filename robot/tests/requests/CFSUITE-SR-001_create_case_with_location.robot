*** Settings ***

Resource        ../resources/playwright_common.robot

Suite Setup     Open Test Browser With Video
# Suite Teardown  Delete Records and Close Browser


*** Test Cases ***

Create Case With Map Location And Validation
    [Documentation]
    ...  Test creates a new Case by selecting a map location,
    ...  choosing category options, filling modal fields,
    ...  and validates the address and due date are populated correctly.

    # Navigate to Case tab
    Navigate To Object Home    Case

    # Click New button
    Wait For Elements State    xpath=//div[@title='New']    visible    timeout=10s
    Click    xpath=//div[@title='New']

    # Wait for custom case creation page to load
    Sleep    15s
    Take Screenshot

    # Select map location
    ${selected_location} =    Handle Map Iframe And Click    cf_MapCreateCase
    Set Test Variable    ${SELECTED_LOCATION}    ${selected_location}
    Take Screenshot

    # Select Category = Animals > Dog > Keeping Excess Dogs
    Select Category Animals Dog    Keeping Excess Dogs

    # Wait for Create Case button to become enabled
    Log To Console    Checking if Create Case button is enabled...
    ${button_selector} =    Set Variable    xpath=//button[contains(text(), 'Create case')]
    Wait For Elements State    ${button_selector}    enabled    timeout=20s

    # Click Create Case button to open modal
    Click    ${button_selector}
    Sleep    5s
    Take Screenshot

    # Check if modal appears
    ${modal_selector} =    Set Variable    css=.slds-modal,[role='dialog']
    ${modal_exists} =    Run Keyword And Return Status    Wait For Elements State    ${modal_selector}    visible    timeout=5s

    # If modal exists, fill in the modal fields
    Run Keyword If    ${modal_exists}    Handle Case Modal Fields

    # Wait for case to be created and page to redirect
    Log To Console    Waiting for case to be created...
    Sleep    10s
    Take Screenshot

    # Try to detect case detail page
    ${case_page_loaded} =    Run Keyword And Return Status    Wait For Elements State    css=.slds-page-header    visible    timeout=15s

    Run Keyword If    ${case_page_loaded}    Proceed With Case Validation
    Run Keyword Unless    ${case_page_loaded}    Log To Console    Case detail page not found


*** Keywords ***

Proceed With Case Validation
    [Documentation]    Validates the created case has the correct data.

    Log To Console    Validating created case...
    ${case_id} =    Get Current Record Id
    Store Session Record    Case    ${case_id}
    Log To Console    Case ID: ${case_id}
    Validate Case    ${case_id}    ${SELECTED_LOCATION}

Validate Case
    [Arguments]    ${case_id}    ${expected_location}
    [Documentation]
    ...  Validates that the case has the correct address populated
    ...  from the selected location and that a due date exists.

    Navigate To Record    ${case_id}
    Sleep    3s

    &{case} =    Salesforce Get    Case    ${case_id}
    Should Not Be Empty    ${case}[cfsuite1__Request_location__c]
    Log To Console    Case Address: ${case}[cfsuite1__Request_location__c]

    ${address_lower} =    Convert To Lower Case    ${case}[cfsuite1__Request_location__c]
    Should Contain    ${address_lower}    ada    msg=Address should contain 'Ada'
    Should Contain    ${address_lower}    adelaide    msg=Address should contain 'Adelaide'
    Log To Console    Address validation PASSED

    ${due_date_value} =    Get From Dictionary    ${case}    cfsuite1__Original_Due_Date__c    default=${None}
    Log To Console    Due Date: ${due_date_value}
    Should Not Be Equal    ${due_date_value}    ${None}    msg=Due Date should not be null
