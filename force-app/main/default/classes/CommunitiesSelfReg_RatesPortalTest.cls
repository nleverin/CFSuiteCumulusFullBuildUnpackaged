/*
 * @Description Test class for CommunitiesSelfReg_RatesPortal
 */
@isTest
public class CommunitiesSelfReg_RatesPortalTest {
    
    @testSetup static void testSetup() {
        CommunitiesSelfReg_TestDataUtil testData = new CommunitiesSelfReg_TestDataUtil();
        testData.createTestData();
    }
    

/*
 * @Description To test test method RegisterUserAsBusiness
 */     
    public static testMethod void testRegisterUserAsBusiness() {
        Test.startTest();
        CommunitiesSelfReg_RatesPortal rates = new CommunitiesSelfReg_RatesPortal();
        rates.password = 'test';
        rates.confirmPassword = 'test';
        rates.userId = 'test';
        Id a = rates.getBusinessContactId();
        PageReference output1 = rates.registerUserAsBusiness();
        //System.assert(isMessagePresent(new ApexPages.Message(ApexPages.Severity.ERROR,'Please enter valid NAR Code')));
    
    User newuser4 = [SELECT Id FROM User where UserName = 'user@test.com' LIMIT 1];
        System.runAs(newuser4) {
        rates.NARCode = '8987';
        rates.businessName = 'BusRatesNoName';
        PageReference output4 = rates.registerUserAsBusiness();
        PageReference output11 = rates.resendCode();
        System.debug('output4::'+output4); 
        }
        System.assert(isMessagePresent(new ApexPages.Message(ApexPages.Severity.ERROR,'You have entered incorrect details, please type details as they appear in the Rates Notice')));
        
        
        User newuser2 = [SELECT Id FROM User where UserName = 'user@test.com' LIMIT 1];
        System.runAs(newuser2) {
        rates.NARCode = '8987';
        rates.businessName = 'BusRates';
        PageReference output2 = rates.registerUserAsBusiness();
        }
      //  System.assert(isMessagePresent(new ApexPages.Message(ApexPages.Severity.ERROR,
                                            //  'Our system shows you already have an account, please Login<a href="Https://null/CustomCommunityLogin"> here </a>or <a href="Https://null/CustomCommunityForgotPassword"> reset </a> your password.')));
        

        User newuser3 = [SELECT Id FROM User where UserName = 'user2@test.com' LIMIT 1];
        System.runAs(newuser3) {
        rates.BusinessEmail = 'user2@test.com';
        rates.NARCode = '89872';
        rates.businessName = 'BusRates2';
        PageReference output3 = rates.registerUserAsBusiness();
        System.debug('output3::'+output3);
        }
       // System.assert(isMessagePresent(new ApexPages.Message(ApexPages.Severity.ERROR,
         //                                     'Our system shows you already have an account, please Login<a href="Https://null/CustomCommunityLogin"> here </a>or <a href="Https://null/CustomCommunityForgotPassword"> reset </a> your password.')));
        
        
         
        testingCommunityNickname(rates, 'userbus@test.com', 'userbusinessuserbusinessuserb@test.com');
        System.assert(isMessagePresent(new ApexPages.Message(ApexPages.Severity.ERROR,
                                              'Please contact system adminFailed to get network info.')));
            
       
        testingCommunityNickname(rates, 'userbusinessuserbusinessuserb@test.com', '');
        
        
        testingCommunityNickname(rates, '', 'usertest@test.com');
                
        Test.stopTest();
        
    }
    
    /*
   *   @Description To test test method createCommunityUser
   */ 
    public static testMethod void testCreateCommunityUser() {
        Test.startTest();
        CommunitiesSelfReg_RatesPortal rates = new CommunitiesSelfReg_RatesPortal();
        rates.createCommunityUser();
        System.assert(isMessagePresent(new ApexPages.Message(ApexPages.Severity.ERROR,'Please contact system admin -User identifier missing.')));
        Test.stopTest();
        
    }
    
   /*
   *   @Description To test test method RegisterUserAsIndividual
   */ 
    public static testMethod void testRegisterUserAsIndividual() {
        Test.startTest();
        CommunitiesSelfReg_RatesPortal rates = new CommunitiesSelfReg_RatesPortal();
        
        rates.registerUserAsIndividual();
        //System.assert(isMessagePresent(new ApexPages.Message(ApexPages.Severity.ERROR,'Please enter valid NAR Code')));
        
        User pnewuser = [SELECT Id FROM User where UserName = 'user@test.com' LIMIT 1];
        System.runAs(pnewuser) {
        rates.NARCode = '6788';
        rates.registerUserAsIndividual(); 
        }
        
      //  System.assert(isMessagePresent(new ApexPages.Message(ApexPages.Severity.ERROR,
                //                              'Our system shows you already have an account, please Login<a href="Https://null/CustomCommunityLogin"> here </a>or <a href="Https://null/CustomCommunityForgotPassword"> reset </a> your password.')));
      
        System.runAs(pnewuser) {
        rates.lastName = 'test';
        rates.firstName = 'firstname';
        rates.NARCode = '67880';
        rates.registerUserAsIndividual(); 
        }
        System.assert(isMessagePresent(new ApexPages.Message(ApexPages.Severity.ERROR,'You have entered incorrect details, please type details as they appear in the Rates Notice')));
        
        System.runAs(pnewuser) {
        rates.email = 'userp@test.com';
        rates.NARCode = '6788';
        rates.registerUserAsIndividual();
        }
    //    System.assert(isMessagePresent(new ApexPages.Message(ApexPages.Severity.ERROR,
      //                                        'Our system shows you already have an account, please Login<a href="Https://null/CustomCommunityLogin"> here </a>or <a href="Https://null/CustomCommunityForgotPassword"> reset </a> your password.')));
        
        rates.lastName = 'MyTest1LName';
        rates.firstName = 'MyTest1FName';
        rates.middleName = 'MyTest1MName';
        rates.NARCode = '67880';
        rates.registerUserAsIndividual(); 
        
        testingCommunityNicknameInd(rates, 'userbus@test.com', 'userbususerbususerbususer@test.com');
        System.assert(isMessagePresent(new ApexPages.Message(ApexPages.Severity.ERROR,
                                              'Please contact system adminFailed to get network info.')));
            
        testingCommunityNicknameInd(rates, 'userpbususerpbususerpbususerp@test.com', '');
        
        testingCommunityNicknameInd(rates, '', 'userpbus@test.com'+system.today());
        
        Test.stopTest();
    }
    
    public static boolean isMessagePresent(ApexPages.Message input) {
        List<ApexPages.Message> msgList = ApexPages.getMessages();
        boolean isPresent = false;
        
        for (ApexPages.Message msg: msgList) {
            if(msg.getSummary() == input.getSummary()
             && msg.getSeverity() == input.getSeverity()) {
             isPresent = true; 
             return isPresent;
        }
        }
        return isPresent;
    }
    
    public static void testingCommunityNickname(CommunitiesSelfReg_RatesPortal rates, String email, String updateEmail) {
        User newuser = [SELECT Id FROM User where UserName = 'user@test.com' LIMIT 1];
        System.runAs(newuser) {
        rates.communityNickname = '';
        rates.BusinessEmail = email;
    rates.NARCode = '89871';
        rates.businessName = 'BusRates1';
        rates.registerUserAsBusiness(); 
        newuser.CommunityNickname = updateEmail;
        update newuser;
         }
    }
    
    public static void testingCommunityNicknameInd(CommunitiesSelfReg_RatesPortal rates, String email, String updateEmail) {
        User newuser = [SELECT Id FROM User where UserName = 'user@test.com' LIMIT 1];
        System.runAs(newuser) {
        rates.communityNickname = '';
        rates.email = email;
    rates.NARCode = '67880';
        rates.lastName = 'MyTest1LName';
        rates.firstName = 'MyTest1FName';
        rates.middleName = 'MyTest1MName';
        rates.registerUserAsIndividual(); 
        newuser.CommunityNickname = updateEmail;
        update newuser;
         }
    }

}