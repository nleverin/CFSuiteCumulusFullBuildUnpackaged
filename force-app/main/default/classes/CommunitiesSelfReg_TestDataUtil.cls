/*
 * @Description Test Data Utility class for Individual and Business users
 */
@isTest
public class CommunitiesSelfReg_TestDataUtil {
    
    public void createTestData() {
        
        System.runAs(new User(Id=UserInfo.getUserId()))
        {
         	CommunitiesRecordsFactory.populateCfsuiteSettings();  
        }
        cfsuite1__CFSuiteSettings__c defaultSettings = cfsuite1__CFSuiteSettings__c.getOrgDefaults();        
        String profileId = null;
        for (Profile p : [SELECT Id from Profile where Name = :defaultSettings.cfsuite1__CommunityUserProfileName__c LIMIT 1]){
            profileId = p.Id;
        }
        String caoi = defaultSettings.cfsuite1__CommunityAccountOwnerId__c;
        //Id profileId = null;
        //for (Profile p : [SELECT Id from Profile where Name = :cupn LIMIT 1]){
        //    profileId = p.Id;
        //}
        System.runAs(new User(Id=caoi))
        {
        //Inserting business users
        String businessRec = null;
        String personRec = null;
        for (RecordType busRec : [SELECT Id from RecordType WHERE DeveloperName = 'Business' LIMIT 1]) {
            businessRec = busRec.Id;
        }

        for (RecordType perRec : [SELECT Id from RecordType WHERE DeveloperName = 'PersonAccount' LIMIT 1]) {
            personRec = perRec.Id;
        }


        Account acc = new Account();
        acc.Name = 'BusRates';
        acc.RecordTypeId = businessRec;
        acc.cfsuite1__Authority_ID__c = '8987';
        acc.cfsuite1__Mobile__c = '1231231263';
        acc.cfsuite1__Business_Email__c = 'abc11@business.com';
        INSERT acc;
        
        Account acc1 = new Account();
        acc1.Name = 'BusRates1';
        acc1.RecordTypeId = businessRec;
        acc1.cfsuite1__Authority_ID__c = '89871';
        acc1.cfsuite1__Mobile__c = '1231231833';
        acc1.cfsuite1__Business_Email__c = 'abc0@business.com';
        INSERT acc1;
        
        String contactId = null;
        for (Contact con : [SELECT Id FROM Contact WHERE AccountId =: acc.Id AND cfsuite1__IsPrimaryContact__c = true AND LastName = :acc.Name LIMIT 1 ]) {
            contactId = con.Id;
        }
        
        String contactId1 = null;
        for (Contact con : [SELECT Id FROM Contact WHERE AccountId =: acc1.Id AND cfsuite1__IsPrimaryContact__c = true AND LastName = :acc1.Name LIMIT 1 ]) {
            contactId1 = con.Id;
        }
		
        User newUser = new User(ProfileId = profileId, UserName='user@test.com', Email = 'user@test.com', emailEncodingKey = 'UTF-8',
                               localesidkey = 'en_US', languagelocalekey = 'en_US', timezonesidkey = 'America/Los_Angeles',
                               alias ='usertest', LastName = 'testl', CommunityNickname='userbus@test.com', contactId = contactId);
        INSERT newUser;
        
        User newUser1 = new User(ProfileId = profileId, UserName='user1@test.com', Email = 'user1@test.com', emailEncodingKey = 'UTF-8',
                               localesidkey = 'en_US', languagelocalekey = 'en_US', timezonesidkey = 'America/Los_Angeles',
                               alias ='user1', LastName = 'testl', contactId = contactId1);
        
       	Account acc2 = new Account();
        acc2.Name = 'BusRates2';
        acc2.RecordTypeId = businessRec;
        acc2.cfsuite1__Authority_ID__c = '89872';
        acc2.cfsuite1__Mobile__c = '1231231235';
        acc2.cfsuite1__Business_Email__c = 'abc2@business.com';
        INSERT acc2;
        
        String contactId2 = null;
        for (Contact con : [SELECT Id FROM Contact WHERE AccountId =: acc2.Id AND cfsuite1__IsPrimaryContact__c = true AND LastName = :acc2.Name LIMIT 1 ]) {
            contactId2 = con.Id;
        }
        User newUser2 = new User(ProfileId = profileId, UserName='user2@test.com', Email = 'user2@test.com', emailEncodingKey = 'UTF-8',
                               localesidkey = 'en_US', languagelocalekey = 'en_US', timezonesidkey = 'America/Los_Angeles',
                               alias ='user2', LastName = 'testl2', contactId = contactId2);
        INSERT newUser2;
        
        Account acc3 = new Account();
        acc3.Name = 'BusRates3';
        acc3.RecordTypeId = businessRec;
        acc3.cfsuite1__Authority_ID__c = '89873';
        acc3.cfsuite1__Mobile__c = '1231231237';
        acc3.cfsuite1__Business_Email__c = 'abc1@business.com';
        INSERT acc3;
        
        String contactId3 = null;
        for (Contact con : [SELECT Id FROM Contact WHERE AccountId =: acc3.Id AND cfsuite1__IsPrimaryContact__c = true AND LastName = :acc3.Name LIMIT 1 ]) {
            contactId3 = con.Id;
        }
        User newUser3 = new User(ProfileId = profileId, UserName='user3@test.com', Email = 'user3@test.com', emailEncodingKey = 'UTF-8',
                               localesidkey = 'en_US', languagelocalekey = 'en_US', timezonesidkey = 'America/Los_Angeles',
                               alias ='user3', LastName = 'testl3', CommunityNickname='userbusinessuserbusinessuserbu@test.com', contactId = contactId3);
        INSERT newUser3;
        
        
        // Inserting Individual users
        Account pacc = new Account();
        pacc.RecordTypeId = personRec;
        pacc.PersonEmail = 'example@testclass.com';
        pacc.FirstName = 'MyTestFName';
        pacc.LastName = 'MyTestLName';
        pacc.cfsuite1__Authority_ID__c = '6788';
        pacc.OwnerId = defaultSettings.cfsuite1__CommunityAccountOwnerId__c;
        pacc.PersonMobilePhone = '1231231230';
        INSERT pacc;
        
        String personContactId = [SELECT PersonContactId FROM Account WHERE Id =: pacc.Id].get(0).PersonContactId;
        
        User pnewUser = new User(ProfileId = profileId, UserName='userp@test.com', Email = 'userp@test.com', emailEncodingKey = 'UTF-8',
                               localesidkey = 'en_US', languagelocalekey = 'en_US', timezonesidkey = 'America/Los_Angeles',
                               alias ='userp', LastName = 'testlp', CommunityNickname='userpbus@test.com', contactId = personContactId);
        INSERT pnewUser;
        
        Account pacc1 = new Account();
        pacc1.RecordTypeId = personRec;
        pacc1.PersonEmail = 'example1@testclass.com';
        pacc1.FirstName = 'MyTest1FName';
        pacc1.LastName = 'MyTest1LName';
        pacc1.MiddleName = 'MyTest1MName';
        pacc1.cfsuite1__Authority_ID__c = '67880';
        pacc.OwnerId = defaultSettings.cfsuite1__CommunityAccountOwnerId__c;
        pacc1.PersonMobilePhone = '1231231238';
        INSERT pacc1;
        
        String personContactId1 = [SELECT PersonContactId FROM Account WHERE Id =: pacc1.Id].get(0).PersonContactId;
        
        User pnewUser1 = new User(ProfileId = profileId, UserName='userp1@test.com', Email = 'userp1@test.com', emailEncodingKey = 'UTF-8',
                               localesidkey = 'en_US', languagelocalekey = 'en_US', timezonesidkey = 'America/Los_Angeles',
                               alias ='userp1', LastName = 'testlp', contactId = personContactId1);
        
        Account pacc2 = new Account();
        pacc2.RecordTypeId = personRec;
        pacc2.PersonEmail = 'example@testclass.com';
        pacc2.FirstName = 'MyTest2FName';
        pacc2.LastName = 'MyTest2LName';
        pacc2.cfsuite1__Authority_ID__c = '67882';
        pacc.OwnerId = defaultSettings.cfsuite1__CommunityAccountOwnerId__c;
        pacc2.PersonMobilePhone = '1231231239';
        INSERT pacc2;
        
        String personContactId2 = [SELECT PersonContactId FROM Account WHERE Id =: pacc2.Id].get(0).PersonContactId;
        
        User pnewUser2 = new User(ProfileId = profileId, UserName='userp2@test.com', Email = 'userp2@test.com', emailEncodingKey = 'UTF-8',
                               localesidkey = 'en_US', languagelocalekey = 'en_US', timezonesidkey = 'America/Los_Angeles',
                               alias ='userp2', LastName = 'testlp2', contactId = personContactId2);
        INSERT pnewUser2;
    }
    }

}