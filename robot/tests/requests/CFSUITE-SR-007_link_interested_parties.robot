*** Settings ***

Resource        ../resources/playwright_common.robot

Suite Setup     Open Test Browser With Video


*** Test Cases ***

Link Multiple Customers As Interested Parties
    [Documentation]
    ...  CFSUITE-SR-007 (CoM-Test-049) - Link Customers To A Request As IPs.
    ...  Verifies that two cfsuite1__Interested_Parties__c records can be
    ...  inserted against the same case, each pointing at a different
    ...  Person Account (Hammy Hampster, Hilda Hampster), and that
    ...  re-querying the related list returns both rows.

    # 1. Locate two existing person accounts
    @{accounts} =    Salesforce Query    Account
    ...    select=Id,Name
    ...    where=Name IN ('Hammy Hampster','Hilda Hampster')
    ${count} =    Get Length    ${accounts}
    Should Be True    ${count} >= 2    msg=Need at least Hammy and Hilda accounts present
    ${primary_id} =    Set Variable    ${accounts}[0][Id]
    ${secondary_id} =    Set Variable    ${accounts}[1][Id]
    Log To Console    Primary=${accounts}[0][Name] Secondary=${accounts}[1][Name]

    # 2. Create a case
    ${case_id} =    Salesforce Insert    Case
    ...    Subject=CFSUITE-SR-007 IP test
    ...    Status=New
    ...    Origin=Web
    Log To Console    Created case ${case_id}

    # 3. Add both accounts as interested parties
    ${ip1_id} =    Salesforce Insert    cfsuite1__Interested_Parties__c
    ...    cfsuite1__Case__c=${case_id}
    ...    cfsuite1__Customer__c=${primary_id}
    ${ip2_id} =    Salesforce Insert    cfsuite1__Interested_Parties__c
    ...    cfsuite1__Case__c=${case_id}
    ...    cfsuite1__Customer__c=${secondary_id}
    Log To Console    Created IPs ${ip1_id} and ${ip2_id}

    # 4. Re-query and assert both IPs show against this case
    @{ips} =    Salesforce Query    cfsuite1__Interested_Parties__c
    ...    select=Id,cfsuite1__Customer__c
    ...    where=cfsuite1__Case__c='${case_id}'
    ${ip_count} =    Get Length    ${ips}
    Should Be Equal As Numbers    ${ip_count}    2

    ${ip_customers} =    Evaluate    sorted([r['cfsuite1__Customer__c'] for r in $ips])
    ${expected} =    Evaluate    sorted(['${primary_id}','${secondary_id}'])
    Should Be Equal    ${ip_customers}    ${expected}
    Log To Console    Two IPs correctly linked to case

    # 5. Visual evidence: open the case page
    Navigate To Record    ${case_id}
    Take Screenshot

    # 6. Cleanup (children first, then case)
    Salesforce Delete    cfsuite1__Interested_Parties__c    ${ip1_id}
    Salesforce Delete    cfsuite1__Interested_Parties__c    ${ip2_id}
    Salesforce Delete    Case    ${case_id}
    Log To Console    CFSUITE-SR-007 complete
