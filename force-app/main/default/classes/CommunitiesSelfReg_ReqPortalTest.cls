/*
 * @Description Test class for CommunitiesSelfRegControllers_ReqPortal 
 */ 
@isTest
public class CommunitiesSelfReg_ReqPortalTest {

    @testSetup static void testSetup() {
        CommunitiesSelfReg_TestDataUtil testData = new CommunitiesSelfReg_TestDataUtil();
        testData.createTestData();
    }
    
/*
 * @Description To test RegisterUserAsBusiness method
 */     

    public static testMethod void testRegisterUserAsBusiness() {
        Test.startTest();
        CommunitiesSelfRegControllers_ReqPortal request = new CommunitiesSelfRegControllers_ReqPortal();
        
        request.registerUserAsBusiness();
        
        //System.assert(isMessagePresent(new ApexPages.Message(ApexPages.Severity.ERROR,'Error in creating business Account: Please Enter Email or Mobile Number as per selected Preferred Notification (Cases)')));
         
        //System.assert(isMessagePresent(new ApexPages.Message(ApexPages.Severity.ERROR,'Error in creating business Account: Required fields are missing: [Name]')));
         
        request.businessName = 'BusRates1';
        request.BusinessEmail = 'abc0@business.com';
        request.BusinessMobile = '1231231833';
        request.registerUserAsBusiness();
        //System.assert(isMessagePresent(new ApexPages.Message(ApexPages.Severity.ERROR,'Please contact system adminFailed to get network info.')));
        
        for (Contact con : [SELECT Id FROM Contact WHERE cfsuite1__IsPrimaryContact__c = true AND LastName = 'BusRates1' LIMIT 1 ]) {
            delete con;
        }
       
        request.registerUserAsBusiness();
        
        request.businessName = 'BusRatesNew';
        request.registerUserAsBusiness();
        
        
        User newuser3 = [SELECT Id FROM User where UserName = 'user2@test.com' LIMIT 1];
        System.runAs(newuser3) {
        request.BusinessEmail = 'user2@test.com';
        request.businessName = 'BusRates2';
        request.registerUserAsBusiness();
        }
   //     System.assert(isMessagePresent(new ApexPages.Message(ApexPages.Severity.ERROR,
                                      //        'Our system shows you already have an account, please Login<a href="Https://null/CustomCommunityLogin"> here </a>or <a href="Https://null/CustomCommunityForgotPassword"> reset </a> your password.')));
        
        User newuser2 = [SELECT Id FROM User where UserName = 'user@test.com' LIMIT 1];
        System.runAs(newuser2) {
        request.businessName = 'BusRates';
        PageReference output2 = request.registerUserAsBusiness();
        }
       // System.assert(isMessagePresent(new ApexPages.Message(ApexPages.Severity.ERROR,
                             //                 'Our system shows you already have an account, please Login<a href="Https://null/CustomCommunityLogin"> here </a>or <a href="Https://null/CustomCommunityForgotPassword"> reset </a> your password.')));
        
        
        
        testingCommunityNickname(request, 'userbus@test.com', 'userbusinessuserbusinessuserb@test.com');
        //System.assert(isMessagePresent(new ApexPages.Message(ApexPages.Severity.ERROR,
        //                                      'Please contact system adminFailed to get network info.')));
        
        testingCommunityNickname(request, 'userbusinessuserbusinessuserb@test.com', '');
        
        testingCommunityNickname(request, '', 'usertest@test.com');
        
        Test.stopTest();
    }
    
   /*
 	* 	@Description To test RegisterUserAsIndividual method
 	*/ 
    
    public static testMethod void testRegisterUserAsIndividual() {
        Test.startTest();
        CommunitiesSelfRegControllers_ReqPortal request = new CommunitiesSelfRegControllers_ReqPortal();
        
        request.registerUserAsIndividual();
        //System.assert(isMessagePresent(new ApexPages.Message(ApexPages.Severity.ERROR,'Error in creating person Account: Please Enter Email or Mobile Number as per selected Preferred Notification (Cases)')));
        
        System.assert(isMessagePresent(new ApexPages.Message(ApexPages.Severity.ERROR,'Error in creating person Account: Required fields are missing: [LastName]')));
        try{
            User pnewuser = [SELECT Id FROM User where UserName = 'user@test.com' LIMIT 1];
            System.runAs(pnewuser) {
            request.FirstName = 'MyTestFName';
            request.LastName = 'MyTestLName';
            request.email = 'userp@test.com';
            request.registerUserAsIndividual(); 
            }
            System.runAs(pnewuser) {
            request.lastName = 'test';
            request.firstName = 'firstname';
            //request.NARCode = '67880';
            request.registerUserAsIndividual(); 
            }
            //System.assert(isMessagePresent(new ApexPages.Message(ApexPages.Severity.ERROR,'You have entered incorrect details, please type details as they appear in the Rates Notice')));
            
            System.runAs(pnewuser) {
            request.email = 'userp@test.com';
            //request.NARCode = '6788';
            request.registerUserAsIndividual();
            }
        }catch(Exception ex){
            system.debug('Error '+ex.getMessage() +' of type '+ex.getTypeName() +' on line '+ex.getLineNumber());
        }         		
        request.lastName = 'MyTest1LName';
        request.firstName = 'MyTest1FName';
        request.middleName = 'MyTest1MName';
        request.email = 'usernewp@test.com';
        request.registerUserAsIndividual(); 
        
        System.assert(isMessagePresent(new ApexPages.Message(ApexPages.Severity.ERROR,
                                              'Please contact system adminFailed to get network info.')));
 
		request.lastName = 'MyTest1LName';
        request.firstName = 'MyTest1FName';
        request.middleName = 'MyTest1MName';
        request.email = 'example1@testclass.com';
        request.registerUserAsIndividual();
        
        request.firstName = 'MyTest2FName';
        request.lastName = 'MyTest2LName';
        request.middleName = 'MyTest1MName';
        request.email = 'example@testclass.com';
        request.registerUserAsIndividual();
        
        testingCommunityNicknameInd(request, 'userbus@test.com', 'userbususerbususerbususer@test.com');
        System.assert(isMessagePresent(new ApexPages.Message(ApexPages.Severity.ERROR,
                                              'Please contact system adminFailed to get network info.')));
            
       /* testingCommunityNicknameInd(request, 'userpbususerpbususerpbususerp@test.com', '');
        
        testingCommunityNicknameInd(request, '', 'userpbus@test.com');*/
        
        Test.stopTest();
    }

 public static testMethod void testRegisterUserAsIndividual2() {
        Test.startTest();
        CommunitiesSelfRegControllers_ReqPortal request = new CommunitiesSelfRegControllers_ReqPortal();
     
   
        request.registerUserAsIndividual();
        //System.assert(isMessagePresent(new ApexPages.Message(ApexPages.Severity.ERROR,'Error in creating person Account: Please Enter Email or Mobile Number as per selected Preferred Notification (Cases)')));
        
        System.assert(isMessagePresent(new ApexPages.Message(ApexPages.Severity.ERROR,'Error in creating person Account: Required fields are missing: [LastName]')));
        try{
            User pnewuser = [SELECT Id FROM User where UserName = 'user@test.com' LIMIT 1];
            System.runAs(pnewuser) {
                request.FirstName = 'MyTestFName';
                request.LastName = 'MyTestLName';
                request.password='12334567';
                request.confirmPassword='12334567';
                request.email = 'example@testclass.com';
                request.registerUserAsIndividual(); 
            }
            System.runAs(pnewuser) {
            request.lastName = 'test';
            request.firstName = 'firstname';
            //request.NARCode = '67880';
            request.registerUserAsIndividual(); 
            }
            //System.assert(isMessagePresent(new ApexPages.Message(ApexPages.Severity.ERROR,'You have entered incorrect details, please type details as they appear in the Rates Notice')));
            
            System.runAs(pnewuser) {
            request.email = 'userp@test.com';
            //request.NARCode = '6788';
            request.registerUserAsIndividual();
            }
        }catch(Exception ex){
            system.debug('Error '+ex.getMessage() +' of type '+ex.getTypeName() +' on line '+ex.getLineNumber());
        }         		
        request.lastName = 'MyTest1LName';
        request.firstName = 'MyTest1FName';
        request.middleName = 'MyTest1MName';
        request.email = 'usernewp@test.com';
        request.registerUserAsIndividual(); 
        
        System.assert(isMessagePresent(new ApexPages.Message(ApexPages.Severity.ERROR,
                                              'Please contact system adminFailed to get network info.')));
 
		request.lastName = 'MyTest1LName';
        request.firstName = 'MyTest1FName';
        request.middleName = 'MyTest1MName';
        request.email = 'example1@testclass.com';
        request.registerUserAsIndividual();
        
        request.firstName = 'MyTest2FName';
        request.lastName = 'MyTest2LName';
        request.middleName = 'MyTest1MName';
        request.email = 'example@testclass.com';
        request.registerUserAsIndividual();
        
       
        testingCommunityNicknameInd(request, '', '');
        
       /* testingCommunityNicknameInd(request, '', 'userpbus@test.com');*/
        
        Test.stopTest();
    }    
   /*
 	* 	@Description To test CreateCommunityUser method
 	*/
    public static testMethod void testCreateCommunityUser() {
        Test.startTest();
        CommunitiesSelfRegControllers_ReqPortal request = new CommunitiesSelfRegControllers_ReqPortal();
		
        PageReference prnull = request.createCommunityUser();
        System.assertEquals(null, prnull);
        
        request.Code = '12345';
        PageReference pr = request.createCommunityUser();
        
        Test.stopTest();
    }

	/*
 	* 	@Description To test resendCode method
 	*/
    public static testMethod void testResendCode() {
        Test.startTest();
        CommunitiesSelfRegControllers_ReqPortal request = new CommunitiesSelfRegControllers_ReqPortal();
		
        request.resendCode();
        
        Test.stopTest();
    }
    
    public static boolean isMessagePresent(ApexPages.Message input) {
        List<ApexPages.Message> msgList = ApexPages.getMessages();
        System.debug('msgList::'+msgList);
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
    
    public static void testingCommunityNickname(CommunitiesSelfRegControllers_ReqPortal request, String email, String updateEmail) {
        User newuser = [SELECT Id FROM User where UserName = 'user@test.com' LIMIT 1];
        System.runAs(newuser) {
        request.communityNickname = '';
        request.BusinessEmail = email;
		request.NARCode = '89871';
        request.BusinessName = 'BusRates1';
        request.registerUserAsBusiness(); 
        newuser.CommunityNickname = updateEmail;
        update newuser;
       	}
    }
    
    public static void testingCommunityNicknameInd(CommunitiesSelfRegControllers_ReqPortal request, String email, String updateEmail) {
        User newuser = [SELECT Id FROM User where UserName = 'user@test.com' LIMIT 1];
        System.runAs(newuser) {
        request.communityNickname = '';
        request.email = email;
		request.NARCode = '67880';
        request.lastName = 'MyTest1LName';
        request.firstName = 'MyTest1FName';
        request.middleName = 'MyTest1MName';
        request.registerUserAsIndividual(); 
        newuser.CommunityNickname = updateEmail;
        update newuser;
       	}
    }
    
}