*** Settings ***

Resource        ../resources/playwright_common.robot
Resource        ../resources/test_data.robot

Suite Setup     Open Test Browser With Video


*** Test Cases ***

Custom On Hold And Close Reasons Via Other
    [Documentation]
    ...  CFSUITE-SR-047 (CoM-Test-061) - Custom on hold and close reasons
    ...  when selecting "Other". Verifies that a case can be:
    ...  (a) placed on hold with Reason='Other' + a free-text Other_On_Hold_Reason,
    ...  then (b) closed with Reason='Other' + a free-text Other_Closed_Reason.
    ...  Both pairings persist and are queryable.

    ${case_id} =    Salesforce Insert    Case
    ...    Subject=${TEST_RECORD_PREFIX}SR-047 custom reasons
    ...    Status=New
    ...    Origin=Web
    Log To Console    Created case ${case_id}

    # Step 1: place on hold with 'Other' + custom text
    ${on_hold_text} =    Set Variable    Waiting on internal investigation outcome
    Salesforce Update    Case    ${case_id}
    ...    Status=On Hold
    ...    cfsuite1__On_Hold_Reason__c=Other
    ...    cfsuite1__Other_On_Hold_Reason__c=${on_hold_text}

    &{case_held} =    Salesforce Get    Case    ${case_id}
    Should Be Equal    ${case_held}[Status]    On Hold
    Should Be Equal    ${case_held}[cfsuite1__On_Hold_Reason__c]    Other
    Should Be Equal    ${case_held}[cfsuite1__Other_On_Hold_Reason__c]    ${on_hold_text}
    Log To Console    On-hold reason 'Other' paired with custom text

    # Step 2: close with 'Other' + custom text
    ${close_text} =    Set Variable    Resolved out of system after offline discussion
    Salesforce Update    Case    ${case_id}
    ...    Status=Closed
    ...    cfsuite1__Close_Reason__c=Other
    ...    cfsuite1__Other_Closed_Reason__c=${close_text}

    &{case_closed} =    Salesforce Get    Case    ${case_id}
    Should Be Equal    ${case_closed}[Status]    Closed
    Should Be Equal    ${case_closed}[cfsuite1__Close_Reason__c]    Other
    Should Be Equal    ${case_closed}[cfsuite1__Other_Closed_Reason__c]    ${close_text}
    Log To Console    Close reason 'Other' paired with custom text

    Salesforce Delete    Case    ${case_id}
