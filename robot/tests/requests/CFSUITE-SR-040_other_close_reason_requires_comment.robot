*** Settings ***

Resource        ../resources/playwright_common.robot
Resource        ../resources/test_data.robot

Suite Setup     Open Test Browser With Video


*** Test Cases ***

Provide Free Text Comment When Close Reason Is Other
    [Documentation]
    ...  CFSUITE-SR-040 (CoM-Test-054) - Provide comment when reason
    ...  code is "Other". Verifies that selecting Close_Reason='Other'
    ...  pairs with a free-text Other_Closed_Reason value that persists.

    ${case_id} =    Salesforce Insert    Case
    ...    Subject=${TEST_RECORD_PREFIX}SR-040 other reason
    ...    Status=New
    ...    Origin=Web
    Log To Console    Created case ${case_id}

    ${free_text} =    Set Variable    Closed because the original request was misclassified.
    Salesforce Update    Case    ${case_id}
    ...    Status=Closed
    ...    cfsuite1__Close_Reason__c=Other
    ...    cfsuite1__Other_Closed_Reason__c=${free_text}

    &{case} =    Salesforce Get    Case    ${case_id}
    Should Be Equal    ${case}[cfsuite1__Close_Reason__c]    Other
    Should Be Equal    ${case}[cfsuite1__Other_Closed_Reason__c]    ${free_text}
    Log To Console    Close Reason 'Other' paired with free-text comment

    Salesforce Delete    Case    ${case_id}
