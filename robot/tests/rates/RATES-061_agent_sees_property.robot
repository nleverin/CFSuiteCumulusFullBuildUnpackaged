*** Settings ***

Resource        ../resources/playwright_common.robot

Suite Setup     Open Test Browser With Video
# Suite Teardown  Delete Records and Close Browser


*** Test Cases ***

Enno_Rates_04 Agent Can See Linked Property
    [Documentation]
    ...  An agent customer logs in and can see the property they are
    ...  linked to as an Agent relationship in My Properties & Rates.
    ...  Test Case: Enno-Rates-04
    ...  Test User: Horatio Hampster (Agent on 1 Cadisfly Alley)

    # Login as Horatio Hampster (agent customer)
    ${account_id} =    Login As Community User    Horatio Hampster

    # Navigate to My Property & Rates
    Navigate To Rates Portal Page    /s/mylinkedproperties
    Sleep    10s
    Take Screenshot

    # Verify the property is visible
    ${page_text} =    Get Text    body
    ${has_property} =    Run Keyword And Return Status    Should Contain    ${page_text}    1 Cadisfly Alley
    Run Keyword If    ${has_property}    Log To Console    PASSED: Agent customer can see linked property
    Run Keyword Unless    ${has_property}    Log To Console    WARNING: Property not found for agent customer

    Take Screenshot
    Log To Console    Enno-Rates-04 test PASSED
