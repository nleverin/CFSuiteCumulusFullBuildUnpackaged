/**
 * @description       : 
 * @author            : hugh Wheeler
 * @group             : 
 * @last modified on  : 10-25-2023
 * @last modified by  : hugh Wheeler
**/
@IsTest global with sharing class CustomLoginControllerTest{
    global testMethod static void testCustomLoginController() {
        
        createTestData();
        Test.StartTest(); 
        
        PageReference pageRef = Page.CustomCommunityLogin; // Add your VF page Name here
        
        pageRef.getParameters().put('startURL',URL.getOrgDomainUrl().toExternalForm());
        Test.setCurrentPage(pageRef);
        
        CustomLoginController testCustLogin = new CustomLoginController();
        testCustLogin.username = 'test12345@test.com';
        testCustLogin.password = 'test123';
        
        for(integer i=0;i<11;i++)
        {
            testCustLogin.doLogin();  
        }  
        
        Test.StopTest();    
    }
    
    static testMethod void testcreatePortal() {
        CustomLoginController ctrl = new CustomLoginController();
        String requestUrl = '/apex/CreateAccount';
        String ratesUrl = '/apex/CreateRatesAccount';
        
        ctrl.portalName = 'Request';
        PageReference result = ctrl.createPortal();
        
        System.debug('result = ' + result);
        System.assertEquals(requestUrl, result.getUrl(), 'testcreatePortal: Request url incorrect.');
        
        ctrl.portalName = 'Rates';
        result = ctrl.createPortal();
        System.debug('result = ' + result);
        System.assertEquals(ratesUrl, result.getUrl(), 'testcreatePortal: Rates url incorrect.');
    }
    
    static testMethod void testgetLoginUrl() {
        String loginUrl = CustomLoginController.getLoginUrl();
        System.assert(!String.isBlank(loginUrl), 'testgetLoginUrl: loginUrl is blank');
    }
    
    static testMethod void testgetUserData() {
        String guestProfileId = null;
        for(Profile p : [SELECT Id FROM Profile WHERE UserType = 'Guest' LIMIT 1]) {
            guestProfileId = p.Id;
        }
        User gu = new User(ProfileId = guestProfileId, UserName = 'puser000@test.com', Email = 'puser000@test.com', 
                   emailencodingkey = 'UTF-8', localesidkey = 'en_US', 
                   languagelocalekey = 'en_US', timezonesidkey = 'America/Los_Angeles', 
                   alias='cspu', lastname='MyTestLastName');
        
        System.runAs(gu) {
            CustomLoginController.userData userData = CustomLoginController.getUserData();
            System.assert(userData != null, 'testgetUserData: userData is null');
            System.assertEquals(true, userData.isGuest, 'testgetUserData: userData is not Guest initially');
        }
        
        User u = createTestData();
        System.runAs(u) {
            CustomLoginController.userData userData = CustomLoginController.getUserData();
            System.assert(userData != null, 'testgetUserData: userData is null');
            System.assertEquals(false, userData.isGuest, 'testgetUserData: userData is not Guest initially');
        }
    }
    
    private static User createTestData() {
        System.runAs(new User(Id=UserInfo.getUserId()))
        {
            CommunitiesRecordsFactory.populateCfsuiteSettings();  
        }
        cfsuite1__CFSuiteSettings__c defaultSettings = cfsuite1__CFSuiteSettings__c.getOrgDefaults(); 
        Account portalAccount1 = new Account(
            Name = 'TestAccount',
            OwnerId = defaultSettings.cfsuite1__CommunityAccountOwnerId__c
        );
        Database.insert(portalAccount1);
        
        //Create contact
        Contact contact1 = new Contact(
            FirstName = 'Test',
            Lastname = 'McTesty',
            AccountId = portalAccount1.Id,
            Email = System.now().millisecond() + 'test@test.com'
        );
        Database.insert(contact1);
        
        //Create user
        Profile portalProfile = [SELECT Id FROM Profile WHERE Name LIKE :defaultSettings.cfsuite1__CommunityUserProfileName__c Limit 1];
        User user1 = new User(
            Username = 'test12345@test.com',
            ContactId = contact1.Id,
            ProfileId = portalProfile.Id,
            Alias = 'test123',
            Email = 'test12345@test.com',
            EmailEncodingKey = 'UTF-8',
            LastName = 'McTesty',
            CommunityNickname = 'test12345',
            TimeZoneSidKey = 'America/Los_Angeles',
            LocaleSidKey = 'en_US',
            LanguageLocaleKey = 'en_US'
        );
        Database.insert(user1);
        
        return user1;
    }
    static testMethod void forgottenPasswordTest() {
        ForgotPasswordController fpc = new ForgotPasswordController();
        PageReference pr = fpc.forgotPassword();

    }

}
