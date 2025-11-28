/**
 * @File Name          : CommunitiesRecordsFactory.cls
 * @Description        : 
 * @Author             : Hugh Wheeler
 * @Group              : 
 * @Last Modified By   : hugh Wheeler
 * @Last Modified On   : 02-26-2025
 * @Modification Log   : 
 * Ver       Date            Author              Modification
 * 1.0    02/07/2020   Hugh Wheeler     Initial Version
**/
@IsTest
public class CommunitiesRecordsFactory {
  
    public static User createPortalAccountOwner() {       
        UserRole portalRole = new UserRole(DeveloperName = 'MyCustomRole', Name = 'My Role', PortalType='None' );  
        insert portalRole;  
        System.debug('portalRole is ' + portalRole);  
        Profile sysAdminProfile = [Select Id from Profile where name = 'System Administrator'];  

        User portalAccountOwner = new User(  
            UserRoleId = portalRole.Id,  
            ProfileId = sysAdminProfile.Id,  
            Username = 'portalOwner@cfsuite.portal.owner',  
            Alias = 'Alias',  
            Email='portal.owner@test.com',  
            EmailEncodingKey='UTF-8',  
            Firstname='Portal',  
            Lastname='Owner',  
            LanguageLocaleKey='en_US',  
            LocaleSidKey='en_US',  
            TimeZoneSidKey = 'America/Los_Angeles'  
        );  
        Database.insert(portalAccountOwner);  
        
        List<PermissionSetAssignment> newPS = new List<PermissionSetAssignment>();
        Set<Id> psIds = new Set<Id>();
        for(PermissionSetAssignment psa : [SELECT Id, PermissionSetId FROM PermissionSetAssignment where AssigneeId =: portalAccountOwner.Id ])
        {
            psIds.add(psa.PermissionSetId);
        }


        for(PermissionSet ps : [SELECT Id FROM PermissionSet WHERE Name Like 'CFSuite%'])
        {
            if(!psIds.contains(ps.Id))
            {
                newPS.add(new PermissionSetAssignment(AssigneeId = portalAccountOwner.Id , PermissionSetId = ps.Id));
            }
        }
        if(newPS.size() > 0)
        {
            insert newPS;
        }
        return portalAccountOwner;  
      }
    
      public static cfsuite1__CFSuiteSettings__c populateCfsuiteSettings()
    {
        cfsuite1__CFSuiteSettings__c newRecord = new cfsuite1__CFSuiteSettings__c();
        newRecord.cfsuite1__CommunityAccountOwnerId__c = createPortalAccountOwner().Id;
        newRecord.cfsuite1__CommunityUserProfileName__c = 'CFSuite Customer Community Login User';
        newRecord.cfsuite1__Allowed_File_Extensions_For_Internal__c = 'doc,dot,docx,docm,dotx,dotm,docb,xls,xlt,xlm,xlsx,xlsm,xltx,xltm,xlsb,xlw,csv,pdf,gif,png,jpg,jpeg,heif,heic,msg,tr5,snote';
        newRecord.cfsuite1__Allowed_File_Extensions__c = 'doc,dot,docx,docm,dotx,dotm,docb,xls,xlt,xlm,xlsx,xlsm,xltx,xltm,xlsb,xlw,csv,pdf,gif,png,jpg,jpeg,heif,heic,msg,tr5,snote';
        insert newRecord;
        return newRecord;
    }
    
    
}