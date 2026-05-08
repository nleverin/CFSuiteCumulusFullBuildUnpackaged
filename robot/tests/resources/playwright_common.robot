*** Settings ***
Documentation
...  Shared keywords for Playwright-based CFSuite robot tests.
...  Import this resource from all test files to get common setup
...  and navigation keywords.

Resource        cumulusci/robotframework/SalesforcePlaywright.robot


*** Keywords ***

Open Test Browser With Video
    [Documentation]    Opens a Playwright browser with video recording enabled.
    ...  Works around a CumulusCI bug where viewport dimensions are passed as strings.
    ${login_url} =    Login Url
    ${browser_id} =    New Browser    chromium    headless=${FALSE}
    ${context_id} =    New Context    viewport={"width": 1280, "height": 1024}    recordVideo={"dir": "../video"}
    Set Browser Timeout    60 seconds
    ${page_details} =    New Page    ${login_url}
    Sleep    5s
    Wait Until Loading Is Complete

Navigate To Record
    [Arguments]    ${record_id}
    [Documentation]    Navigates to a Salesforce record detail page and clicks the Details tab.
    ${org_info} =    Get Org Info
    ${instance_url} =    Set Variable    ${org_info}[instance_url]
    Go To    ${instance_url}/lightning/r/${record_id}/view    wait_until=commit
    Sleep    15s
    # Click the Details tab to ensure we're on the detail view
    ${details_tab} =    Set Variable    a[data-label='Details']
    ${tab_exists} =    Run Keyword And Return Status    Wait For Elements State    ${details_tab}    visible    timeout=30s
    Log To Console    Details tab found: ${tab_exists}
    Run Keyword If    ${tab_exists}    Click    ${details_tab}
    Run Keyword If    ${tab_exists}    Sleep    5s
    Run Keyword Unless    ${tab_exists}    Sleep    5s

Navigate To Object Home
    [Arguments]    ${object_name}
    [Documentation]    Navigates to the home/list view of a Salesforce object.
    ${org_info} =    Get Org Info
    ${instance_url} =    Set Variable    ${org_info}[instance_url]
    Go To    ${instance_url}/lightning/o/${object_name}/list    wait_until=commit
    Sleep    10s

Navigate To Record Detail
    [Arguments]    ${object_name}    ${record_id}
    [Documentation]    Navigates to a specific record detail page.
    Navigate To Record    ${record_id}

Navigate To Account
    [Arguments]    ${account_id}
    [Documentation]    Navigates to an Account detail page.
    ${org_info} =    Get Org Info
    ${instance_url} =    Set Variable    ${org_info}[instance_url]
    Go To    ${instance_url}/lightning/r/Account/${account_id}/view    wait_until=commit
    Sleep    15s

Handle Case Modal Fields
    [Documentation]
    ...  Handles filling in the modal fields for Case Origin and Notification Method.
    ...  This is a common pattern across many case creation tests.

    Log To Console    Filling modal fields...
    Take Screenshot

    # Click Case Origin combobox button
    ${origin_button} =    Set Variable    button[aria-label='Case Origin']
    ${origin_exists} =    Run Keyword And Return Status    Wait For Elements State    ${origin_button}    visible    timeout=5s
    Run Keyword If    ${origin_exists}    Click    ${origin_button}
    Sleep    1s

    # Select Email from dropdown
    ${email_option} =    Set Variable    span[title='Email']
    ${email_exists} =    Run Keyword And Return Status    Wait For Elements State    ${email_option}    visible    timeout=5s
    Run Keyword If    ${email_exists}    Click    ${email_option}
    Sleep    1s

    # Click Notification Method combobox button
    ${notification_button} =    Set Variable    button[aria-label='Notification Method']
    ${notif_exists} =    Run Keyword And Return Status    Wait For Elements State    ${notification_button}    visible    timeout=5s
    Run Keyword If    ${notif_exists}    Click    ${notification_button}
    Sleep    1s

    # Select No Notification
    ${no_notif_option} =    Set Variable    span[title='No Notification']
    ${no_notif_exists} =    Run Keyword And Return Status    Wait For Elements State    ${no_notif_option}    visible    timeout=5s
    Run Keyword If    ${no_notif_exists}    Click    ${no_notif_option}
    Sleep    1s

    # Click Save button
    ${save_button} =    Set Variable    text=Save
    ${button_exists} =    Run Keyword And Return Status    Wait For Elements State    ${save_button}    visible    timeout=5s
    Run Keyword If    ${button_exists}    Click    ${save_button}

Select Category Animals Dog
    [Arguments]    ${sub_reason}=Keeping Excess Dogs
    [Documentation]    Selects Animals > Dog > sub_reason in the category picker.

    # Select Category = Animals
    Log To Console    Looking for Category element...
    Wait For Elements State    id=category_0    visible    timeout=10s
    Evaluate JavaScript    ${None}    document.getElementById('category_0').scrollIntoView({behavior: 'smooth', block: 'center'})
    Sleep    1s
    Click    id=category_0
    Sleep    3s
    Log To Console    Animals category clicked

    # Select Request Reason = Dog
    Log To Console    Looking for Request Reason dropdown...
    ${reason_selector} =    Set Variable    xpath=//select[.//option[@value='Dog']]
    Wait For Elements State    ${reason_selector}    visible    timeout=15s
    Select Options By    ${reason_selector}    value    Dog
    Sleep    2s

    # Select Request Sub Reason
    Log To Console    Looking for Request Sub Reason dropdown...
    ${subreason_selector} =    Set Variable    xpath=//select[.//option[@value='${sub_reason}']]
    Wait For Elements State    ${subreason_selector}    visible    timeout=15s
    Select Options By    ${subreason_selector}    value    ${sub_reason}
    Sleep    2s
    Take Screenshot

Handle Map Iframe And Click
    [Arguments]    ${iframe_src_contains}=cf_MapCreateCase
    [Documentation]    Finds the map iframe, switches to it, clicks the map, and returns the selected location.

    Log To Console    Waiting for map iframe to load...
    Sleep    10s

    # In Playwright, we use frame selectors instead of Select Frame
    ${iframe_selector} =    Set Variable    iframe[src*='${iframe_src_contains}']
    ${iframe_found} =    Run Keyword And Return Status    Wait For Elements State    ${iframe_selector}    visible    timeout=20s
    Run Keyword Unless    ${iframe_found}    Fail    Map iframe with '${iframe_src_contains}' not found on page

    Log To Console    Map iframe found
    Sleep    10s
    Take Screenshot

    # Click on the map canvas inside the iframe using the >>> frame piercing selector
    ${map_canvas} =    Set Variable    ${iframe_selector} >>> canvas
    ${canvas_found} =    Run Keyword And Return Status    Wait For Elements State    ${map_canvas}    visible    timeout=30s
    Run Keyword Unless    ${canvas_found}    Fail    Map canvas not found in iframe

    Log To Console    Clicking map canvas at coordinates 300, 200
    Click    ${map_canvas}    position_x=300    position_y=200
    Sleep    5s
    Take Screenshot

    # Wait for address to populate in the ESRI search input
    ${location_input} =    Set Variable    ${iframe_selector} >>> input.esri-search__input
    Log To Console    Waiting for address to populate...
    Wait Until Keyword Succeeds    20s    1s    Address Should Be Populated In Frame    ${location_input}

    ${selected_location} =    Get Attribute    ${location_input}    value
    Log To Console    Selected Location: ${selected_location}

    [Return]    ${selected_location}

Address Should Be Populated In Frame
    [Arguments]    ${locator}
    [Documentation]    Checks that the element has a non-empty value attribute.
    ${value} =    Get Attribute    ${locator}    value
    Should Not Be Empty    ${value}

Login As Community User
    [Arguments]    ${account_name}
    [Documentation]    Logs into the community portal as a person account user via
    ...  the admin "Log in to Experience as User" action. Returns the account ID.

    # Query for the person account
    Log To Console    Querying for account: ${account_name}
    @{accounts} =    Salesforce Query    Account    select=Id,Name,PersonContactId    where=Name='${account_name}'    limit=1
    ${account_count} =    Get Length    ${accounts}
    Run Keyword If    ${account_count} == 0    Fail    No account found with name '${account_name}'

    ${account_id} =    Set Variable    ${accounts}[0][Id]
    Log To Console    Account ID: ${account_id}

    # Navigate to the account detail page
    Navigate To Account    ${account_id}
    Take Screenshot

    # Try to find "Log in to Experience as User" - it may be a direct action button
    # on the page OR inside a dropdown menu, depending on the page layout.
    Log To Console    Looking for Log in to Experience as User...

    # First try: direct action button in the highlights panel
    ${direct_button} =    Set Variable    xpath=//button[contains(text(), 'Log in to Exp')] | //a[contains(text(), 'Log in to Exp')] | //a[@data-target-selection-name='sfdc:StandardButton.Account.LoginToNetworkAsPersonUser']
    ${direct_found} =    Run Keyword And Return Status    Wait For Elements State    ${direct_button}    visible    timeout=5s

    # Second try: inside the dropdown menu
    Run Keyword Unless    ${direct_found}    Log To Console    Not found as direct button, trying dropdown menu...
    ${dropdown_button} =    Set Variable    css=button.slds-button_icon-border-filled >> nth=0
    Run Keyword Unless    ${direct_found}    Wait For Elements State    ${dropdown_button}    visible    timeout=10s
    Run Keyword Unless    ${direct_found}    Click    ${dropdown_button}
    Run Keyword Unless    ${direct_found}    Sleep    2s

    ${menu_item} =    Set Variable    xpath=//lightning-menu-item[@data-target-selection-name='sfdc:StandardButton.Account.LoginToNetworkAsPersonUser']//span[contains(text(), 'Log in to Experience as User')]
    ${login_selector} =    Set Variable If    ${direct_found}    ${direct_button}    ${menu_item}
    Run Keyword Unless    ${direct_found}    Wait For Elements State    ${login_selector}    visible    timeout=15s

    Take Screenshot
    Log To Console    Clicking Log in to Experience as User...

    # Get current page count before clicking
    ${pages_before} =    Get Page Ids    ALL    ALL
    Log To Console    Pages before click: ${pages_before}

    Click    ${login_selector}
    Sleep    5s

    # Check if a new page/tab was opened
    ${pages_after} =    Get Page Ids    ALL    ALL
    Log To Console    Pages after click: ${pages_after}

    # If a new page opened, switch to it
    ${new_page_count} =    Get Length    ${pages_after}
    ${old_page_count} =    Get Length    ${pages_before}
    ${new_tab_opened} =    Evaluate    ${new_page_count} > ${old_page_count}
    Run Keyword If    ${new_tab_opened}    Log To Console    New tab detected - switching to it
    Run Keyword If    ${new_tab_opened}    Switch Page    NEW

    # Wait for community page to fully load
    Sleep    10s
    Take Screenshot
    Log To Console    Successfully logged into community portal as ${account_name}

    ${current_url} =    Evaluate JavaScript    ${None}    window.location.href
    Log To Console    Current URL: ${current_url}

    [Return]    ${account_id}

Navigate To Rates Portal Page
    [Arguments]    ${path}
    [Documentation]    Navigates to a specific page within the community rates portal.
    ...  Path should be relative, e.g. /s/mylinkedproperties
    Log To Console    Navigating to community page: ${path}
    ${current_url} =    Evaluate JavaScript    ${None}    window.location.href
    # Extract base community URL (everything up to /s/)
    ${base_url} =    Evaluate JavaScript    ${None}    window.location.origin
    Go To    ${base_url}${path}    wait_until=commit
    Sleep    10s
    Take Screenshot

Return To Salesforce Admin
    [Documentation]    Returns from the community portal back to the Salesforce admin view.
    ${org_info} =    Get Org Info
    ${instance_url} =    Set Variable    ${org_info}[instance_url]
    Go To    ${instance_url}    wait_until=commit
    Sleep    10s

Setup Property Quarter Dates And Balances
    [Arguments]    ${property_name}    ${balance_per_quarter}=100    ${arrears}=0    ${credit_override}=${NONE}
    [Documentation]    Sets quarter dates and balances on a property based on current date.
    ...  Quarter dates are set relative to the current financial year (Jul-Jun).
    ...  Each quarter at or before the current quarter gets balance=0,
    ...  each quarter after gets the specified balance.
    ...  Also sets Ownership Start Date on the Property Customer.

    # Find the property
    @{properties} =    Salesforce Query    cfsuite1__Property__c
    ...    select=Id,Name    where=Name LIKE '${property_name}%'    limit=1
    ${prop_count} =    Get Length    ${properties}
    Should Be True    ${prop_count} > 0    Property '${property_name}' not found
    ${prop_id} =    Set Variable    ${properties}[0][Id]
    Log To Console    Setting up property: ${properties}[0][Name] (${prop_id})

    # Calculate quarter dates based on current date and financial year
    ${today} =    Evaluate    __import__('datetime').date.today().isoformat()
    ${year} =    Evaluate    int('${today}'.split('-')[0])
    ${month} =    Evaluate    int('${today}'.split('-')[1])

    # Determine financial year start (Jul-Jun: if Jul-Dec use current year, else previous)
    ${fy_start} =    Evaluate    ${year} if ${month} > 6 else ${year} - 1
    ${fy_end} =    Evaluate    ${fy_start} + 1

    ${q1_due} =    Set Variable    ${fy_start}-09-30
    ${q2_due} =    Set Variable    ${fy_start}-12-31
    ${q3_due} =    Set Variable    ${fy_end}-03-31
    ${q4_due} =    Set Variable    ${fy_end}-06-30

    # Set balances per the test spec:
    # "The current quarter based on today's date = balance. Each quarter before = 0, each after = balance."
    # The "current quarter" is the one we are currently IN (Q4 = Apr-Jun, Q3 = Jan-Mar, etc.)
    # We need at least the current quarter to have an outstanding balance for the
    # "Request payment plan or extension" link to appear.

    # Determine which quarter we're currently in
    # Q1: Jul-Sep, Q2: Oct-Dec, Q3: Jan-Mar, Q4: Apr-Jun
    ${in_q1} =    Evaluate    7 <= ${month} <= 9
    ${in_q2} =    Evaluate    10 <= ${month} <= 12
    ${in_q3} =    Evaluate    1 <= ${month} <= 3
    ${in_q4} =    Evaluate    4 <= ${month} <= 6

    # Current quarter and all future quarters get the balance, past quarters get 0
    ${q1_bal} =    Set Variable If    ${in_q1}    ${balance_per_quarter}    0
    ${q2_bal} =    Set Variable If    ${in_q1} or ${in_q2}    ${balance_per_quarter}    0
    ${q3_bal} =    Set Variable If    ${in_q1} or ${in_q2} or ${in_q3}    ${balance_per_quarter}    0
    ${q4_bal} =    Set Variable    ${balance_per_quarter}

    # Calculate full year balance
    ${full_year} =    Evaluate    ${q1_bal} + ${q2_bal} + ${q3_bal} + ${q4_bal} + ${arrears}

    # Override for credit balance tests
    ${full_year} =    Set Variable If    '${credit_override}' != 'None'    ${credit_override}    ${full_year}

    Log To Console    Quarter dates: Q1=${q1_due} Q2=${q2_due} Q3=${q3_due} Q4=${q4_due}
    Log To Console    Quarter balances: Q1=${q1_bal} Q2=${q2_bal} Q3=${q3_bal} Q4=${q4_bal}
    Log To Console    Full year balance: ${full_year} (arrears: ${arrears})

    # Update the property
    Salesforce Update    cfsuite1__Property__c    ${prop_id}
    ...    cfsuite1__Quarter_1_Due_Date__c=${q1_due}
    ...    cfsuite1__Quarter_2_Due_Date__c=${q2_due}
    ...    cfsuite1__Quarter_3_Due_Date__c=${q3_due}
    ...    cfsuite1__Quarter_4_Due_Date__c=${q4_due}
    ...    cfsuite1__Quarter_1_Balance__c=${q1_bal}
    ...    cfsuite1__Quarter_2_Balance__c=${q2_bal}
    ...    cfsuite1__Quarter_3_Balance__c=${q3_bal}
    ...    cfsuite1__Quarter_4_Balance__c=${q4_bal}
    ...    cfsuite1__Full_year_balance__c=${full_year}

    # Set ownership start date on property customer
    @{pcs} =    Salesforce Query    cfsuite1__Property_Customer__c
    ...    select=Id    where=cfsuite1__Property__c='${prop_id}' AND cfsuite1__Relationship_Type__c='Primary' AND cfsuite1__Relationship_Status__c='Active'
    ...    limit=1
    ${pc_count} =    Get Length    ${pcs}
    Run Keyword If    ${pc_count} > 0    Salesforce Update    cfsuite1__Property_Customer__c    ${pcs}[0][Id]
    ...    cfsuite1__Date_Linked_to_Property__c=2023-01-01

    Log To Console    Property setup complete

    [Return]    ${prop_id}

Click Manage Property For
    [Arguments]    ${property_name}
    [Documentation]    On the My Linked Properties page, clicks the Manage property button
    ...  for a specific property. Uses JavaScript to scroll the target button
    ...  into view and click it by matching the Property Customer ID.
    Log To Console    Looking for Manage property button for: ${property_name}

    # Query for the Property Customer ID linked to this property
    @{pcs} =    Salesforce Query    cfsuite1__Property_Customer__c
    ...    select=Id,cfsuite1__Property__r.Name
    ...    where=cfsuite1__Property__r.Name LIKE '${property_name}%' AND cfsuite1__Relationship_Type__c='Primary' AND cfsuite1__Relationship_Status__c='Active'
    ...    limit=1
    ${pc_count} =    Get Length    ${pcs}

    Run Keyword If    ${pc_count} > 0    Click Manage Button By PC Id    ${pcs}[0][Id]
    Run Keyword Unless    ${pc_count} > 0    Click    button.btn-manage >> nth=0

    Sleep    10s
    Take Screenshot

Click Manage Button By PC Id
    [Arguments]    ${pc_id}
    [Documentation]    Clicks a btn-manage button whose value attribute matches the Property Customer ID.
    ...  Scrolls the button into view first if needed.
    Log To Console    Looking for button with value=${pc_id}
    ${btn} =    Set Variable    button.btn-manage[value='${pc_id}']
    ${found} =    Run Keyword And Return Status    Wait For Elements State    ${btn}    attached    timeout=10s

    # Scroll into view using Playwright (handles shadow DOM) and click
    Run Keyword If    ${found}    Scroll To Element    ${btn}
    Run Keyword If    ${found}    Sleep    2s
    Run Keyword If    ${found}    Click    ${btn}
    Run Keyword Unless    ${found}    Log To Console    Button with value ${pc_id} not found, clicking first available
    Run Keyword Unless    ${found}    Click    button.btn-manage >> nth=0
