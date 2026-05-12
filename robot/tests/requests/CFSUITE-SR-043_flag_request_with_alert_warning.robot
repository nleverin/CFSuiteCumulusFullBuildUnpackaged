*** Settings ***

Resource        ../resources/playwright_common.robot
Resource        ../resources/test_data.robot

Suite Setup     Run Keywords    Ensure SR Baseline    AND    Open Test Browser With Video


*** Test Cases ***

Case Inherits Alert From Linked Account
    [Documentation]
    ...  CFSUITE-SR-043 (CoM-Test-057) - Flag request record with an
    ...  alert warning. Sets a Customer_Alert on the linked Account,
    ...  creates a Case linked to that account, and verifies the case's
    ...  read-only Case_Alert formula picks up the alert from the linked
    ...  account.
    ...
    ...  Case_Alert__c is a calculated (formula) field, so the test
    ...  cannot write to it directly - it asserts that the formula
    ...  evaluates to a non-empty value once the linked account carries
    ...  an alert.

    # Use Hammy Hampster as the alert-bearing customer. Capture the
    # original alert values so we can restore them at the end - the
    # baseline accounts are shared with other tests.
    @{accts} =    Salesforce Query    Account
    ...    select=Id,PersonContactId,cfsuite1__Customer_Alert__c,cfsuite1__Alert_Code__c,cfsuite1__Person_Alert_Notes__c
    ...    where=Name='Hammy Hampster' AND IsPersonAccount=TRUE
    ...    limit=1
    ${acct_id} =    Set Variable    ${accts}[0][Id]
    ${contact_id} =    Set Variable    ${accts}[0][PersonContactId]
    ${prev_alert} =    Set Variable    ${accts}[0][cfsuite1__Customer_Alert__c]
    ${prev_codes} =    Set Variable    ${accts}[0][cfsuite1__Alert_Code__c]
    ${prev_notes} =    Set Variable    ${accts}[0][cfsuite1__Person_Alert_Notes__c]
    Log To Console    Hammy Hampster account: ${acct_id}

    # Apply an alert to the account. A validation rule requires Alert_Code
    # to be set alongside Customer_Alert.
    ${alert_note} =    Set Variable    ${TEST_RECORD_PREFIX}SR-043 dangerous dog on premises
    Salesforce Update    Account    ${acct_id}
    ...    cfsuite1__Customer_Alert__c=Warning - Customer Alert: Dangerous Dog
    ...    cfsuite1__Alert_Code__c=Approach with caution
    ...    cfsuite1__Person_Alert_Notes__c=${alert_note}

    # Create a case linked to that account
    ${case_id} =    Salesforce Insert    Case
    ...    Subject=${TEST_RECORD_PREFIX}SR-043 alert-bearing case
    ...    Status=New
    ...    Origin=Web
    ...    AccountId=${acct_id}
    ...    ContactId=${contact_id}
    Log To Console    Created case ${case_id}

    # Read the calculated Case_Alert - should reflect the account alert
    &{case} =    Salesforce Get    Case    ${case_id}
    ${case_alert} =    Get From Dictionary    ${case}    cfsuite1__Case_Alert__c    default=${EMPTY}
    Log To Console    Case_Alert formula returned: '${case_alert}'
    Should Not Be Empty    ${case_alert}
    ...    msg=Case_Alert__c should evaluate to a non-empty value when the linked Account has Customer_Alert set

    # Cleanup
    Salesforce Delete    Case    ${case_id}
    ${prev_alert_value} =    Set Variable If    '${prev_alert}' == 'None'    ${EMPTY}    ${prev_alert}
    ${prev_codes_value} =    Set Variable If    '${prev_codes}' == 'None'    ${EMPTY}    ${prev_codes}
    ${prev_notes_value} =    Set Variable If    '${prev_notes}' == 'None'    ${EMPTY}    ${prev_notes}
    Salesforce Update    Account    ${acct_id}
    ...    cfsuite1__Customer_Alert__c=${prev_alert_value}
    ...    cfsuite1__Alert_Code__c=${prev_codes_value}
    ...    cfsuite1__Person_Alert_Notes__c=${prev_notes_value}
