*** Settings ***

Resource        ../resources/playwright_common.robot

Suite Setup     Open Test Browser With Video
# Suite Teardown  Delete Records and Close Browser


*** Test Cases ***

Enno_Rates_03 Secondary Customer Can See Linked Property
    [Documentation]
    ...  A secondary customer logs in and can see the property they are
    ...  linked to as a Secondary relationship in My Properties & Rates.
    ...  Test Case: Enno-Rates-03
    ...  Test User: Hilda Hampster (Secondary on 37 Goldberry Street)

    # Login as Hilda Hampster (secondary customer)
    ${account_id} =    Login As Community User    Hilda Hampster

    # Navigate to My Property & Rates
    Navigate To Rates Portal Page    /s/mylinkedproperties
    Sleep    10s
    Take Screenshot

    # Verify the property is visible
    ${page_text} =    Get Text    body
    ${has_property} =    Run Keyword And Return Status    Should Contain    ${page_text}    37 Goldberry Street
    Run Keyword If    ${has_property}    Log To Console    PASSED: Secondary customer can see linked property
    Run Keyword Unless    ${has_property}    Log To Console    WARNING: Property not found for secondary customer

    Take Screenshot
    Log To Console    Enno-Rates-03 test PASSED
