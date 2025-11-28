/*
* @Name : CommunitiesSelfReg_RatesPortal
* @Description : Called by individual/business for registration on Rates portal
*/
public without sharing class CommunitiesSelfReg_RatesPortal {
    public String firstName { get; set; }
    public String lastName { get; set; }
    public String email { get; set; }
    public String password { get; set; }
    public String confirmPassword { get; set; }
    public String communityNickname { get; set; }
    public String code {get;set;}
    public String userId {get;set;}
    public string middleName {get;set;}
    public string mobilePhone {get;set;}
    public string verificationCodeId {get;set;}
    public string businessName {get;set;}
    public string businessEmail {get;set;}
    public string businessMobile {get;set;}
    public String NARCode {get;set;}
    public User communityUser {get;set;}
    public String addPropertyURL{get;set;}
    public cfsuite1__CFSuiteSettings__c defaultSettings;
    
    // Constructor to set ExperienceId
    public CommunitiesSelfReg_RatesPortal() {
        String expid = ApexPages.currentPage().getParameters().get('expid'); 
        //defaultSettings = cfsuite1__CFSuiteSettings__c.getOrgDefaults();
        defaultSettings = cfsuite1__CFSuiteSettings__c.getInstance(userinfo.getProfileId());
        addPropertyURL = 'Https://'+ ApexPages.currentPage().getHeaders().get('Host') + '/LoginPropertyMgmt';
        if (expId != null) {
            Site.setExperienceId(expId); 
        }
    }
    
    /***
Method Name : registerUserAsIndividual
Description : Initiated when individual clicks on 'create new account' 
**/
    
    public PageReference registerUserAsIndividual() {
        
        Profile customerCommunityProfile = [SELECT Id FROM Profile WHERE Name =:defaultSettings.cfsuite1__CommunityUserProfileName__c LIMIT 1];
        Account customerAccount;
        
        // check for duplicate User by email
        if(checkExistingUser(email)) {
             String LoginURL = 'Https://'+ ApexPages.currentPage().getHeaders().get('Host') + '/CustomCommunityLogin?IsAccountExist=true';
            String addPropertyURL = 'Https://'+ ApexPages.currentPage().getHeaders().get('Host') + '/LoginPropertyMgmt';
           // String LoginURL = 'https://my.teatreegully.sa.gov.au/apex/CustomCommunityLogin?IsAccountExist=true';
            String ResetPwdURL = 'Https://'+ ApexPages.currentPage().getHeaders().get('Host') + '/CustomCommunityForgotPassword';
            //System.label.Matched_User_Error_Message
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, defaultSettings.cfsuite1__Matched_User_Error__c +'<a href="'+LoginURL +'"> here </a>' + 'or <a href="'+ResetPwdURL+'"> reset </a> your password. Follow '+'<a href="'+addPropertyURL +'"> these </a> instructions to add Property.'));
            return null;
        }
        
        Savepoint sp = Database.setSavepoint();
        Id personContactId = getPersonContactId();
        if(personContactId!=null) {
            /***************************************** Community User Initiation Process **********************************************/
            communityUser = new User();
            communityUser.Username = email;
            communityUser.Email = email;
            communityUser.FirstName = firstName;
            communityUser.LastName = lastName;
            communityUser.ProfileId = customerCommunityProfile.Id;
            communityUser.Alias = firstName.length() > 4 ? firstName.substring(0,4) + System.Today().Month() + system.Today().day() : firstName + System.Today().Month() + system.Today().day();
            communityUser.ContactId = personContactId;
			communityUser.LocaleSidKey = 'en_AU';
            communityUser.TimeZoneSidKey = 'Australia/Adelaide';
            communityUser.LanguageLocaleKey = 'en_US';
            communityUser.EmailEncodingKey = 'UTF-8';
            communityUser.MobilePhone = mobilePhone;
            
            if(!String.isBlank(email) && String.isBlank(communityNickname)) {
                List<User> userRecord = [SELECT Id,Name,CommunityNickname FROM User WHERE Profile.Name =:defaultSettings.cfsuite1__CommunityUserProfileName__c AND CommunityNickname =:email LIMIT 1];
                if(userRecord!=null && !userRecord.isEmpty()){
                    if(email.length() > 35) {
                        communityUser.communityNickname = email.substring(0,35) + System.Today().Month() + system.Today().day();
                    }
                    else {
                        communityUser.communityNickname = email.substring(0,email.length()) + System.Today().Month() + system.Today().day();
                    }
                }
                else{
                    if(email.length() > 35) {
                        communityUser.communityNickname = email.substring(0,35) + System.Today().Month() + system.Today().day();
                    }
                    else {
                        communityUser.communityNickname = email.substring(0,email.length()) + System.Today().Month() + system.Today().day();
                    }
                }
            }   
            
            else {
                communityUser.CommunityNickname = communityNickname;
            }
            
            /**************************************** Initiate Verification Process **************************************************/
            try 
            { 
                verificationCodeId = System.UserManagement.initSelfRegistration(Auth.VerificationMethod.Email,communityUser);
            }
            
            catch(Exception e)
            {
                Database.RollBack(sp);
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Please contact system admin'+ e.getMessage()));
                //cfsuite1.HandleCustomException.LogException(e,null,'CommunitiesSelfReg_RatesPortal , failed during verification code generation process');
  
            }
            
        }
        return null;
    }
    
    /***
Method Name : getPersonContactId
Description : Validate User Creation and get Person Contact Id to associate community user with correct contact
**/
    public Id getPersonContactId()
    {
     
       // Id personAccountTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('PersonAccount').getRecordTypeId();   // Getting Person Account Id
        Account customerAccount;
        Account personAccount;
        
        /********************************************* Query to return if person account matched with (firstName,LastName and Email) ***********************************************/
        List<Account> NARAccountMatched = [SELECT Id,FirstName,LastName,MiddleName FROM Account WHERE cfsuite1__Authority_ID__c =:NARCode LIMIT 1];
        
        if(NARAccountMatched !=null && !NARAccountMatched.isEmpty()){  // If Person Account exist in salesforce
            customerAccount = NARAccountMatched[0];
            
            personAccount = [SELECT PersonContactId,cfsuite1__Preferred_Notification_Cases__c,cfsuite1__Rates_notice_notifications__c FROM Account WHERE Id = :customerAccount.Id];     // Query to return Contact from person Account
            
            // Query to search if User exist for same person Account  
            List<User> userRecord = [SELECT Id, Name FROM User WHERE Profile.Name =:defaultSettings.cfsuite1__CommunityUserProfileName__c AND contactId=:personAccount.PersonContactId LIMIT 1];
            
            // If user exist, then Message will popup to reset the password.
            if(userRecord!=null && !userRecord.isEmpty())
            {
                String LoginURL = 'Https://'+ ApexPages.currentPage().getHeaders().get('Host') + '/CustomCommunityLogin?IsAccountExist=true';
                String linkURL = 'Https://'+ ApexPages.currentPage().getHeaders().get('Host') + '/LoginSecureID';
                //String LoginURL = 'https://my.teatreegully.sa.gov.au/apex/CustomCommunityLogin?IsAccountExist=true';
                String ResetPwdURL = 'Https://'+ ApexPages.currentPage().getHeaders().get('Host') + '/CustomCommunityForgotPassword';
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'An existing account is connected to your secure ID. Please follow ' +'<a href="'+linkURL +'"> these </a>' + 'instructions to fix the problem'));
               // ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, System.label.Matched_User_Error_Message +'<a href="'+LoginURL +'"> here </a>' + 'or <a href="'+ResetPwdURL+'"> reset </a> your password.'));
                return null;
            }
            
            if(customerAccount.FirstName!=firstName || customerAccount.LastName!=lastName || (customerAccount.MiddleName==null?'':customerAccount.MiddleName)!=middleName)
            {
                String IncompleteErrorMsg = 'You have entered incorrect details, please type details as they appear in the Rates Notice';
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,IncompleteErrorMsg));
                return null;
            }
        }
        
        else
        {
            customerAccount = null;
            String InvalidNARErrorMsg = 'Please enter valid Secure ID';
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,InvalidNARErrorMsg));
            return null;
        }
        
        if(personAccount.cfsuite1__Preferred_Notification_Cases__c == null || personAccount.cfsuite1__Preferred_Notification_Cases__c == '') {
            personAccount.cfsuite1__Preferred_Notification_Cases__c = 'No Notifications';
        }
        
        if(personAccount.cfsuite1__Rates_notice_notifications__c == null || personAccount.cfsuite1__Rates_notice_notifications__c == '' || personAccount.cfsuite1__Rates_notice_notifications__c == 'No Notifications') {
            personAccount.cfsuite1__Rates_notice_notifications__c = 'Email';
        }
        
        personAccount.PersonEmail = email;
        personAccount.PersonMobilePhone  = mobilephone; 
        
	    Database.DMLOptions dml = new Database.DMLOptions();
		dml.DuplicateRuleHeader.allowSave = true;
		dml.DuplicateRuleHeader.runAsCurrentUser = true; 
			
        // Update Person Account 
        Database.SaveResult accountRecordUpdateResult = Database.update(personAccount, dml);
        
        // Iterate through each returned result
        
        if (accountRecordUpdateResult.isSuccess()) {
            // Operation was successful, so get the ID of the record that was processed
            System.debug('Successfully updated account. Account ID: ' + accountRecordUpdateResult.getId());
        }
        else {
            // Operation failed, so get all errors                
            for(Database.Error err : accountRecordUpdateResult.getErrors()) {
                System.debug('The following error has occurred.');                    
                System.debug(err.getStatusCode() + ': ' + err.getMessage());
                System.debug('Account fields that affected this error: ' + err.getFields());
            }
            
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Error in updating person Account -'+ accountRecordUpdateResult.getErrors()[0].getMessage() ));
            return null;
        }
        
        return personAccount.PersonContactId;
    }
    
    
    /***
Method Name : getBusinessContactId
Description : Validate User Creation and get Contact Id to associate community user with correct contact
**/
    public Id getBusinessContactId()
    {
        Id businessAccountTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Business').getRecordTypeId();   // Getting Business Account Id
        Account customerAccount;
        Contact con;
        
        /********************************************* Query to return if person account matched with (firstName,LastName and Email) ***********************************************/
        
        List<Account> NARBusinessMatchedList = [Select Id,Name,cfsuite1__Mobile__c,cfsuite1__Preferred_Notification_Cases__c,cfsuite1__Rates_notice_notifications__c,cfsuite1__Business_Email__c,cfsuite1__Business_Phone__c,cfsuite1__Business_Phone_Area_Code__c,cfsuite1__Authority_Id__c,cfsuite1__Status__c from Account where cfsuite1__Authority_ID__c =:NARCode limit 1];
        List<Account> emailAccountMatchedList = [Select Id,Name,cfsuite1__Business_Email__c from Account where Name=:BusinessName and cfsuite1__Business_Email__c=:email limit 1];
        
        if(NARBusinessMatchedList!=null && !NARBusinessMatchedList.isEmpty())
        {
            customerAccount = NARBusinessMatchedList[0];
            if(!customerAccount.Name.equalsIgnoreCase(BusinessName))
            {
                String InvalidNameErrorMsg = 'You have entered incorrect details, please type details as they appear in the Rates Notice';
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,InvalidNameErrorMsg));
                return null;
            }
        }
        else
        {
            customerAccount = null;
            String InvalidNARErrorMsg = 'Please enter valid Secure ID';
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,InvalidNARErrorMsg));
            return null;
        }
        
        
        if(customerAccount!=null){
            List<Contact> conList = [Select Id,AccountId from Contact where AccountId=:customerAccount.Id and cfsuite1__IsPrimaryContact__c = true and LastName=:BusinessName limit 1];
            List<User> userRecord;
            
            if(conList!=null && !conList.isEmpty()){
                
                con = conList[0];
                userRecord  = [Select Id,Name from User where Profile.Name =:defaultSettings.cfsuite1__CommunityUserProfileName__c and contactId=:con.Id limit 1];
            }
            else {
                //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'No Primary Contact exist for your account. Please contact admin'));
                //return null;
                    Contact c = new Contact();
                    c.AccountId = customerAccount.Id;
                    c.LastName = customerAccount.Name;
                    c.Email = customerAccount.cfsuite1__Business_Email__c;
                    c.MobilePhone = customerAccount.cfsuite1__Mobile__c;
                    c.Phone = customerAccount.cfsuite1__Business_Phone__c;
                    c.cfsuite1__Work_Phone_Area_Code__c = customerAccount.cfsuite1__Business_Phone_Area_Code__c;   
                    c.cfsuite1__Authority_Id__c = customerAccount.cfsuite1__Authority_Id__c;
                    c.cfsuite1__Status__c = customerAccount.cfsuite1__Status__c;        
                    c.cfsuite1__IsPrimaryContact__c = true;
                try{
                        insert c;
                        
                        List<Contact> insertedContact = [Select Id,AccountId from Contact where Id =: c.Id];
                        con = insertedContact[0];
                } Catch(Exception e){
                
                	 ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Error in creating Contact'));
                     return null;
                }
            }
            
            // If user exist, then Message will popup to reset the password.
            if(userRecord!=null && !userRecord.isEmpty())
            {
                String LoginURL = 'Https://'+ ApexPages.currentPage().getHeaders().get('Host') + '/CustomCommunityLogin?IsAccountExist=true';
                String linkURL = 'Https://'+ ApexPages.currentPage().getHeaders().get('Host') + '/LoginSecureID';
                String ResetPwdURL = 'Https://'+ ApexPages.currentPage().getHeaders().get('Host') + '/CustomCommunityForgotPassword';
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'An existing account is connected to your secure ID. Please follow ' +'<a href="'+linkURL +'"> these </a>' + 'instructions to fix the problem'));
               // ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, System.label.Matched_User_Error_Message +'<a href="'+LoginURL +'"> here </a>' + 'or <a href="'+ResetPwdURL+'"> reset </a> your password.'));
                return null;
            }
            
            if(customerAccount.cfsuite1__Preferred_Notification_Cases__c == null)
                customerAccount.cfsuite1__Preferred_Notification_Cases__c = 'No Notifications';
            
            if(customerAccount.cfsuite1__Rates_notice_notifications__c == null || customerAccount.cfsuite1__Rates_notice_notifications__c == 'No Notifications')
                customerAccount.cfsuite1__Rates_notice_notifications__c = 'Email';
            
            customerAccount.cfsuite1__Business_Email__c = businessEmail;
            customerAccount.cfsuite1__Mobile__c = businessMobile;
            
         	Database.DMLOptions dml = new Database.DMLOptions();
			dml.DuplicateRuleHeader.allowSave = true;
			dml.DuplicateRuleHeader.runAsCurrentUser = true; 
            
            // Update Business Account 
            Database.SaveResult accountRecordUpdateResult = Database.update(customerAccount, dml);
            
            // Iterate through each returned result
            
            if (accountRecordUpdateResult.isSuccess()) {
                // Operation was successful, so get the ID of the record that was processed
                System.debug('Successfully updated account. Account ID: ' + accountRecordUpdateResult.getId());
            }
            else {
                // Operation failed, so get all errors                
                for(Database.Error err : accountRecordUpdateResult.getErrors()) {
                    System.debug('The following error has occurred.');                    
                    System.debug(err.getStatusCode() + ': ' + err.getMessage());
                    System.debug('Account fields that affected this error: ' + err.getFields());
                }
                
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Error in updating Business Account -'+ accountRecordUpdateResult.getErrors()[0].getMessage() ));
                return null;
            }
        }
        
        return con.Id;
    }
    
    
    /***
Method Name : createCommunityUser
Description : Complete Registration Process to redirect user to Community landing page
**/
    public pageReference createCommunityUser()
    {
        Auth.VerificationResult res = System.UserManagement.verifySelfRegistration(Auth.VerificationMethod.Email,verificationCodeId,Code,null);
        
        if(res.success)  { 
            
            List<cfsuite1__Property_Customer__c> customerList = new List<cfsuite1__Property_Customer__c>();
            
            if(email != null){
                user u = [Select Id, AccountId from User where username =: email];
                
                if(u.AccountId != null){
                 	customerList = [select id from cfsuite1__Property_Customer__c where cfsuite1__Customer__c = :u.AccountId];
                    
                    for(cfsuite1__Property_Customer__c propCust: customerList) {
                        propCust.cfsuite1__Date_Linked_to_Property__c = System.today();
                        propCust.cfsuite1__Relationship_Status__c = 'Active';
                        propCust.cfsuite1__Inactive_Reason__c = 'Account Established';
                    }
                    update customerList;
                }
                
                System.setpassword(u.Id,password);
            }
            if(BusinessEmail != null){
                user u = [Select Id, AccountId from User where username = :BusinessEmail];
                
                if(u.AccountId != null){
                 	customerList = [select id from cfsuite1__Property_Customer__c where cfsuite1__Customer__c = :u.AccountId];
                    for(cfsuite1__Property_Customer__c propCust: customerList) {
                        propCust.cfsuite1__Date_Linked_to_Property__c = System.today();
                        propCust.cfsuite1__Relationship_Status__c = 'Active';
                        propCust.cfsuite1__Inactive_Reason__c = 'Account Established';
                    }
                    update customerList;
                }
                
                System.setpassword(u.Id,password);
            }   
            
            return res.redirect;
            
        }
        else {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Please contact system admin -'+ res.message));
            return null;
        }
    }   
    
    
    /***
Method Name : registerUserAsBusiness
Description : Initiated when business clicks on 'create new account' 
**/
    public PageReference registerUserAsBusiness() {
        // check for duplicate User by email
        if(checkExistingUser(BusinessEmail)) {
            String LoginURL = 'Https://'+ ApexPages.currentPage().getHeaders().get('Host') + '/CustomCommunityLogin?IsAccountExist=true';
            String addPropertyURL = 'Https://'+ ApexPages.currentPage().getHeaders().get('Host') + '/LoginPropertyMgmt';
           // String LoginURL = 'https://my.teatreegully.sa.gov.au/apex/CustomCommunityLogin?IsAccountExist=true';
            String ResetPwdURL = 'Https://'+ ApexPages.currentPage().getHeaders().get('Host') + '/CustomCommunityForgotPassword';
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, defaultSettings.cfsuite1__Matched_User_Error__c +'<a href="'+LoginURL +'"> here </a>' + 'or <a href="'+ResetPwdURL+'"> reset </a> your password. Follow '+'<a href="'+addPropertyURL +'"> these </a> instructions to add Property'));
            return null;
        }
        
        Profile customerCommunityProfile = [SELECT Id FROM Profile WHERE Name =:defaultSettings.cfsuite1__CommunityUserProfileName__c LIMIT 1];
        
        Savepoint sp = Database.setSavepoint();
        Id businessContactId = getBusinessContactId();
        if(businessContactId!=null) {
            /***************************************** Community User Initiation Process **********************************************/
            communityUser = new User();
            communityUser.Username = BusinessEmail;
            communityUser.Email = BusinessEmail;
            communityUser.LastName = BusinessName;
            communityUser.ProfileId = customerCommunityProfile.Id;
            communityUser.Alias = BusinessName.substring(0,4) + System.Today().Month() + system.Today().day();
            communityUser.ContactId = businessContactId;
			communityUser.LocaleSidKey = 'en_AU';
            communityUser.TimeZoneSidKey = 'Australia/Adelaide';
            communityUser.LanguageLocaleKey = 'en_US';
            communityUser.EmailEncodingKey = 'UTF-8';
            communityUser.MobilePhone = businessMobile;
            
            if(!String.isBlank(BusinessEmail) && String.isBlank(communityNickname)){
                List<User> userRecord   = [Select Id,Name,CommunityNickname from User where Profile.Name =:defaultSettings.cfsuite1__CommunityUserProfileName__c and CommunityNickname =:BusinessEmail limit 1];
                if(userRecord!=null && !userRecord.isEmpty()){
                    if(BusinessEmail.length() > 35) {
                        communityUser.communityNickname = BusinessEmail.substring(0,35) + System.Today().Month() + system.Today().day();
                    }
                    else {
                        communityUser.communityNickname = BusinessEmail.substring(0,businessEmail.length()) + System.Today().Month() + system.Today().day();
                    }
                }
                else{
                    communityUser.CommunityNickname = BusinessEmail;
                }
                system.debug('CommunityNickname'+communityUser.CommunityNickname);
            }   
            
            else {
                communityUser.CommunityNickname = communityNickname;
            }
            
            /**************************************** Initiate Verification Process **************************************************/
            
            try
            {  
                verificationCodeId = System.UserManagement.initSelfRegistration(Auth.VerificationMethod.Email,communityUser);
                system.debug('verificationId'+ verificationCodeId);
            }
            
            catch(Exception e)
            {
                Database.RollBack(sp);
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Please contact system admin'+ e.getMessage()));
            }
        }   
        return null;
    }
    
    private Boolean checkExistingUser(String userEmail) {
        Boolean isExistingUser = false;
        
        if(!String.isBlank(userEmail)) {
            List<User> existingUser = [SELECT Id, Email, Username FROM User WHERE Username = :userEmail LIMIT 1];
            isExistingUser = existingUser.size() > 0;
        }
        
        return isExistingUser;
    }
    
    /***
Method Name : Resend the Code to corresponding user email
Description : Initiated when clicks on 'Resend Code link' to resend the verification code.
**/
    public PageReference resendCode() {
        try
        {  
            verificationCodeId = System.UserManagement.initSelfRegistration(Auth.VerificationMethod.Email,communityUser);
            system.debug('verificationId'+ verificationCodeId);
        }
        catch(Exception e)
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Please contact system admin'+ e.getMessage()));
        }
        
        return null;
    }
}