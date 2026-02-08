*** Settings ***

Resource        cumulusci/robotframework/Salesforce.robot

*** Test Cases ***

Query Available Users
    [Documentation]
    ...  Query to discover available users in the org

    Log To Console    Querying for active users...
    @{users} =    Salesforce Query    User    select=Id,Name,Username    where=IsActive=TRUE    limit=10

    ${user_count} =    Get Length    ${users}
    Log To Console    Found ${user_count} active users

    FOR    ${user}    IN    @{users}
        Log To Console    User: ${user}[Name] (${user}[Username])
    END
