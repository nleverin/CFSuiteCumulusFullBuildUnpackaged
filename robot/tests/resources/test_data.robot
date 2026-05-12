*** Settings ***
Documentation
...  Shared test-data helpers. Import alongside playwright_common.robot to
...  get keywords that ensure required data exists in the target org.
...
...  The `CFSUITE-TEST-` prefix is used on any test-created identifier
...  (Case Subject, Account Name, etc.) so test data is trivially
...  identifiable in a busy sandbox.

Resource        playwright_common.robot


*** Variables ***
${TEST_RECORD_PREFIX}    CFSUITE-TEST-

@{SR_BASELINE_ACCOUNTS}    Hammy Hampster    Hilda Hampster    Horatio Hampster
@{RATES_BASELINE_PROPERTIES}
...    37 Goldberry Street (A)
...    1 Cadisfly Alley (A)
...    32 Courage Square (A)
...    1 Humbdinger avenue (A)
...    32 Develish Court (A)


*** Keywords ***

Ensure SR Baseline
    [Documentation]
    ...  Asserts that the SR baseline (3 Person Accounts) is present in the
    ...  target org. Fails fast with the exact CLI to run if not.
    ...
    ...  Call from a test's Suite Setup when the test depends on Hammy /
    ...  Hilda / Horatio being available.

    @{accounts} =    Salesforce Query    Account
    ...    select=Id,Name
    ...    where=IsPersonAccount=TRUE AND Name IN ('Hammy Hampster','Hilda Hampster','Horatio Hampster')
    ${count} =    Get Length    ${accounts}
    Run Keyword If    ${count} < 3
    ...    Fail
    ...    SR baseline incomplete (found ${count}/3 Person Accounts). Run: python scripts/automatedTestTooling/ensure_sr_baseline.py --org <alias> --write
    Log To Console    SR baseline present (${count}/3 Person Accounts).

Ensure Rates Baseline
    [Documentation]
    ...  Asserts that the Rates baseline (SR baseline + 5 Properties) is
    ...  present. Fails fast with the exact CLI to run if not.

    Ensure SR Baseline
    @{properties} =    Salesforce Query    cfsuite1__Property__c
    ...    select=Id,Name
    ...    where=Name IN ('37 Goldberry Street (A)','1 Cadisfly Alley (A)','32 Courage Square (A)','1 Humbdinger avenue (A)','32 Develish Court (A)')
    ${count} =    Get Length    ${properties}
    Run Keyword If    ${count} < 5
    ...    Fail
    ...    Rates baseline incomplete (found ${count}/5 Properties). Run: python scripts/automatedTestTooling/ensure_rates_baseline.py --org <alias> --write
    Log To Console    Rates baseline present (${count}/5 Properties).

Get Or Create Account By Name
    [Arguments]    ${account_name}    ${is_person_account}=${TRUE}
    [Documentation]
    ...  Returns the Id of an Account with the given Name. If it doesn't
    ...  exist, creates a minimal one. Person Accounts require the org's
    ...  Person Account RecordType to be available.

    @{rows} =    Salesforce Query    Account    select=Id    where=Name='${account_name}'    limit=1
    ${count} =    Get Length    ${rows}
    Run Keyword If    ${count} > 0    Return From Keyword    ${rows}[0][Id]

    Run Keyword If    ${is_person_account}
    ...    Create Person Account By Name    ${account_name}
    ...    ELSE
    ...    Create Business Account By Name    ${account_name}

Create Person Account By Name
    [Arguments]    ${account_name}
    @{rt_rows} =    Salesforce Query    RecordType    select=Id    where=SobjectType='Account' AND IsPersonType=TRUE    limit=1
    ${rt_count} =    Get Length    ${rt_rows}
    Run Keyword If    ${rt_count} == 0    Fail    No Person Account RecordType in this org
    ${rt_id} =    Set Variable    ${rt_rows}[0][Id]
    ${parts} =    Split String    ${account_name}    ${SPACE}    1
    ${first_name} =    Set Variable    ${parts}[0]
    ${last_name} =    Set Variable    ${parts}[1]
    ${acct_id} =    Salesforce Insert    Account
    ...    FirstName=${first_name}
    ...    LastName=${last_name}
    ...    RecordTypeId=${rt_id}
    [Return]    ${acct_id}

Create Business Account By Name
    [Arguments]    ${account_name}
    ${acct_id} =    Salesforce Insert    Account    Name=${account_name}
    [Return]    ${acct_id}

Get Existing Case Or Create Fallback
    [Arguments]    ${descriptor}=fallback
    [Documentation]
    ...  Returns the Id of any existing Case in the org. If none exist,
    ...  creates a minimal throwaway Case with a CFSUITE-TEST- prefix in
    ...  the Subject so it's obvious in a sandbox. The created case is
    ...  registered for session cleanup.

    @{cases} =    Salesforce Query    Case    select=Id    limit=1
    ${case_count} =    Get Length    ${cases}
    Run Keyword If    ${case_count} > 0    Return From Keyword    ${cases}[0][Id]

    Log To Console    No existing cases found - creating throwaway for '${descriptor}'
    ${case_id} =    Salesforce Insert    Case
    ...    Subject=${TEST_RECORD_PREFIX}${descriptor}
    ...    Status=New
    ...    Origin=Web
    Store Session Record    Case    ${case_id}
    Log To Console    Created fallback case ${case_id}
    [Return]    ${case_id}
