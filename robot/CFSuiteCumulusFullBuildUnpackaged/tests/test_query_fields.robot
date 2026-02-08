*** Settings ***

Resource        cumulusci/robotframework/Salesforce.robot

*** Test Cases ***

Query CFSuite Request Flow Fields
    [Documentation]
    ...  Query to discover available fields on CFSuite_Request_Flow__c object

    Log To Console    Querying CFSuite_Request_Flow__c object...
    @{flows} =    Salesforce Query    cfsuite1__CFSuite_Request_Flow__c    select=Id,Name,RecordType.Name    where=Id='a0MRt00000AgPluMAF'    limit=1

    ${flow_count} =    Get Length    ${flows}
    Run Keyword If    ${flow_count} > 0    Log To Console    Found flow: ${flows}[0]
    Run Keyword If    ${flow_count} == 0    Log To Console    No flows found
