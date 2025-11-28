/**
 * @description       : 
 * @author            : hugh Wheeler
 * @group             : 
 * @last modified on  : 05-29-2025
 * @last modified by  : hugh Wheeler
**/
@IsTest
public with sharing class SignInTestDataUtil {
    public static testMethod void createTestData() {
        
        System.runAs(new User(Id=UserInfo.getUserId()))
        {
            SignInTestDataUtil.populateCfsuiteSettings();  
        }
       
        cfsuite1__CFSuiteSettings__c defaultSettings = cfsuite1__CFSuiteSettings__c.getOrgDefaults();
        
        
        cfsuite1__Property__c property = new cfsuite1__Property__c();
        property.cfsuite1__Assessment_Number__c = '2341112345';
        property.cfsuite1__Valuation_Number__c = '34645';
        property.cfsuite1__Name_on_Rates_Notice__c = 'Mrs Helena Bolt';
        property.cfsuite1__Full_year_balance__c = 1000;
        property.cfsuite1__Financial_Year__c = '2020';
        property.cfsuite1__Quarter_1_Balance__c = 100;
        property.cfsuite1__Quarter_1_Due_Date__c = Date.newInstance(2019, 09, 02);
        property.cfsuite1__Quarter_2_Balance__c = 200;
        property.cfsuite1__Quarter_2_Due_Date__c = Date.newInstance(2019, 12, 02);
        property.cfsuite1__Quarter_3_Balance__c = 200;
        property.cfsuite1__Quarter_3_Due_Date__c = Date.newInstance(2020, 03, 02);
        property.cfsuite1__Quarter_4_Balance__c = 200;
        property.cfsuite1__Quarter_4_Due_Date__c = Date.newInstance(2020, 06, 02);
        insert property;
        
        cfsuite1__Property__c prop = new cfsuite1__Property__c();
        prop.cfsuite1__Assessment_Number__c = '8911111567';
        prop.cfsuite1__Valuation_Number__c = '33355';
        prop.cfsuite1__Name_on_Rates_Notice__c = 'Mr Frank Roosvelt';
        prop.cfsuite1__Full_year_balance__c = 2000;
        insert prop;
        
        cfsuite1__Property__c propnew = new cfsuite1__Property__c();
        propnew.cfsuite1__Assessment_Number__c = '8011111507';
        propnew.cfsuite1__Valuation_Number__c = '23455';
        propnew.cfsuite1__Name_on_Rates_Notice__c = 'Mr John Roosvelt';
        propnew.cfsuite1__Full_year_balance__c = 3000;
        insert propnew;
        
        Id profileId = null;

        for (Profile p : [SELECT Id from Profile where Name = :defaultSettings.cfsuite1__CommunityUserProfileName__c LIMIT 1]){
            profileId = p.Id;
        }

        String caoi = defaultSettings.cfsuite1__CommunityAccountOwnerId__c;

        System.runAs(new User(Id=caoi))
        {




            Account customer = new Account();
            customer.PersonEmail = 'example@test.com';
            customer.FirstName = 'Wilson';
            customer.LastName = 'Bolt';
            customer.cfsuite1__Authority_ID__c = '6788';
            customer.OwnerId = defaultSettings.cfsuite1__CommunityAccountOwnerId__c;
            customer.PersonMobilePhone = '1231231230';
            INSERT customer;
            
            String personContactId = [SELECT PersonContactId FROM Account WHERE Id =: customer.Id].get(0).PersonContactId;
            
            User pnewUser = new User(ProfileId = profileId, UserName='userp@test.com', Email = 'user@test.com', emailEncodingKey = 'UTF-8',
                                localesidkey = 'en_US', languagelocalekey = 'en_US', timezonesidkey = 'America/Los_Angeles',
                                alias ='userp', LastName = 'testlp', CommunityNickname='user@test.com', contactId = personContactId);
            INSERT pnewUser;
            
            
            cfsuite1__Property_Customer__c agentpropCustomer = new cfsuite1__Property_Customer__c();
            agentpropCustomer.cfsuite1__Property__c = property.Id;
            agentpropCustomer.cfsuite1__Customer__c = customer.Id;
            agentpropCustomer.cfsuite1__Relationship_Type__c = 'Agent';
            agentpropCustomer.cfsuite1__Relationship_Status__c = 'Active';
            insert agentpropCustomer;
            
            cfsuite1__Property_Customer__c primarypropCustomer = new cfsuite1__Property_Customer__c();
            primarypropCustomer.cfsuite1__Property__c = propnew.Id;
            primarypropCustomer.cfsuite1__Customer__c = customer.Id;
            primarypropCustomer.cfsuite1__Relationship_Type__c = 'Primary';
            primarypropCustomer.cfsuite1__Relationship_Status__c = 'Active';
            insert primarypropCustomer;
            
            cfsuite1__Property_Customer__c prevpropCustomer = new cfsuite1__Property_Customer__c();
            prevpropCustomer.cfsuite1__Property__c = prop.Id;
            prevpropCustomer.cfsuite1__Customer__c = customer.Id;
            prevpropCustomer.cfsuite1__Relationship_Type__c = 'Previous Primary';
            prevpropCustomer.cfsuite1__Relationship_Status__c = 'Active';
            insert prevpropCustomer;
            
            //Inserting business user
            String businessRec = null;
            for (RecordType busRec : [SELECT Id from RecordType WHERE DeveloperName = 'Business' LIMIT 1]) {
                businessRec = busRec.Id;
            }
            Account buscustomer = new Account();
            buscustomer.Name = 'Myer';
            buscustomer.cfsuite1__Business_Name__c = 'Myer Business';
            buscustomer.RecordTypeId = businessRec;
            buscustomer.cfsuite1__Authority_ID__c = '8987';
            buscustomer.cfsuite1__Mobile__c = '0424000000';
            buscustomer.cfsuite1__Business_Email__c = 'abc11@business.com';
            buscustomer.cfsuite1__GST_Registered_Picklist__c = 'No';
            INSERT buscustomer;
            
            String buscontactId = null;
            for (Contact bcon : [SELECT Id FROM Contact WHERE AccountId =: buscustomer.Id AND cfsuite1__IsPrimaryContact__c = true AND LastName = :buscustomer.Name LIMIT 1 ]) {
                buscontactId = bcon.Id;
            }
            
            User newbUser = new User(ProfileId = profileId, UserName='userb@test.com', Email = 'userb@test.com', emailEncodingKey = 'UTF-8',
                                localesidkey = 'en_US', languagelocalekey = 'en_US', timezonesidkey = 'America/Los_Angeles',
                                alias ='userb', LastName = 'testlb', CommunityNickname='userbus@test.com', contactId = buscontactId);
            INSERT newbUser;
            
            cfsuite1__Property_Customer__c agentpc = new cfsuite1__Property_Customer__c();
            agentpc.cfsuite1__Property__c = prop.Id;
            agentpc.cfsuite1__Customer__c = buscustomer.Id;
            agentpc.cfsuite1__Relationship_Type__c = 'Agent';
            agentpc.cfsuite1__Relationship_Status__c = 'Active';
            insert agentpc;
            
            cfsuite1__CommunitySettings__c community = new cfsuite1__CommunitySettings__c();
            community.cfsuite1__baseURL__c = 'dev1-cttg.cs137.force.com';
            community.cfsuite1__LightningURL__c = 'https://cttg--dev1.lightning.force.com/sfc/p/4Y0000008kWQ/a/4Y0000000FH5/skI4c8xR4Qyi2_0yGacNedSbZxhygrgy0GtcTqIoFJw';
            community.cfsuite1__FY_start_date__c = Date.newInstance(2020, 07, 01);
            community.cfsuite1__FY_End_Date__c = Date.newInstance(2021, 06, 30);
            insert community;
        }
    }
    public static cfsuite1__CFSuiteRatesSettings__c populateCfsuiteRatesSettings()
    {
        cfsuite1__CFSuiteRatesSettings__c newRecord = cfsuite1__CFSuiteRatesSettings__c.getOrgDefaults();
        //cfsuite1__CFSuiteRatesSettings__c defaultSettings = GenericSettingsController.retrieveRatesSettings();

        //The commented lines are for records that are defaulted in the setting.  

        newRecord.cfsuite1__DD_Cancellation_Reasons__c = 'Change of Ownership;Cancelled by Staff';
        newRecord.cfsuite1__Major_Agent_Codes__c = '110,115,118,130,135,140,145,165';
        newRecord.cfsuite1__Maximum_Payment_Limit__c = 30000.0;
        newRecord.cfsuite1__Minimum_Arrears_Amount__c = 3000.0;
        newRecord.cfsuite1__Minimum_Payment_Limit__c = 1;
        newRecord.cfsuite1__Notice_Help_URL__c = 'http://google.com';
        newRecord.cfsuite1__Payment_Event_Type__c = 'Success';
        newRecord.cfsuite1__Thank_You_Page_Adv_Img__c = 'http://google.com';
        newRecord.cfsuite1__Thank_You_Page_Alt_Text__c = 'text';
        newRecord.cfsuite1__Add_Payer_Named_Credential__c = 'Add_a_Payer';
        newRecord.cfsuite1__Courtesy_Reminder_SMS_DD__c = 'Rates_Courtesy_Reminder_Quarter_DD';
        newRecord.cfsuite1__Courtesy_Reminder_Email_No_DD__c = 'Courtesy_Reminder_No_DD';
        newRecord.cfsuite1__Courtesy_Reminder_SMS_No_DD__c = 'Rates_Courtesy_Reminder_No_DD';
        newRecord.cfsuite1__Courtesy_Reminder_Email_DD__c = 'Courtesy_Reminder_Quarter_DD';
        newRecord.cfsuite1__Rates_Payment_Product_Name__c = 'Rates Installment';
        //newRecord.cfsuite1__Auth_Named_Credential__c = 'IntegraPay_Auth';
        //newRecord.cfsuite1__Integrapay_TP_Named_Credential__c = 'IntegraPay_Tokenized_Payment';
        //newRecord.cfsuite1__Pay_Trans_Named_Credential__c = 'Payment_Transaction';
        newRecord.cfsuite1__Rates_Notice_Named_Credential__c = 'Rates_Notice';
        newRecord.cfsuite1__Download_Notice_Named_Credential__c = 'Download_Notice';
        newRecord.cfsuite1__Validate_BSB_Named_Credential__c = 'Is_Valid_BSB/AUS/';
        //newRecord.cfsuite1__Business_Id__c = '12345';
        //newRecord.cfsuite1__Pay_Trans_Host_Name__c = 'apim-crm-prod.azure-api.net';
        newRecord.cfsuite1__Download_Notice_Host_Name__c = 'apim-crm-prod.azure-api.net';
        newRecord.cfsuite1__Rates_Notice_Host_Name__c = 'apim-crm-prod.azure-api.net';
        newRecord.cfsuite1__Transfer_Payment__c = 'Rates - Transfer Payment';
        newRecord.cfsuite1__Refund_Credit_Balance__c = 'Rates - Refund Credit Balance';
        newRecord.cfsuite1__Reverse_Payment_Bank__c = 'Rates - Reverse Payment (Bank)';
        newRecord.cfsuite1__Extension_Request__c = 'Rates - Extension Request';
        newRecord.cfsuite1__Payment_Plan__c = 'Rates - Payment Plan';
        upsert newRecord;
        
        return newRecord;
    }
    public static cfsuite1__CFSuiteSettings__c populateCfsuiteSettings()
    {
        cfsuite1__CFSuiteSettings__c newRecord = cfsuite1__CFSuiteSettings__c.getOrgDefaults();
        
        //The commented lines are for records that are defaulted in the setting.  
        
        newRecord.cfsuite1__AreaLayerURL__c = 'http://google.com';
        newRecord.cfsuite1__Allowed_File_Extensions__c = 'doc,dot,docx,docm,dotx,dotm,docb,xls,xlt,xlm,xlsx,xlsm,xltx,xltm,xlsb,xlw,csv,pdf,gif,png,jpg,jpeg,heif,heic,msg,tr5,snote';
        newRecord.cfsuite1__Allowed_File_Extensions_For_Internal__c = 'doc,dot,docx,docm,dotx,dotm,docb,xls,xlt,xlm,xlsx,xlsm,xltx,xltm,xlsb,xlw,csv,pdf,gif,png,jpg,jpeg,heif,heic,msg,tr5,snote';
        newRecord.cfsuite1__BuildingsLayerUrl__c = 'http://google.com';
        newRecord.cfsuite1__BusLayerUrl__c = 'http://google.com';
        newRecord.cfsuite1__Com_Guest_Usr_URL__c = 'http://google.com';
        newRecord.cfsuite1__CommunityAccountOwnerId__c = createPortalAccountOwner().Id;
        newRecord.cfsuite1__Councillor_Profile__c = 'CFSuite Councillor Login User';
        newRecord.cfsuite1__CommunityUserProfileName__c = 'CFSuite Community Login User';
        newRecord.cfsuite1__Suppressed_Customer_Alert__c = 'Do not disclose personal details';
        newRecord.cfsuite1__Council_Title__c = 'My Test Council';
        newRecord.cfsuite1__Down_For_Maintenance_Site_URL__c = 'http://google.com';
        newRecord.cfsuite1__Email_Address_to_Contact__c = 'email@email.com';
        newRecord.cfsuite1__GoogleAPIkey__c = 'xxxxxxxxxxxxxx';
        newRecord.cfsuite1__Bypass_Recaptcha__c = 'Yes';
        newRecord.cfsuite1__Matched_User_Error__c = 'Our system shows you already have an account, please Login';
        newRecord.cfsuite1__Max_File_Size_MB__c = 100;
        newRecord.cfsuite1__NewLine__c = '-';
        newRecord.cfsuite1__Open_Status__c = 'Assess and Assign,New,Escalated,On Hold';
        newRecord.cfsuite1__ParcelsCenLayerURL__c = 'http://google.com';
        newRecord.cfsuite1__ParcelsLayerURL__c = 'http://google.com';
        newRecord.cfsuite1__Property_NAR_Delimeter__c = '~';
        newRecord.cfsuite1__Radius__c = '1';
        newRecord.cfsuite1__RecaptchaSiteKey__c = 'xxxxxxxxxxxxx';
        newRecord.cfsuite1__RequestWizardThankYouDocId__c = 'xx';
        newRecord.cfsuite1__ReservesLayerURL__c = 'http://google.com';
        newRecord.cfsuite1__Site_URL__c = 'https://google.com';
        newRecord.cfsuite1__Thankyou_Page_Image_URL__c = 'https://google.com';
        newRecord.cfsuite1__ImageryLayerURL__c = 'https://google.com';
        newRecord.cfsuite1__TransportLayerURL__c = 'https://google.com';
        newRecord.cfsuite1__Update_Details_Case_Category__c = 'Finance - Update Personal Details';
        newRecord.cfsuite1__Update_Details_Case_Queue_Name__c = 'Finance_Rates';
        newRecord.cfsuite1__Update_Details_Case_Reason__c = 'Business Name';
        newRecord.cfsuite1__Update_Details_Case_RT__c = 'Update_Details';
        newRecord.cfsuite1__WO_ClosedStatus__c = 'Completed,Closed';
        newRecord.cfsuite1__Use_Custom_Salutations__c = 'No';
        newRecord.cfsuite1__WorkOrderPrefix__c = '0WO';
        newRecord.cfsuite1__Suppressed_Customer_Queue_Name__c = 'Ranger_Central_East_North_West_South_Wes';
        newRecord.cfsuite1__Visual_Force_Domain__c = 'visualforce';
        
        
        upsert newRecord;
        
        return newRecord;
    }
    public static User createPortalAccountOwner() { 
        
        UserRole portalRole = new UserRole(DeveloperName = 'MyCustomRole', Name = 'My Role', PortalType='None' );  
        insert portalRole;  
        
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
    
}