*** Settings ***

Resource        ../resources/playwright_common.robot

Suite Setup     Open Test Browser With Video
# Suite Teardown  Delete Records and Close Browser


*** Test Cases ***

Verify Admin Has Role
    [Documentation]
    ...  Verifies the admin user has a Role assigned (required for community users).
    ...  NOTE: Role must be assigned manually in Setup if this test fails.

    ${org_info} =    Get Org Info
    ${admin_username} =    Set Variable    ${org_info}[username]
    @{current_user} =    Salesforce Query    User    select=Id,UserRoleId    where=Username='${admin_username}'    limit=1
    ${has_role} =    Set Variable    ${current_user}[0][UserRoleId]
    Should Not Be Equal As Strings    ${has_role}    None
    ...    msg=Admin user must have a Role assigned. Go to Setup > Users > Edit and set a Role manually.
    Log To Console    Admin has role: ${has_role}


Verify Community User For Hammy Hampster
    [Documentation]
    ...  Verifies a community portal user exists for Hammy Hampster.
    ...  NOTE: If this fails, enable the customer user manually via the Account page
    ...  dropdown > Enable Customer User (select Customer Community Login license).

    @{accounts} =    Salesforce Query    Account    select=Id,PersonContactId    where=Name='Hammy Hampster'    limit=1
    ${account_count} =    Get Length    ${accounts}
    Should Be True    ${account_count} > 0    Hammy Hampster account not found in org

    ${contact_id} =    Set Variable    ${accounts}[0][PersonContactId]
    @{users} =    Salesforce Query    User    select=Id,Username,IsActive    where=ContactId='${contact_id}' AND IsActive=true    limit=1
    ${user_count} =    Get Length    ${users}
    Should Be True    ${user_count} > 0
    ...    msg=No active community user for Hammy Hampster. Enable via Account > dropdown > Enable Customer User.
    Log To Console    Community user exists: ${users}[0][Username]


Verify Community User For Hilda Hampster
    [Documentation]    Verifies an active community user exists for Hilda Hampster (Secondary customer).

    @{accounts} =    Salesforce Query    Account    select=Id,PersonContactId    where=Name='Hilda Hampster'    limit=1
    ${account_count} =    Get Length    ${accounts}
    Should Be True    ${account_count} > 0    Hilda Hampster account not found in org

    ${contact_id} =    Set Variable    ${accounts}[0][PersonContactId]
    @{users} =    Salesforce Query    User    select=Id,Username,IsActive    where=ContactId='${contact_id}' AND IsActive=true    limit=1
    ${user_count} =    Get Length    ${users}
    Should Be True    ${user_count} > 0
    ...    msg=No active community user for Hilda Hampster. Enable via Account > dropdown > Enable Customer User.
    Log To Console    Hilda community user exists: ${users}[0][Username]


Verify Community User For Horatio Hampster
    [Documentation]    Verifies an active community user exists for Horatio Hampster (Agent customer).

    @{accounts} =    Salesforce Query    Account    select=Id,PersonContactId    where=Name='Horatio Hampster'    limit=1
    ${account_count} =    Get Length    ${accounts}
    Should Be True    ${account_count} > 0    Horatio Hampster account not found in org

    ${contact_id} =    Set Variable    ${accounts}[0][PersonContactId]
    @{users} =    Salesforce Query    User    select=Id,Username,IsActive    where=ContactId='${contact_id}' AND IsActive=true    limit=1
    ${user_count} =    Get Length    ${users}
    Should Be True    ${user_count} > 0
    ...    msg=No active community user for Horatio Hampster. Enable via Account > dropdown > Enable Customer User.
    Log To Console    Horatio community user exists: ${users}[0][Username]


Populate Property Rates Data
    [Documentation]
    ...  Ensures all properties have rates balance data populated
    ...  (financial year, quarterly balances, due dates, name on notice).

    @{properties} =    Salesforce Query    cfsuite1__Property__c    select=Id,Name,cfsuite1__Full_year_balance__c    limit=10

    FOR    ${prop}    IN    @{properties}
        ${balance} =    Set Variable    ${prop}[cfsuite1__Full_year_balance__c]
        Run Keyword If    '${balance}' == 'None'    Populate Property Balance    ${prop}[Id]    ${prop}[Name]
        Run Keyword Unless    '${balance}' == 'None'    Log To Console    Property ${prop}[Name] already has balance: ${balance}
    END

    Log To Console    Property rates data setup complete


*** Keywords ***

Populate Property Balance
    [Arguments]    ${property_id}    ${property_name}
    [Documentation]    Sets quarterly balances and due dates on a property.

    Log To Console    Populating balance data for: ${property_name}
    Salesforce Update    cfsuite1__Property__c    ${property_id}
    ...    cfsuite1__Full_year_balance__c=2400.00
    ...    cfsuite1__Financial_Year__c=2025
    ...    cfsuite1__Quarter_1_Balance__c=600.00
    ...    cfsuite1__Quarter_1_Due_Date__c=2025-09-01
    ...    cfsuite1__Quarter_2_Balance__c=600.00
    ...    cfsuite1__Quarter_2_Due_Date__c=2025-12-01
    ...    cfsuite1__Quarter_3_Balance__c=600.00
    ...    cfsuite1__Quarter_3_Due_Date__c=2026-03-01
    ...    cfsuite1__Quarter_4_Balance__c=600.00
    ...    cfsuite1__Quarter_4_Due_Date__c=2026-06-01
    ...    cfsuite1__Name_on_Rates_Notice__c=Hammy Hampster
    Log To Console    Balance data set for ${property_name}
