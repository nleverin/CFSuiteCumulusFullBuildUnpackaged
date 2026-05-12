*** Settings ***

Resource        ../resources/playwright_common.robot
Resource        ../resources/test_data.robot

Suite Setup     Open Test Browser With Video


*** Test Cases ***

Create Task Against A Case
    [Documentation]
    ...  CFSUITE-SR-046 (CoM-Test-060) - Create Tasks on Case. Verifies
    ...  that a Task can be created against a Case (WhatId = case Id),
    ...  the Task is queryable as related to the case, and would appear
    ...  in the case's Activity related list.

    ${case_id} =    Salesforce Insert    Case
    ...    Subject=${TEST_RECORD_PREFIX}SR-046 case for tasks
    ...    Status=New
    ...    Origin=Web
    Log To Console    Created case ${case_id}

    ${task_subject} =    Set Variable    ${TEST_RECORD_PREFIX}SR-046 follow up with customer
    ${task_id} =    Salesforce Insert    Task
    ...    Subject=${task_subject}
    ...    WhatId=${case_id}
    ...    Status=Not Started
    ...    Priority=Normal
    Log To Console    Created task ${task_id}

    @{tasks} =    Salesforce Query    Task
    ...    select=Id,Subject,WhatId,Status
    ...    where=WhatId='${case_id}'
    ${count} =    Get Length    ${tasks}
    Should Be Equal As Numbers    ${count}    1
    Should Be Equal    ${tasks}[0][Subject]    ${task_subject}
    Should Be Equal    ${tasks}[0][Status]    Not Started
    Log To Console    Task is linked to case and queryable as a related activity

    Salesforce Delete    Task    ${task_id}
    Salesforce Delete    Case    ${case_id}
