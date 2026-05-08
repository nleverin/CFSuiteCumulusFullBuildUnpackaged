*** Settings ***

Resource        ../resources/playwright_common.robot

Suite Setup     Open Test Browser With Video
Suite Teardown  Delete Records and Close Browser


*** Test Cases ***

Via API
    ${first_name} =       Get fake data  first_name
    ${last_name} =        Get fake data  last_name

    ${contact_id} =       Salesforce Insert  Contact
    ...                     FirstName=${first_name}
    ...                     LastName=${last_name}

    &{contact} =          Salesforce Get  Contact  ${contact_id}
    Validate Contact      ${contact_id}  ${first_name}  ${last_name}

Via UI
    ${first_name} =       Get fake data  first_name
    ${last_name} =        Get fake data  last_name

    Navigate To Object Home    Contact
    # Click New button
    Click    text=New
    Sleep    3s

    # Fill in the contact form fields
    Fill Text    input[name='firstName']    ${first_name}
    Fill Text    input[name='lastName']    ${last_name}

    # Click Save
    Click    button[name='SaveEdit']
    Sleep    5s

    ${contact_id} =       Get Current Record Id
    Store Session Record  Contact  ${contact_id}
    Validate Contact      ${contact_id}  ${first_name}  ${last_name}


*** Keywords ***

Validate Contact
    [Arguments]          ${contact_id}  ${first_name}  ${last_name}
    [Documentation]
    ...  Given a contact id, validate that the contact has the
    ...  expected first and last name via the API.

    # Validate via API
    &{contact} =     Salesforce Get  Contact  ${contact_id}
    Should Be Equal  ${first_name}  ${contact}[FirstName]
    Should Be Equal  ${last_name}  ${contact}[LastName]
