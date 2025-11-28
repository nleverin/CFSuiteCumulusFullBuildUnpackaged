/*
* @Name : CommunitiesSelfRegControllers_ReqPortal
* @Description : Called by individual/business for registration on Request portal
*/
public without sharing class CommunitiesSelfRegControllers_ReqPortal {
    
    public String firstName { get; set; }
    public String lastName { get; set; }
    public String email { get; set; }
    public String password { get; set; }
    public String confirmPassword { get; set; }
    public String communityNickname { get; set; }
    public String Code {get;set;}
    public String userId {get;set;}
    public string middleName {get;set;}
    public string mobilePhone {get;set;}
    public string verificationCodeId {get;set;}
    public string BusinessName {get;set;}
    public string BusinessEmail {get;set;}
    public string BusinessMobile {get;set;}
    public String NARCode {get;set;}
    public User communityUser {get;set;}
    private String startURL {get;set;}
    public cfsuite1__CFSuiteSettings__c defaultSettings;
    
    // Constructor to set ExperienceId
    public CommunitiesSelfRegControllers_ReqPortal() {
        startURL = ApexPages.currentPage().getParameters().get('startURL');  
        String expid = ApexPages.currentPage().getParameters().get('expid');    
        //defaultSettings = cfsuite1__CFSuiteSettings__c.getOrgDefaults();
        defaultSettings = cfsuite1__CFSuiteSettings__c.getInstance(userinfo.getProfileId());
        
        if (expId != null) {
            Site.setExperienceId(expId); 
        }
    }

   /*
    * @Name : registerUserAsIndividual
    * @ReturnType : PageReference
    * @Description : Initiated when individual clicks on 'create new account' 
    */    
    public PageReference registerUserAsIndividual() {
        //system.debug('defaultSettings.cfsuite1__CommunityUserProfileName__c********'+defaultSettings.cfsuite1__CommunityUserProfileName__c +'****');
        //system.debug('>>>>>>>Found - '+[SELECT Name, Id FROM Profile]);
        //Profile customerCommunityProfile = [SELECT Id FROM Profile WHERE Name = 'Customer Community Users' LIMIT 1];
        Profile customerCommunityProfile = [SELECT Id FROM Profile WHERE Name =:defaultSettings.cfsuite1__CommunityUserProfileName__c LIMIT 1];
        Account customerAccount;
        Savepoint sp = Database.setSavepoint();
        
        Id PersonContactId = getPersonContactId();
        if(PersonContactId!=null)
        {
            /***************************************** Community User Initiation Process **********************************************/
            communityUser = new User();
            communityUser.Username = email;
            communityUser.Email = email;
            communityUser.FirstName = firstName;
            communityUser.LastName = lastName;
            communityUser.ProfileId = customerCommunityProfile.Id;
            communityUser.Alias = firstName.length() > 4 ? firstName.substring(0,4) + System.Today().Month() + system.Today().day() : firstName + System.Today().Month() + system.Today().day();
            communityUser.ContactId = PersonContactId;
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
                    communityUser.CommunityNickname = email;
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
            }
        }
        
        return null;
    }
    
   /*
    * @Name : getPersonContactId
    * @ReturnType : Id
    * @Description : Validate User Creation and get Person Contact Id to associate community user with correct contact
    */  
    public Id getPersonContactId()
    {
        Id personAccountTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Customer').getRecordTypeId();   // Getting Person Account Id
        Account customerAccount;
        Map<String,List<Account>> mapKeyToAccounts = new Map<String,List<Account>>();
        Map<String,List<Account>> mapKeyToNoMNAccounts  = new Map<String,List<Account>>();
        String InputNameKey = firstName +' -'+ lastName +' -'+ email +' -'+ middleName;
        String InputNoMNameKey = firstName +' -'+ lastName +' -'+ email +' -';
        System.debug('InputNameKey = ' + InputNameKey);
        
        
        // Query to search if User exist with same email, because email = username and username should be unique.
        List<User> userRec = [Select Id,Name from User where Profile.Name =:defaultSettings.cfsuite1__CommunityUserProfileName__c and email =:email limit 1];
        
        // If user exist, then Message will popup to reset the password.
        if(userRec!=null && !userRec.isEmpty())
        {
            String LoginURL = 'Https://'+ ApexPages.currentPage().getHeaders().get('Host') + '/CustomCommunityLogin?IsAccountExist=true';
            String ResetPwdURL = 'Https://'+ ApexPages.currentPage().getHeaders().get('Host') + '/CustomCommunityForgotPassword';
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, defaultSettings.cfsuite1__Matched_User_Error__c +'<a href="'+LoginURL +'"> here </a>' + 'or <a href="'+ResetPwdURL+'"> reset </a> your password.'));
            return null;
        }
        
        
        /********************************************* Query to return if person account matched with (firstName,LastName and Email) ***********************************************/
        List<Account> personAccountMatched = 
            [SELECT Id, FirstName, LastName, PersonEmail, MiddleName, 
             cfsuite1__Preferred_Notification_Cases__c, cfsuite1__Rates_notice_notifications__c, PersonMobilePhone, cfsuite1__Authority_ID__c ,OwnerId,cfsuite1__MatchedCustomer__c,cfsuite1__Residental_State__c 
             FROM Account 
             WHERE RecordTypeId =:personAccountTypeId 
             AND FirstName=:firstName 
             AND LastName=:lastName 
             AND PersonEmail=:email];
        
        if(!personAccountMatched.isEmpty())  // If Person Account exist in salesforce
        {
            // Designing the Map to use key as (FN+LN+Email) and value as Accounts.
            for(Account acc : personAccountMatched)
            {
                String key = acc.FirstName +' -'+ acc.LastName + ' -'+ acc.PersonEmail + ' -'+ (acc.MiddleName==null ?'':acc.MiddleName);
                String noMNamekey = acc.FirstName +' -'+ acc.LastName + ' -'+ acc.PersonEmail + ' -';
                
                system.debug('key = '+ key);
                if(mapKeyToAccounts.containskey(key)) {
                    List<Account> accList = mapKeyToAccounts.get(key);
                    accList.add(acc);
                    mapKeyToAccounts.put(key, accList);
                }
                else {
                    mapKeyToAccounts.put(key, new list<Account>{acc});
                }
                
                if(mapKeyToAccounts.containskey(noMNamekey)) {
                    List<Account> accList = mapKeyToAccounts.get(noMNamekey);
                    accList.add(acc);
                    mapKeyToAccounts.put(noMNamekey, accList);
                }
                else {
                    mapKeyToAccounts.put(noMNamekey, new list<Account>{acc});
                }
                
                if(acc.MiddleName == '' || acc.MiddleName == null){
                    system.debug('Entered Middlename');
                    if(mapKeyToNoMNAccounts.containskey(noMNamekey)) {
                        List<Account> accList = mapKeyToNoMNAccounts.get(noMNamekey);
                        accList.add(acc);
                        mapKeyToNoMNAccounts.put(noMNamekey, accList);
                    }
                    else {
                        mapKeyToNoMNAccounts.put(noMNamekey, new list<Account>{acc});
                    }
                }
            }
            
            // Check if Returned account list exist with more than one record or not
            if(mapKeyToAccounts.containskey(InputNameKey))
            {
                System.debug('contains InputNameKey');
                List<Account> listMatchedAccount = mapKeyToAccounts.get(InputNameKey);
                
                if(listMatchedAccount.size()>1)             // If Returned list exist with more than one record
                {
                    String ExistingAccountMatched = '';
                    for(Account accountRecord : listMatchedAccount)
                    {
                        if(accountRecord.cfsuite1__Authority_ID__c !=null) {
                            customerAccount = accountRecord;
                        }
                        
                        ExistingAccountMatched+=accountRecord.Id+',';
                    }     
                    
                    if(customerAccount == null) {                  // If more than one matched record with blank NAR Code
                        customerAccount = listMatchedAccount[0];
                    }
                    
                    customerAccount.cfsuite1__MatchedCustomer__c = ExistingAccountMatched;
                }
                else if(listMatchedAccount.size()==1) {
                    customerAccount = listMatchedAccount[0];
                }
                
                if(customerAccount.cfsuite1__Preferred_Notification_Cases__c == null) {
                    customerAccount.cfsuite1__Preferred_Notification_Cases__c = 'No Notifications';
                }
                
                if(customerAccount.cfsuite1__Rates_notice_notifications__c == null) {
                    customerAccount.cfsuite1__Rates_notice_notifications__c = 'No Notifications';
                }
            } else if(String.isBlank(middleName) && mapKeyToAccounts.containskey(InputNoMNameKey)) {    // now map without MiddleName
                System.debug('contains InputNoMNameKey');
                List<Account> listMatchedAccount = mapKeyToAccounts.get(InputNoMNameKey);
                
                if(listMatchedAccount.size()>1)             // If Returned list exist with more than one record
                {
                    String ExistingAccountMatched = '';
                    for(Account accountRecord : listMatchedAccount)
                    {
                        if(accountRecord.cfsuite1__Authority_ID__c !=null) {
                            customerAccount = accountRecord;
                        }
                        
                        ExistingAccountMatched+=accountRecord.Id+',';
                    }     
                    
                    if(customerAccount == null) {                  // If more than one matched record with blank NAR Code
                        customerAccount = listMatchedAccount[0];
                    }
                    
                    customerAccount.cfsuite1__MatchedCustomer__c = ExistingAccountMatched;
                }
                else if(listMatchedAccount.size()==1) {
                    customerAccount = listMatchedAccount[0];
                }
                
                if(customerAccount.cfsuite1__Preferred_Notification_Cases__c == null) {
                    customerAccount.cfsuite1__Preferred_Notification_Cases__c = 'No Notifications';
                }
                
                if(customerAccount.cfsuite1__Rates_notice_notifications__c == null) {
                    customerAccount.cfsuite1__Rates_notice_notifications__c = 'No Notifications';
                }
            }
            
            else if(!String.isBlank(middleName) && mapKeyToNoMNAccounts.containskey(InputNoMNameKey)) {    // now map with MiddleName
                List<Account> listMatchedAccount = mapKeyToNoMNAccounts.get(InputNoMNameKey);
                
                if(listMatchedAccount.size()>1)             // If Returned list exist with more than one record
                {
                    String ExistingAccountMatched = '';
                    for(Account accountRecord : listMatchedAccount)
                    {
                        if(accountRecord.cfsuite1__Authority_ID__c !=null) {
                            customerAccount = accountRecord;
                        }
                        
                        ExistingAccountMatched+=accountRecord.Id+',';
                    }     
                    
                    if(customerAccount == null) {                  // If more than one matched record with blank NAR Code
                        customerAccount = listMatchedAccount[0];
                    }
                    
                    customerAccount.cfsuite1__MatchedCustomer__c = ExistingAccountMatched;
                }
                else if(listMatchedAccount.size()==1) {
                    customerAccount = listMatchedAccount[0];
                }
                
                if(customerAccount.cfsuite1__Preferred_Notification_Cases__c == null) {
                    customerAccount.cfsuite1__Preferred_Notification_Cases__c = 'No Notifications';
                }
                
                if(customerAccount.cfsuite1__Rates_notice_notifications__c == null) {
                    customerAccount.cfsuite1__Rates_notice_notifications__c = 'No Notifications';
                }
            }
            
            if(customerAccount != null) {
                // Update Person Account 
                Database.SaveResult accountRecordUpdateResult = Database.update(customerAccount, false);
                
                // Iterate through each returned result
                if (accountRecordUpdateResult.isSuccess()) {
                    // Operation was successful, so get the ID of the record that was processed
                    System.debug('Successfully updated account. Account ID: ' + accountRecordUpdateResult.getId());
                }
                else {
                    // Operation failed
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Error in updating person Account -'+ accountRecordUpdateResult.getErrors()[0].getMessage() ));
                    return null;
                }
            }
        }
        
        if(customerAccount == null) {          // If Person Account not exist in salesforce, then create new customer
            customerAccount = new Account();
            customerAccount.RecordTypeId = personAccountTypeId;
            customerAccount.FirstName = firstName;
            customerAccount.LastName = lastName;
            customerAccount.PersonEmail = email;
            customerAccount.MiddleName = middleName;
            customerAccount.OwnerId = defaultSettings.cfsuite1__CommunityAccountOwnerId__c;
            customerAccount.PersonMobilePhone = mobilePhone;
            
            Database.DMLOptions dml = new Database.DMLOptions();
            dml.DuplicateRuleHeader.allowSave = true;
            dml.DuplicateRuleHeader.runAsCurrentUser = true; 
            
            // Insert Person Account
            Database.SaveResult accountRecordResult = Database.insert(customerAccount, dml); 

            // Iterate through each returned result
            if (accountRecordResult.isSuccess()) {   
                // Operation was successful, so get the ID of the record that was processed
                System.debug('Successfully inserted account. Account ID: ' + accountRecordResult.getId());
            }
            else {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Error in creating person Account: '+ accountRecordResult.getErrors()[0].getMessage()));
                return null;
            }
        }
        
        Account personAccountRecord = [Select PersonContactId From Account Where Id = :customerAccount.Id];     // Query to return Contact from person Account
        
        
        // Query to search if User exist for same person Account  
        List<User> userRecord = [Select Id,Name from User where Profile.Name =:defaultSettings.cfsuite1__CommunityUserProfileName__c and contactId=:personAccountRecord.PersonContactId limit 1];
        
        // If user exist, then Message will popup to reset the password.
        if(userRecord!=null && !userRecord.isEmpty())
        {
            String LoginURL = 'Https://'+ ApexPages.currentPage().getHeaders().get('Host') + '/CustomCommunityLogin?IsAccountExist=true';
            String ResetPwdURL = 'Https://'+ ApexPages.currentPage().getHeaders().get('Host') + '/CustomCommunityForgotPassword';
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, defaultSettings.cfsuite1__Matched_User_Error__c +'<a href="'+LoginURL +'"> here </a>' + 'or <a href="'+ResetPwdURL+'"> reset </a> your password.'));
            return null;
        }
        
        return personAccountRecord.PersonContactId;
    }

   /*
    * @Name : getBusinessContactId
    * @ReturnType : Id
    * @Description : Validate User Creation and get Contact Id to associate community user with correct contact
    */      
    public Id getBusinessContactId()
    {
        Id businessAccountTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Business').getRecordTypeId();   // Getting Business Account Id
        Account customerAccount;
        Contact con;
        
        /* if user exists with same email address return with error, email = username which should be unique.*/
        List<User> userRec = [Select Id,Name from User where Profile.Name =:defaultSettings.cfsuite1__CommunityUserProfileName__c and email =: BusinessEmail limit 1];
        
        // If user exist, then Message will popup to reset the password.
        if(userRec!=null && !userRec.isEmpty())
        {
            String LoginURL = 'Https://'+ ApexPages.currentPage().getHeaders().get('Host') + '/CustomCommunityLogin?IsAccountExist=true';
            String ResetPwdURL = 'Https://'+ ApexPages.currentPage().getHeaders().get('Host') + '/CustomCommunityForgotPassword';
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, defaultSettings.cfsuite1__Matched_User_Error__c +'<a href="'+LoginURL +'"> here </a>' + 'or <a href="'+ResetPwdURL+'"> reset </a> your password.'));
            return null;
        }
        
        /********************************************* Query to return if Business account matched with (Business Name, Email) ***********************************************/
        List<Account> businessAccountMatched = 
            [SELECT Id, Name, cfsuite1__Business_Email__c,cfsuite1__Mobile__c,cfsuite1__Business_Phone__c,cfsuite1__Business_Phone_Area_Code__c,cfsuite1__Authority_Id__c,cfsuite1__Status__c, cfsuite1__Preferred_Notification_Cases__c, cfsuite1__Rates_notice_notifications__c 
             FROM Account 
             WHERE 
             RecordTypeId = :businessAccountTypeId
             AND Name=:BusinessName 
             AND cfsuite1__Business_Email__c=:BusinessEmail 
             LIMIT 1];
        
        if(!businessAccountMatched.isEmpty()){   // If Person Account exist in salesforce
            System.debug('Business account matched');
            customerAccount = businessAccountMatched[0];
            
            if(customerAccount.cfsuite1__Preferred_Notification_Cases__c == null) {
                customerAccount.cfsuite1__Preferred_Notification_Cases__c = 'No Notifications';
            }
            
            if(customerAccount.cfsuite1__Rates_notice_notifications__c == null) {
                customerAccount.cfsuite1__Rates_notice_notifications__c = 'No Notifications';
            }
            
            // Update Business Account 
            Database.SaveResult accountRecordResult = Database.update(customerAccount, false);
            
            // Iterate through each returned result
            if (accountRecordResult.isSuccess()) {
                // Operation was successful, so get the ID of the record that was processed
                System.debug('Successfully updated account. Account ID: ' + accountRecordResult.getId());
            }
            else {
                // Operation failed, so get all errors                
                
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Error in updating Business Account: '+ accountRecordResult.getErrors()[0].getMessage()));
                return null;
            }
            
           List<Contact> conList = [SELECT Id,AccountId FROM Contact WHERE AccountId=:customerAccount.Id AND cfsuite1__IsPrimaryContact__c = true AND LastName=:BusinessName];
            if(!conList.isEmpty()){
                con = conList[0]; 
            } 
            else{
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
                    List<Contact> conRecordInserted = [SELECT Id,AccountId FROM Contact WHERE Id =: c.Id];
                    if(!conRecordInserted.isEmpty()){
                        con = conRecordInserted[0]; 
                    }   
                }Catch(Exception e){
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Error in creating contact please contact Admin'));
                }
            }
        }
        
        else          // If Business Account not exist in salesforce, then create new customer
        {
            customerAccount = new Account();
            customerAccount.Name = BusinessName;
            customerAccount.RecordTypeId = businessAccountTypeId;
            customerAccount.cfsuite1__Business_Email__c = BusinessEmail;
            customerAccount.OwnerId = defaultSettings.cfsuite1__CommunityAccountOwnerId__c;
            customerAccount.cfsuite1__Mobile__c = BusinessMobile;
            
            // Insert Business Account 
            Database.SaveResult accountRecordResult = Database.insert(customerAccount, false);
            
            // Iterate through each returned result
            
            if (accountRecordResult.isSuccess()) {
                // Operation was successful, so get the ID of the record that was processed
                System.debug('Successfully inserted account. Account ID: ' + accountRecordResult.getId());
            }
            else {
                                
                if(accountRecordResult.getErrors()[0].getMessage() == 'Use one of these records?') {
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Error in creating business Account: Duplicate record detected'));
                } else {
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Error in creating business Account: ' + accountRecordResult.getErrors()[0].getMessage()));
                }
                
                return null;
            }
            con = [Select Id, AccountId from Contact where AccountId = :customerAccount.Id AND cfsuite1__IsPrimaryContact__c = true AND LastName=:BusinessName limit 1];
        
        }
        
        
        List<User> userRecord = [Select Id,Name from User where Profile.Name =:defaultSettings.cfsuite1__CommunityUserProfileName__c and contactId=:con.Id limit 1];
        
        // If user exist, then Message will popup to reset the password.
        if(userRecord!=null && !userRecord.isEmpty())
        {
            String LoginURL = 'Https://'+ ApexPages.currentPage().getHeaders().get('Host') + '/CustomCommunityLogin?IsAccountExist=true';
            String ResetPwdURL = 'Https://'+ ApexPages.currentPage().getHeaders().get('Host') + '/CustomCommunityForgotPassword';
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, defaultSettings.cfsuite1__Matched_User_Error__c +'<a href="'+LoginURL +'"> here </a>' + 'or <a href="'+ResetPwdURL+'"> reset </a> your password.'));
            return null;
        }
        
        return con.Id;
    }
    
   /*
    * @Name : createCommunityUser
    * @ReturnType : pageReference
    * @Description: Complete Registration Process to redirect user to Community landing page
    */      

    public pageReference createCommunityUser()
    {
        if(code == null)
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Please enter verification code to proceed.'));
            return null;
        }
        Auth.VerificationResult res;
        if(!String.isBlank(startURL)){
            String hm = Site.getBaseUrl()+startURL;
            res = System.UserManagement.verifySelfRegistration(Auth.VerificationMethod.Email,verificationCodeId,Code,hm);
        }
        else{
            res = System.UserManagement.verifySelfRegistration(Auth.VerificationMethod.Email,verificationCodeId,Code,null);
        }
        if(res.success) {
            if(email != null){
                user u = [Select Id from User where username =: email];
                System.setpassword(u.Id,password);
            }
            if(BusinessEmail != null){
                user u = [Select Id from User where username =: BusinessEmail];
                System.setpassword(u.Id,password);
            }   
            return res.redirect;
        }
        else
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Please contact system admin - '+ res.message));
            return null;
        }
    }
   
    /*
    * @Name : registerUserAsBusiness
    * @ReturnType : pageReference
    * @Description: Initiated when business clicks on 'create new account' 
    */ 
    public PageReference registerUserAsBusiness() {
        Profile customerCommunityProfile = [SELECT Id FROM Profile WHERE Name =:defaultSettings.cfsuite1__CommunityUserProfileName__c LIMIT 1];
        Id personAccountTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('PersonAccount').getRecordTypeId(); 
        
        Savepoint sp = Database.setSavepoint();
        Id BusinessContactId = getBusinessContactId();
        
        if(BusinessContactId!=null)
        {
            /***************************************** Community User Initiation Process **********************************************/
            communityUser = new User();
            communityUser.Username = BusinessEmail;
            communityUser.Email = BusinessEmail;
            // communityUser.FirstName = firstName;
            communityUser.LastName = BusinessName;
            communityUser.ProfileId = customerCommunityProfile.Id;
            communityUser.Alias = BusinessName.length() > 4 ? BusinessName.substring(0,4) + System.Today().Month() + system.Today().day() : BusinessName + System.Today().Month() + system.Today().day();
            communityUser.ContactId = BusinessContactId;
            communityUser.LocaleSidKey = 'en_AU';
            communityUser.TimeZoneSidKey = 'Australia/Adelaide';
            communityUser.LanguageLocaleKey = 'en_US';
            communityUser.EmailEncodingKey = 'UTF-8';
            communityUser.MobilePhone = BusinessMobile; 
            
            if(!String.isBlank(BusinessEmail) && String.isBlank(communityNickname)) {
                communityUser.CommunityNickname = BusinessEmail;
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
            }
        }  
        System.debug('return null');
        return null;
    }

    /*
    * @Name : resendCode
    * @ReturnType : pageReference
    * @Description: Initiated when clicks on 'Resend Code link' to resend the verification code.
    */     
    public PageReference resendCode() {
        try
        {  
            verificationCodeId = System.UserManagement.initSelfRegistration(Auth.VerificationMethod.Email,communityUser);
        }
        
        catch(Exception e)
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Please contact system admin'+ e.getMessage()));
        }
        
        return null;
    }
}