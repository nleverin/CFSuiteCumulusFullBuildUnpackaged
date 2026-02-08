*** Settings ***

Resource        cumulusci/robotframework/Salesforce.robot
Library         cumulusci.robotframework.PageObjects
Library         SeleniumLibrary

Suite Setup     Open Test Browser
# Suite Teardown  Delete Records and Close Browser

*** Test Cases ***

Simple Page Load Test
    [Documentation]
    ...  Simple test to verify what page loads after clicking New

    # Navigate to Case tab
    Go to page            Home  Case

    # Wait for page to load
    Sleep    5s

    # Click New button directly with Selenium instead of using CumulusCI's Click Object Button
    # which expects a standard Salesforce modal
    Wait Until Element Is Visible    xpath=//div[@title='New']    timeout=10s
    Click Element    xpath=//div[@title='New']

    # Wait for custom page to load
    Sleep    20s

    # Take screenshot
    Capture Page Screenshot    after_new_button.png

    # Log what we can see
    ${url} =    Get Location
    Log To Console    Current URL: ${url}

    ${iframe_count} =    Execute Javascript    return document.querySelectorAll('iframe').length;
    Log To Console    Number of iframes: ${iframe_count}

    ${category_exists} =    Execute Javascript    return document.getElementById('category_0') !== null;
    Log To Console    Category element exists: ${category_exists}

    # Log all iframe sources
    ${iframe_sources} =    Execute Javascript    return Array.from(document.querySelectorAll('iframe')).map(f => f.src).join('\\n');
    Log To Console    Iframe sources:\\n${iframe_sources}

    # This test always passes - we just want to see the output
    Log To Console    Test completed - check screenshot and console output
