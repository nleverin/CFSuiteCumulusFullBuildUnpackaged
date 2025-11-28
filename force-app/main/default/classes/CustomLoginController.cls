/**
 * @File Name          : CustomLoginController.cls
 * @Description        : 
 * @Author             : Hugh Wheeler
 * @Group              : 
 * @Last Modified By   : Hugh Wheeler
 * @Last Modified On   : 15/06/2020, 4:51:29 pm
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    15/06/2020   Hugh Wheeler     Initial Version
**/
public without sharing class CustomLoginController {
    public String username { get; set; }
    public String password { get; set; }
    public Boolean error { get; set; }
    public String errorMsg { get; set; }
    public String portalName {get;set;}
    public String IsAccountExist {get;set;}
    
    public CustomLoginController()
    {
        portalName = ApexPages.currentPage().getParameters().get('portalName');
        IsAccountExist = ApexPages.currentPage().getParameters().get('IsAccountExist');
    }
    
    public PageReference doLogin() {
        String invalidPassword = 'Invalid Password';
        String lockedOut = 'Password Lockout';
        
        System.debug(System.currentPageReference());
        this.error = false;
        String startUrl = System.currentPageReference().getParameters().get('startURL');
        PageReference page = Site.login(username, password, startUrl);
        
        Boolean hasErrors = ApexPages.hasMessages(ApexPages.Severity.ERROR);
        system.debug('hasErrors = '+ hasErrors);
        
        if(hasErrors || Test.isRunningTest()) {
            // check if login failed because User was locked out
            User u = null;
            for(User us : [SELECT Id FROM User WHERE Username =: username LIMIT 1]) {
                u = us;
            }
            
            if(u != null) {
                List<LoginHistory> lhList = [SELECT Id, UserId, LoginTime, Status FROM LoginHistory WHERE UserId =: u.Id ORDER BY LoginTime DESC LIMIT 1];
                System.debug('lhList = ' + lhList);
                if(lhList.size() > 0) {
                    LoginHistory lh = lhList.get(0);
                    if(lh.Status.equals(lockedOut)) {
                        System.debug('SETTING NEW ERROR MESSAGE');
                        // add a different message
                        ApexPages.addMessage(new ApexPages.Message(Apexpages.Severity.ERROR, 'You account has been locked due to too many incorrect login attempts, please try again in 30 minutes.'));
                    }
                }
            }
        }
        
        if(hasErrors == false) {
            userData d = getUserData();
        }
        
        return page;
    }
    
    public PageReference createPortal() {
        if(portalName == 'Request')
            return new pageReference('/apex/CreateAccount');
        else if(portalName == 'Rates')
            return new pageReference('/apex/CreateRatesAccount');
        
        return new pageReference('/apex/CreateAccount');  
    }
    
    @AuraEnabled
    public static String getLoginUrl() {
        String loginUrl = '/CustomCommunityLogin';
        /*List<Network> networkList = [SELECT Id FROM Network WHERE Name = 'Wollondilly Shire Council' AND Status = 'Live' LIMIT 1];
        if(networkList.size() > 0) {
            String communityId = networkList.get(0).Id;
            if(!Test.isRunningTest()) {
                ConnectApi.Community comm = ConnectApi.Communities.getCommunity(communityId);
                if(comm != null) {
                    loginUrl = comm.loginUrl;
                }
            }
        }*/
        
        return loginUrl;
    }
    
    @AuraEnabled
    public static userData getUserData() {
        String accountId = null;
        String userType = UserInfo.getUserType();
        String userId = UserInfo.getUserId();
        Boolean isGuest = userType == 'Guest';
        String firstName = UserInfo.getFirstName();
        String smallPhotoUrl = null;
        for(User u : [SELECT SmallPhotoUrl, FullPhotoUrl,AccountId FROM User WHERE Id =: userId]) {
            smallPhotoUrl = u.SmallPhotoUrl;   
            accountId =  u.AccountId;
        }
        
        List<Account> accountList = [SELECT Id,Name,IsPersonAccount FROM Account WHERE Id=:accountId LIMIT 1];
        
        if(accountList!=null && !accountList.isEmpty())
        {
            if(accountList[0].IsPersonAccount != True) {
                firstName = accountList[0].Name;
            }
        }
        
        // TODO: get unread notifications
        Integer notificationCount = 3;
        UserData response = new UserData(isGuest, firstName, smallPhotoUrl);
        response.notificationCount = notificationCount;
        System.debug('response = ' + response);
        return response;
    }
    
    public class UserData {
        public UserData(Boolean isGuest, String firstName, String smallPhotoUrl) {
            this.isGuest = isGuest;
            this.firstName = firstName;
            this.smallPhotoUrl = smallPhotoUrl;
        }
        
        @AuraEnabled @TestVisible
        public String firstName { get; set; }
        @AuraEnabled @TestVisible
        public Boolean isGuest { get; set; }
        @AuraEnabled @TestVisible
        public String smallPhotoUrl { get; set; }
        @AuraEnabled @TestVisible
        public Integer notificationCount { get; set; }
    }
}