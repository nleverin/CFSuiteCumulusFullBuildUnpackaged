*** Settings ***

Resource        ../resources/playwright_common.robot
Resource        ../resources/test_data.robot

Suite Setup     Open Test Browser With Video


*** Test Cases ***

Path Component Shows Expected Status Stages
    [Documentation]
    ...  CFSUITE-SR-050 (CoM-Test-064) - PATH / Guidance for Success.
    ...  Verifies the Lightning Path component renders on a Case detail
    ...  page and includes the expected status stages (New, Closed at
    ...  minimum).

    ${case_id} =    Salesforce Insert    Case
    ...    Subject=${TEST_RECORD_PREFIX}SR-050 path render
    ...    Status=New
    ...    Origin=Web
    Log To Console    Created case ${case_id}

    Navigate To Record    ${case_id}
    Take Screenshot

    # The Path component renders the Status picklist as a stepper. We
    # just confirm the stage labels for the new and closed ends of the
    # workflow are present in the page text.
    ${page_text} =    Get Text    body
    Should Contain    ${page_text}    New
    Should Contain    ${page_text}    Closed
    Log To Console    Path stages 'New' and 'Closed' visible on the case page

    Salesforce Delete    Case    ${case_id}
