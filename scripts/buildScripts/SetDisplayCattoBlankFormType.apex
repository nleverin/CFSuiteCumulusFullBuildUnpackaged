List<cfsuite1__CFSuite_Request_Flow__c> updAllDCRecords = new List<cfsuite1__CFSuite_Request_Flow__c>();

for(cfsuite1__CFSuite_Request_Flow__c rf : [Select Id, Name, cfsuite1__Form_Type__c from cfsuite1__CFSuite_Request_Flow__c where recordType.DeveloperName = 'Display_Category' ])
{
    if(rf.cfsuite1__Form_Type__c != '')
    {
        cfsuite1__CFSuite_Request_Flow__c upRF = new cfsuite1__CFSuite_Request_Flow__c();
        upRF.Id = rf.Id;
        upRF.cfsuite1__Form_Type__c = '';
        updAllDCRecords.add(upRF);


    }
}
if(updAllDCRecords.size() > 0)
{
    update updAllDCRecords;
}
