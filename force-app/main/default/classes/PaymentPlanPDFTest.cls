@isTest
private class PaymentPlanPDFTest {
     @testSetup static void testSetup() {
        System.runAs(new User(Id=UserInfo.getUserId()))
        {
            //SignInTestDataUtil.populateCfsuiteSettings();
            SignInTestDataUtil.createTestData();  
            SignInTestDataUtil.populateCfsuiteRatesSettings();
        }
        Id displayRecTId = Schema.SObjectType.cfsuite1__CFSuite_Request_Flow__c.getRecordTypeInfosByDeveloperName().get('Display_Category').getRecordTypeId();
    
        
        // Create Display Category RT record
        cfsuite1__CFSuite_Request_Flow__c displayObj = new cfsuite1__CFSuite_Request_Flow__c();
        displayObj.RecordTypeId = displayRecTId;
        displayObj.Name = 'Rates';
        displayObj.cfsuite1__Category_Type__c = 'Request';
        displayObj.cfsuite1__Case_Category__c = 'Rates';
        displayObj.cfsuite1__Search_Tag__c = 'Rates';
        displayObj.cfsuite1__Help_Text__c = 'Rates';
        displayObj.cfsuite1__Pin_Image__c = 'animals.png';
        insert displayObj;

       
        Id journeyRecTId = Schema.SObjectType.cfsuite1__CFSuite_Request_Flow__c.getRecordTypeInfosByDeveloperName().get('Category_Journey').getRecordTypeId();
        
            
        cfsuite1__CFSuite_Request_Flow__c journeyObj = new cfsuite1__CFSuite_Request_Flow__c();
        journeyObj.RecordTypeId = journeyRecTId;
        journeyObj.Name = 'CJ-Rates-Payment Plan';
        journeyObj.cfsuite1__Display_Category__c = displayObj.Id;
        journeyObj.cfsuite1__Case_Category__c = 'Payment Plan';
        journeyObj.cfsuite1__Request_Reason__c = '';
        journeyObj.cfsuite1__Request_Sub_Reason__c = '';
        journeyObj.cfsuite1__Additional_Reason__c = '';
        journeyObj.cfsuite1__Zone_Layer_Id__c = '';
        journeyObj.cfsuite1__Case_Zone__c = '';
        journeyObj.cfsuite1__Form_Type__c = 'Map';
        journeyObj.cfsuite1__cfReq_Work_Category__c = 'Rates - Payment Plan';
        journeyObj.cfsuite1__Case_Record_Type_Developer_Name__c = 'Standard_Request_Initial';
        journeyObj.cfsuite1__New_Status__c = 'Assess and Assign';
        journeyObj.cfsuite1__Case_Owner__c = 'CCS_Finance_Rates';
        journeyObj.cfsuite1__New_Record_Type_Developer_Name__c = 'Standard_Request';
        journeyObj.cfsuite1__Division_Portfolio__c = 'Corporate Services';
        journeyObj.cfsuite1__Department__c = 'Financial Services';
        journeyObj.cfsuite1__Team__c = 'Rating Services';
        journeyObj.cfsuite1__Entitlement_Process_Name__c = 'CCS_Finance_Rates';
        journeyObj.cfsuite1__SLA__c = '2';
        journeyObj.cfsuite1__Council__c = '';
        journeyObj.cfsuite1__Emergency__c = 'No';
        journeyObj.cfsuite1__Is_Primary__c = true;
        journeyObj.cfsuite1__Create_Work_Order__c = false;
        journeyObj.cfsuite1__WO_Src_Record_Type_Developer_Name__c = 'Investigation';
        journeyObj.cfsuite1__Equipment__c = 'Approval';
        journeyObj.cfsuite1__WO_Src_Category__c = 'Test Investigation';
        journeyObj.cfsuite1__Next_Steps__c = 'Close this WO';
        journeyObj.cfsuite1__Record_Type_Developer_Name__c = 'Investigation';
        
        insert journeyObj;

         
        cfsuite1__CFSuiteSettings__c defaultSettings = cfsuite1__CFSuiteSettings__c.getInstance(userinfo.getProfileId());
        //cfsuite1__CFSuiteSettings__c defaultSettings = CommunityAuthController.getCFSuiteSettings();
        String profileId = null;
        for(Profile p : [SELECT Id FROM profile WHERE Name = :defaultSettings.cfsuite1__CommunityUserProfileName__c LIMIT 1]) {
            profileId = p.Id;
        }
        String personAccountTypeId = null;
        
        for(RecordType pt : [SELECT Id, Name, DeveloperName FROM RecordType WHERE sObjectType='Account' AND DeveloperName = 'PersonAccount' LIMIT 1]){
            personAccountTypeId = pt.Id;
        }
        
        Account acc = new Account();
        acc.PersonEmail = 'example@testclass.com';
        acc.FirstName = 'MyTestFirstName';
        acc.LastName = 'MyTestLastName';
        acc.RecordTypeId = personAccountTypeId;
        acc.OwnerId = defaultSettings.cfsuite1__CommunityAccountOwnerId__c;
        acc.cfsuite1__Authority_ID__c = '123456';
        insert acc;
         
         String personContactId = [SELECT PersonContactId FROM Account where Id =: acc.id].PersonContactId;
        User pu = new User(ProfileId = profileId, UserName = 'puser000@test.com', Email = 'puser000@test.com', 
                           emailencodingkey = 'UTF-8', localesidkey = 'en_US', 
                           languagelocalekey = 'en_US', timezonesidkey = 'America/Los_Angeles', 
                           alias='cspu', lastname='MyTestLastName', ContactId = personContactId);
        
        if(profileId != null){
            INSERT(pu);
        }
     }
    @isTest
    static void testPaymentPlanPDFConstructor() {
        // Create a mock CFSuiteRatesSettings record
        cfsuite1__CFSuiteRatesSettings__c defaultSettings = cfsuite1__CFSuiteRatesSettings__c.getOrgDefaults();
		defaultSettings.cfsuite1__Custom_Logo_Black__c = 'https://logo.black';
        defaultSettings.cfsuite1__Custom_Logo_White__c = 'https://logo.white';
        defaultSettings.cfsuite1__Payment_Plan__c = 'Payment Plan';
		update defaultSettings;
        // Get an Account (Customer)
        Account acc = [SELECT PersonContactId FROM Account Limit 1];

        // Create a Property (custom object assumed)
        cfsuite1__Property__c property = new cfsuite1__Property__c(Name = 'Test Property', cfsuite1__Formatted_Number__c = '111');
        insert property;

        // Create a Property_Customer record
        cfsuite1__Property_Customer__c pc = new cfsuite1__Property_Customer__c(
            cfsuite1__Customer__c = acc.Id,
            cfsuite1__Property__c = property.Id
        );
        insert pc;
		cfsuite1__CFSuite_Request_Flow__c PayPlanRT = [select Id from cfsuite1__CFSuite_Request_Flow__c where Name = 'CJ-Rates-Payment Plan' LIMIT 1] ;
        // Create a Case (as a payment plan record)
        Case planCase = new Case(
            AccountId = acc.Id,
            cfsuite1__Frequency__c = 'Weekly',
            cfsuite1__Amount__c = 100.00,
            cfsuite1__CFSuite_Request_Flow__c = PayPlanRT.Id,
            cfsuite1__cfReq_Category__c = 'Payment Plan',
            Status = 'New',
            cfsuite1__Transfer_From__c = property.Id
        );
        insert planCase;

        // Create Installment Plan
        cfsuite1__Installment_Plan__c plan = new cfsuite1__Installment_Plan__c(
            cfsuite1__Case__c = planCase.Id,
            cfsuite1__Start_Date__c = Date.today(),
            cfsuite1__End_Date__c = Date.today().addDays(28)
        );
        insert plan;

        // Mock the page parameter
        Test.startTest();
        PageReference pageRef = Page.PaymentPlanPDF; // replace with actual page name if exists
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', pc.Id);

        // Call constructor
        PaymentPlanPDF pdf = new PaymentPlanPDF();

        // Assertions
        System.assertEquals(pc.Id, pdf.pcId);
        System.assertNotEquals(null, pdf.CustomLogoBlack);
        System.assertNotEquals(null, pdf.ppDetails);
        System.assert(pdf.gTotal > 0);
        Test.stopTest();
    }

    @isTest
    static void testBuildPlanMonthly() {
        Date startDate = Date.newInstance(2024, 1, 1);
        Date endDate = Date.newInstance(2024, 4, 1);
        Decimal amount = 150.00;
        String frequency = 'Monthly';

        List<PaymentPlanPDF.PaymentPlanWrapper> plan = PaymentPlanPDF.buildPlan(startDate, endDate, amount, frequency);

        System.assertEquals(4, plan.size());
        for (PaymentPlanPDF.PaymentPlanWrapper p : plan) {
            System.assertEquals(amount, p.amount);
        }
    }

    @isTest
    static void testBuildPlanInvalidFrequency() {
        List<PaymentPlanPDF.PaymentPlanWrapper> plan = PaymentPlanPDF.buildPlan(Date.today(), Date.today().addDays(30), 200.0, 'Daily');
        System.assertEquals(0, plan.size(), 'Invalid frequency should return empty list');
    }
}