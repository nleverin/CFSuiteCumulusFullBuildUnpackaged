BEGIN TRANSACTION;
CREATE TABLE "Account" (
	id VARCHAR(255) NOT NULL, 
	"FirstName" VARCHAR(255), 
	"LastName" VARCHAR(255), 
	"Name" VARCHAR(255), 
	"PersonDoNotCall" VARCHAR(255), 
	"PersonHasOptedOutOfEmail" VARCHAR(255), 
	"PersonHasOptedOutOfFax" VARCHAR(255), 
	"RecordTypeId" VARCHAR(255), 
	"cfsuite1__ABN__c" VARCHAR(255), 
	"cfsuite1__Address_Id_GIS_Postal__c" VARCHAR(255), 
	"cfsuite1__Address_Id_GIS_Residential__c" VARCHAR(255), 
	"cfsuite1__Alert_Code__c" VARCHAR(255), 
	"cfsuite1__Attribute__c" VARCHAR(255), 
	"cfsuite1__Authority_ID__c" VARCHAR(255), 
	"cfsuite1__Bankrupt__c" VARCHAR(255), 
	"cfsuite1__Business_Email__c" VARCHAR(255), 
	"cfsuite1__Business_Mobile__c" VARCHAR(255), 
	"cfsuite1__Business_Name__c" VARCHAR(255), 
	"cfsuite1__Business_Phone_Area_Code__c" VARCHAR(255), 
	"cfsuite1__Business_Phone__c" VARCHAR(255), 
	"cfsuite1__Customer_Alert__c" VARCHAR(255), 
	"cfsuite1__Customer_Type__c" VARCHAR(255), 
	"cfsuite1__Date_of_Death__c" VARCHAR(255), 
	"cfsuite1__Debtor_Number__c" VARCHAR(255), 
	"cfsuite1__Full_Postal_Address__c" VARCHAR(255), 
	"cfsuite1__Full_Street_Address__c" VARCHAR(255), 
	"cfsuite1__GPO_Box__c" VARCHAR(255), 
	"cfsuite1__GST_Registered_Picklist__c" VARCHAR(255), 
	"cfsuite1__Gender__c" VARCHAR(255), 
	"cfsuite1__Home_Phone_Area_Code__c" VARCHAR(255), 
	"cfsuite1__Home_Phone_Silent__c" VARCHAR(255), 
	"cfsuite1__Home_Phone__c" VARCHAR(255), 
	"cfsuite1__IsPrimaryContact__pc" VARCHAR(255), 
	"cfsuite1__Is_Pensioner__c" VARCHAR(255), 
	"cfsuite1__MatchedCustomer__c" VARCHAR(255), 
	"cfsuite1__Mobile__c" VARCHAR(255), 
	"cfsuite1__PO_Box__c" VARCHAR(255), 
	"cfsuite1__Pensioner_Number__c" VARCHAR(255), 
	"cfsuite1__Pensioner_Type__c" VARCHAR(255), 
	"cfsuite1__Person_Alert_Notes__c" VARCHAR(255), 
	"cfsuite1__Postal_Address_1__c" VARCHAR(255), 
	"cfsuite1__Postal_Address_2__c" VARCHAR(255), 
	"cfsuite1__Postal_Address_3__c" VARCHAR(255), 
	"cfsuite1__Postal_Care_of__c" VARCHAR(255), 
	"cfsuite1__Postal_Lot__c" VARCHAR(255), 
	"cfsuite1__Postal_Number__c" VARCHAR(255), 
	"cfsuite1__Postal_Parcel_Number__c" VARCHAR(255), 
	"cfsuite1__Postal_Post_Code__c" VARCHAR(255), 
	"cfsuite1__Postal_Property_Name__c" VARCHAR(255), 
	"cfsuite1__Postal_State__c" VARCHAR(255), 
	"cfsuite1__Postal_Street_Name__c" VARCHAR(255), 
	"cfsuite1__Postal_Street_Type__c" VARCHAR(255), 
	"cfsuite1__Postal_Suburb__c" VARCHAR(255), 
	"cfsuite1__Postal_Unit__c" VARCHAR(255), 
	"cfsuite1__Preferred_Communication_Method__c" VARCHAR(255), 
	"cfsuite1__Preferred_Contact_General__c" VARCHAR(255), 
	"cfsuite1__Preferred_Name__c" VARCHAR(255), 
	"cfsuite1__Preferred_Notification_Cases__c" VARCHAR(255), 
	"cfsuite1__Privacy_Settings_Applied__c" VARCHAR(255), 
	"cfsuite1__Rates_notice_notifications__c" VARCHAR(255), 
	"cfsuite1__Residental_Post_Code__c" VARCHAR(255), 
	"cfsuite1__Residental_State__c" VARCHAR(255), 
	"cfsuite1__Residental_Suburb__c" VARCHAR(255), 
	"cfsuite1__Residential_Lot__c" VARCHAR(255), 
	"cfsuite1__Residential_Parcel_Number__c" VARCHAR(255), 
	"cfsuite1__Residential_Property_Name__c" VARCHAR(255), 
	"cfsuite1__Residential_Street_Number__c" VARCHAR(255), 
	"cfsuite1__Residential_Street_Type__c" VARCHAR(255), 
	"cfsuite1__Residential_Unit__c" VARCHAR(255), 
	"cfsuite1__Secondary_Email__c" VARCHAR(255), 
	"cfsuite1__Service_Providers__c" VARCHAR(255), 
	"cfsuite1__Service_Request_Notifications__c" VARCHAR(255), 
	"cfsuite1__Status__c" VARCHAR(255), 
	"cfsuite1__Street_Address_1__c" VARCHAR(255), 
	"cfsuite1__Street_Address_2__c" VARCHAR(255), 
	"cfsuite1__Street_Address_3__c" VARCHAR(255), 
	"cfsuite1__Street_Name__c" VARCHAR(255), 
	"cfsuite1__Su__c" VARCHAR(255), 
	"cfsuite1__Suppressed__c" VARCHAR(255), 
	"cfsuite1__Sync_with_NAR__c" VARCHAR(255), 
	"cfsuite1__Work_Extension__c" VARCHAR(255), 
	"cfsuite1__Work_Phone__c" VARCHAR(255), 
	"IsPersonAccount" VARCHAR(255), 
	"ParentId" VARCHAR(255), 
	PRIMARY KEY (id)
);
INSERT INTO "Account" VALUES('Account-1','','','Sample Account for Entitlements','False','False','False','','','','','','','','','','','','','','','','','','','','','','','','','','False','','','','','','','','','','','','','','','','','','','','','','','','','','False','','','','','','','','','','','','False','','','','','','','','','','','','False','');
INSERT INTO "Account" VALUES('Account-2','','','Entitlement_Owner','False','False','False','012O5000006qtwDIAQ','','','','','','','','','','','08','','','','','','','','','','','08','No','','False','','','','','','','','','','','','','','','','','SA','','','','','Mail','Email','','','False','No Notifications','','SA','','','','','','','','','False','','Active','','','','','','No','No','','','False','');
INSERT INTO "Account" VALUES('Account-3','Hammy','Hampster','','False','False','False','012O5000006qtwEIAQ','','','','','','302300','','','','','08','','','','','','','','','','','08','No','','False','','','','','','','','','','','','','','','','','SA','','','','','','Email','','','False','No Notifications','','SA','','','','','','','','','False','','Active','','','','','','No','No','','','True','');
CREATE TABLE "Account_rt_mapping" (
	record_type_id VARCHAR(18) NOT NULL, 
	developer_name VARCHAR(255), 
	is_person_type BOOLEAN, 
	PRIMARY KEY (record_type_id)
);
INSERT INTO "Account_rt_mapping" VALUES('012O5000006qtwDIAQ','Business_Account',0);
INSERT INTO "Account_rt_mapping" VALUES('012O5000006qtwEIAQ','PersonAccount',1);
INSERT INTO "Account_rt_mapping" VALUES('012O5000006qu7VIAQ','Business',0);
INSERT INTO "Account_rt_mapping" VALUES('012O5000006qu7WIAQ','Overseas_Business',0);
INSERT INTO "Account_rt_mapping" VALUES('012O5000006qu81IAA','Employee',1);
INSERT INTO "Account_rt_mapping" VALUES('012O5000006qu82IAA','Overseas_Customer',1);
INSERT INTO "Account_rt_mapping" VALUES('012O5000006quqfIAA','Business_Account',0);
CREATE TABLE "cfsuite1__CFSuiteIntegrationSettings__c" (
	id VARCHAR(255) NOT NULL, 
	"Name" VARCHAR(255), 
	"cfsuite1__GoogleAPIkey__c" VARCHAR(255), 
	"cfsuite1__RecaptchaSiteKey__c" VARCHAR(255), 
	"cfsuite1__Recaptcha_Secret_Key__c" VARCHAR(255), 
	"cfsuite1__Recaptcha_Site_Key__c" VARCHAR(255), 
	"cfsuite1__Recaptcha_Threshold_Score__c" VARCHAR(255), 
	"cfsuite1__Recaptcha_Verify_URL__c" VARCHAR(255), 
	"cfsuite1__SMS_Callback_URL__c" VARCHAR(255), 
	PRIMARY KEY (id)
);
CREATE TABLE "cfsuite1__CFSuiteRatesSettings__c" (
	id VARCHAR(255) NOT NULL, 
	"Name" VARCHAR(255), 
	"cfsuite1__Accepted_Credit_Cards__c" VARCHAR(255), 
	"cfsuite1__Add_Payer_Named_Credential__c" VARCHAR(255), 
	"cfsuite1__Allow_Agent_Property_Add__c" VARCHAR(255), 
	"cfsuite1__Allow_Direct_Debit__c" VARCHAR(255), 
	"cfsuite1__Annual_Balance_Help_Text__c" VARCHAR(255), 
	"cfsuite1__Auto_Approval_Sub_Reason__c" VARCHAR(255), 
	"cfsuite1__Auto_Approval_Threshold__c" VARCHAR(255), 
	"cfsuite1__Biller_Code__c" VARCHAR(255), 
	"cfsuite1__Business_Name__c" VARCHAR(255), 
	"cfsuite1__Bypass_Payment_Page__c" VARCHAR(255), 
	"cfsuite1__Case_Details_URL__c" VARCHAR(255), 
	"cfsuite1__Community_Base_URL__c" VARCHAR(255), 
	"cfsuite1__Community_Login_URL__c" VARCHAR(255), 
	"cfsuite1__Community_Name__c" VARCHAR(255), 
	"cfsuite1__Council_Legal_Name__c" VARCHAR(255), 
	"cfsuite1__Council_Portal_Display_Name__c" VARCHAR(255), 
	"cfsuite1__Council_Rates_Email_Address__c" VARCHAR(255), 
	"cfsuite1__Courtesy_Reminder_Email_DD__c" VARCHAR(255), 
	"cfsuite1__Courtesy_Reminder_Email_No_DD__c" VARCHAR(255), 
	"cfsuite1__Courtesy_Reminder_SMS_DD__c" VARCHAR(255), 
	"cfsuite1__Courtesy_Reminder_SMS_No_DD__c" VARCHAR(255), 
	"cfsuite1__Custom_Logo_Black__c" VARCHAR(255), 
	"cfsuite1__Custom_Logo_White__c" VARCHAR(255), 
	"cfsuite1__Customer_Service_Phone_Rates__c" VARCHAR(255), 
	"cfsuite1__Customer_Service_Team_Rates__c" VARCHAR(255), 
	"cfsuite1__DD_Cancellation_Reasons__c" VARCHAR(255), 
	"cfsuite1__Debt_Collector_Name_Rates__c" VARCHAR(255), 
	"cfsuite1__Debt_Collector_Phone_Rates__c" VARCHAR(255), 
	"cfsuite1__Direct_Debit_Button_Text__c" VARCHAR(255), 
	"cfsuite1__Direct_Debit_Statement_Reference__c" VARCHAR(255), 
	"cfsuite1__Direct_Debit_URL__c" VARCHAR(255), 
	"cfsuite1__Disable_Manual_Property_Link__c" VARCHAR(255), 
	"cfsuite1__Download_Notice_Host_Name__c" VARCHAR(255), 
	"cfsuite1__Download_Notice_Named_Credential__c" VARCHAR(255), 
	"cfsuite1__Extension_Display_Due_Date__c" VARCHAR(255), 
	"cfsuite1__Extension_Request__c" VARCHAR(255), 
	"cfsuite1__FAQ_URL__c" VARCHAR(255), 
	"cfsuite1__Financial_Statement_Reference__c" VARCHAR(255), 
	"cfsuite1__Full_Linked_Prop_URL__c" VARCHAR(255), 
	"cfsuite1__Hide_Latest_Rates_Notice_Link__c" VARCHAR(255), 
	"cfsuite1__Integrapay_TP_Named_Credential__c" VARCHAR(255), 
	"cfsuite1__Is_Soft_Release__c" VARCHAR(255), 
	"cfsuite1__Legal_Action_Name_Rates__c" VARCHAR(255), 
	"cfsuite1__Legal_Action_Phone_Rates__c" VARCHAR(255), 
	"cfsuite1__Location_Of_DD__c" VARCHAR(255), 
	"cfsuite1__Major_Agent_Codes__c" VARCHAR(255), 
	"cfsuite1__Manage_DD_URL__c" VARCHAR(255), 
	"cfsuite1__Marketing_Legal_Name__c" VARCHAR(255), 
	"cfsuite1__Maximum_Payment_Limit__c" VARCHAR(255), 
	"cfsuite1__Minimum_Arrears_Amount__c" VARCHAR(255), 
	"cfsuite1__Minimum_Payment_Limit__c" VARCHAR(255), 
	"cfsuite1__Notice_Help_URL__c" VARCHAR(255), 
	"cfsuite1__Number_Of_Years_Payments__c" VARCHAR(255), 
	"cfsuite1__Overdue_Circle_Colour__c" VARCHAR(255), 
	"cfsuite1__Overdue_Days_Calculation__c" VARCHAR(255), 
	"cfsuite1__Pay_Source_Require_Bank_Dtls__c" VARCHAR(255), 
	"cfsuite1__Pay_Trans_Host_Name__c" VARCHAR(255), 
	"cfsuite1__Pay_Trans_Named_Credential__c" VARCHAR(255), 
	"cfsuite1__Payment_Event_Type__c" VARCHAR(255), 
	"cfsuite1__Payment_Extension_Display_Text__c" VARCHAR(255), 
	"cfsuite1__Payment_Extension_Indefinite_Article__c" VARCHAR(255), 
	"cfsuite1__Payment_Plan_PDF_Page_Name__c" VARCHAR(255), 
	"cfsuite1__Payment_Plan__c" VARCHAR(255), 
	"cfsuite1__Payment_Soon_Colour__c" VARCHAR(255), 
	"cfsuite1__Payment_Transfer_Months_Allowed__c" VARCHAR(255), 
	"cfsuite1__Payment_Transfer_Refund_Page_Name__c" VARCHAR(255), 
	"cfsuite1__Penalty_Term__c" VARCHAR(255), 
	"cfsuite1__Portal_Display_Name__c" VARCHAR(255), 
	"cfsuite1__Properties_My_Linked_URL__c" VARCHAR(255), 
	"cfsuite1__Property_Extension_URL__c" VARCHAR(255), 
	"cfsuite1__Property_Link_URL__c" VARCHAR(255), 
	"cfsuite1__Property_My_Linked_URL__c" VARCHAR(255), 
	"cfsuite1__Property_Payment_URL__c" VARCHAR(255), 
	"cfsuite1__RatesNoticeCredentialName__c" VARCHAR(255), 
	"cfsuite1__Rates_Final_Reminder_URL__c" VARCHAR(255), 
	"cfsuite1__Rates_Notice_Host_Name__c" VARCHAR(255), 
	"cfsuite1__Rates_Notice_Named_Credential__c" VARCHAR(255), 
	"cfsuite1__Rates_Payment_Product_Name__c" VARCHAR(255), 
	"cfsuite1__Refund_Credit_Balance__c" VARCHAR(255), 
	"cfsuite1__Refund_Credit_URL__c" VARCHAR(255), 
	"cfsuite1__Replacement_Text__c" VARCHAR(255), 
	"cfsuite1__Requires_Approval_Sub_Reason__c" VARCHAR(255), 
	"cfsuite1__Restricted_Record_Type__c" VARCHAR(255), 
	"cfsuite1__Reverse_Payment_Bank__c" VARCHAR(255), 
	"cfsuite1__Reverse_Payment_Source__c" VARCHAR(255), 
	"cfsuite1__Rollover_Date_Date_Format__c" VARCHAR(255), 
	"cfsuite1__Rollover_Date__c" VARCHAR(255), 
	"cfsuite1__Section_184_Code__c" VARCHAR(255), 
	"cfsuite1__Terms_CMS_Key__c" VARCHAR(255), 
	"cfsuite1__Terms_CMS_Name__c" VARCHAR(255), 
	"cfsuite1__Text_For_DD_Link__c" VARCHAR(255), 
	"cfsuite1__Thank_You_Page_Adv_Img__c" VARCHAR(255), 
	"cfsuite1__Thank_You_Page_Alt_Text__c" VARCHAR(255), 
	"cfsuite1__Transfer_Payment__c" VARCHAR(255), 
	"cfsuite1__Unrestricted_Record_Type__c" VARCHAR(255), 
	"cfsuite1__Up_To_Date_Colour__c" VARCHAR(255), 
	"cfsuite1__Use_Lanes__c" VARCHAR(255), 
	"cfsuite1__Validate_BSB_Named_Credential__c" VARCHAR(255), 
	"cfsuite1__Valuation_Objection_URL__c" VARCHAR(255), 
	PRIMARY KEY (id)
);
INSERT INTO "cfsuite1__CFSuiteRatesSettings__c" VALUES('cfsuite1__CFSuiteRatesSettings__c-1','a0WBm000001VyqX','Visa,Mastercard','','No','No','This amount includes any debts against the property, rates owing, or any approved transfers or refunds.','Under 5 days','5','10330','','Yes','/s/case-details','/s/','https://my.councilname.sa.gov.au/CustomLoginPage','ccs Portal','City of Charles Sturt','City of Charles Sturt','council@charlessturt.sa.gov.au','Courtesy_Reminder_Quarter_DD','Courtesy_Reminder_No_DD','Rates_Courtesy_Reminder_Quarter_DD','Rates_Courtesy_Reminder_No_DD','BPay','BPay','8408 1111','Customer Service','Change of Ownership;Cancelled by Staff','Arma Debt Resolution','1300 137 325','Setup Direct Debit','City of Charles Sturt','https://eforms.charlessturt.sa.gov.au/Produce/wizard/9458a570-36bc-4261-a7df-c974842b4b70','Yes','https://api-test.charlessturt.sa.gov.au','Download_Notice_CCS','No','Rates - Extension Request','/s/rates-faq','City of Charles Sturt','https://charlessturt--test.sandbox.my.site.com/s/propertysummary?id=','No','','No','Arma Debt Resolution','1300 137 325','','','/s/manage-direct-debit','City of Charles Sturt','1500.0','500.0','100.0','','2.0','#EE2A29','60.0','Bank Transfer;Australia Post;Other;Front Counter;Cash','','Payment_Transaction_CCS','','short term arrangement','a','PaymentPlanPDF','Rates - Payment Plan','#0055a4','12.0','Payment_transfer_or_refund__c','','City of Charles Sturt','/s/mylinkedproperties','/s/paymentextension','/s/propertylink','/s/propertysummary','https://ccs-web.t1cloud.com/T1PRDefault/WebApps/eProperty/P1/ePay/RatesPayment.aspx?r=P1.WEBGUEST&f=%24P1.EPY.RATES.ENQ','Ocp-Apim-Subscription-Key','https://my.councilname.sa.gov.au/rates','https://api-test.charlessturt.sa.gov.au','Rates_Notice_CCS','Rates Installment','Rates - Refund Credit Balance','/s/refund-credit','','Over 5 days','Finance-Restricted','Rates - Reverse Payment (Bank)','Rates - Reverse Payment (Source)','','21/07/2025','8 - Section 184 Action','MCLX77B7WKABHUHJQE5ZZVL3XQ7M','termsAndConditions','','','','Rates - Transfer Payment','Finance-Unrestricted','#008a5f','Yes','','https://www.valuergeneral.sa.gov.au/valuation/objecting-to-a-valuation');
CREATE TABLE "cfsuite1__CFSuiteSettings__c" (
	id VARCHAR(255) NOT NULL, 
	"Name" VARCHAR(255), 
	"cfsuite1__AO_Home_Page_Default_View__c" VARCHAR(255), 
	"cfsuite1__Additional_Details_Mandatory__c" VARCHAR(255), 
	"cfsuite1__Additional_Location_Information__c" VARCHAR(255), 
	"cfsuite1__Address_FullAddressField__c" VARCHAR(255), 
	"cfsuite1__Address_ID_GIS_Field__c" VARCHAR(255), 
	"cfsuite1__Address_ID_Property__c" VARCHAR(255), 
	"cfsuite1__Address_ParcelNumberField__c" VARCHAR(255), 
	"cfsuite1__Address_PostcodeField__c" VARCHAR(255), 
	"cfsuite1__Address_Redirect_Whitelist__c" VARCHAR(255), 
	"cfsuite1__Address_StateField__c" VARCHAR(255), 
	"cfsuite1__Address_StreetNameField__c" VARCHAR(255), 
	"cfsuite1__Address_StreetNumberField__c" VARCHAR(255), 
	"cfsuite1__Address_StreetTypeField__c" VARCHAR(255), 
	"cfsuite1__Address_SuburbField__c" VARCHAR(255), 
	"cfsuite1__Address_UnitNumberField__c" VARCHAR(255), 
	"cfsuite1__Address_UpdateSortOrder__c" VARCHAR(255), 
	"cfsuite1__Address_Update_Message__c" VARCHAR(255), 
	"cfsuite1__After_Hours_Number_Text__c" VARCHAR(255), 
	"cfsuite1__After_Hours_Phone_Number__c" VARCHAR(255), 
	"cfsuite1__Allowed_File_Extensions_For_Internal__c" VARCHAR(255), 
	"cfsuite1__Allowed_File_Extensions__c" VARCHAR(255), 
	"cfsuite1__AreaLayerName__c" VARCHAR(255), 
	"cfsuite1__AreaLayerURL__c" VARCHAR(255), 
	"cfsuite1__Article_URL__c" VARCHAR(255), 
	"cfsuite1__Asset_Layer_Community_Prompt__c" VARCHAR(255), 
	"cfsuite1__Assigned_Status__c" VARCHAR(255), 
	"cfsuite1__BuildingAddressAttrText__c" VARCHAR(255), 
	"cfsuite1__BuildingDescriptionAttrText__c" VARCHAR(255), 
	"cfsuite1__BuildingLayerOutputFields__c" VARCHAR(255), 
	"cfsuite1__BuildingLayerPopupTemplate__c" VARCHAR(255), 
	"cfsuite1__BuildingLayerSearchField1__c" VARCHAR(255), 
	"cfsuite1__BuildingLayerSearchField2__c" VARCHAR(255), 
	"cfsuite1__BuildingLayerSearchTemplate__c" VARCHAR(255), 
	"cfsuite1__BuildingLayerSuggestionTemplate__c" VARCHAR(255), 
	"cfsuite1__BuildingParcelNumAttrText__c" VARCHAR(255), 
	"cfsuite1__BuildingPostCode__c" VARCHAR(255), 
	"cfsuite1__Building_Council_Name__c" VARCHAR(255), 
	"cfsuite1__BuildingsLayerName__c" VARCHAR(255), 
	"cfsuite1__BuildingsLayerURL__c" VARCHAR(255), 
	"cfsuite1__Buildings_Street_Name_Field__c" VARCHAR(255), 
	"cfsuite1__Buildings_Suburb_Field__c" VARCHAR(255), 
	"cfsuite1__BusLayerDistanceField__c" VARCHAR(255), 
	"cfsuite1__BusLayerName__c" VARCHAR(255), 
	"cfsuite1__BusLayerOutputFields__c" VARCHAR(255), 
	"cfsuite1__BusLayerPopupTemplate__c" VARCHAR(255), 
	"cfsuite1__BusLayerSearchField1__c" VARCHAR(255), 
	"cfsuite1__BusLayerSearchField2__c" VARCHAR(255), 
	"cfsuite1__BusLayerSearchTemplate__c" VARCHAR(255), 
	"cfsuite1__BusLayerSuggestionTemplate__c" VARCHAR(255), 
	"cfsuite1__BusLayerURL__c" VARCHAR(255), 
	"cfsuite1__BusLayerUnitField__c" VARCHAR(255), 
	"cfsuite1__BusStopAttrText__c" VARCHAR(255), 
	"cfsuite1__BusStopPostCode__c" VARCHAR(255), 
	"cfsuite1__BusStopStreetNameField__c" VARCHAR(255), 
	"cfsuite1__Bus_Council_Name__c" VARCHAR(255), 
	"cfsuite1__Bus_Stop_Suburb_Field__c" VARCHAR(255), 
	"cfsuite1__Business_Hours_Number_Text__c" VARCHAR(255), 
	"cfsuite1__Business_Hours_Per_Day__c" VARCHAR(255), 
	"cfsuite1__Bypass_Recaptcha__c" VARCHAR(255), 
	"cfsuite1__Case_Confid_Sup_Alert_Msg__c" VARCHAR(255), 
	"cfsuite1__Case_Confid_Sup_Msg__c" VARCHAR(255), 
	"cfsuite1__Case_Confidential_Msg__c" VARCHAR(255), 
	"cfsuite1__Case_Created_No_Days_Text__c" VARCHAR(255), 
	"cfsuite1__Case_Created_No_Days_Text_cq__c" VARCHAR(255), 
	"cfsuite1__Case_Details_Page_Banner_Title__c" VARCHAR(255), 
	"cfsuite1__Case_Details_URL__c" VARCHAR(255), 
	"cfsuite1__Case_Note_Num_of_Rows__c" VARCHAR(255), 
	"cfsuite1__Case_Sup_Alert_Msg__c" VARCHAR(255), 
	"cfsuite1__Case_Sup_No_Alert_Msg__c" VARCHAR(255), 
	"cfsuite1__Close_Parent_On_Cat_Change__c" VARCHAR(255), 
	"cfsuite1__Closed_Case_Status__c" VARCHAR(255), 
	"cfsuite1__Com_Guest_Usr_URL__c" VARCHAR(255), 
	"cfsuite1__Com_My_Flwd_Req_Unflw__c" VARCHAR(255), 
	"cfsuite1__Com_My_Flwed_Req_Title__c" VARCHAR(255), 
	"cfsuite1__Com_My_Req_Page_Title__c" VARCHAR(255), 
	"cfsuite1__CommunityAccountOwnerId__c" VARCHAR(255), 
	"cfsuite1__CommunityShareAccountId__c" VARCHAR(255), 
	"cfsuite1__CommunityUserProfileName__c" VARCHAR(255), 
	"cfsuite1__Community_Additional_Info_Char_limit__c" VARCHAR(255), 
	"cfsuite1__Community_Default_Case_Origin__c" VARCHAR(255), 
	"cfsuite1__Community_Profile__c" VARCHAR(255), 
	"cfsuite1__Community_URL_Prefix__c" VARCHAR(255), 
	"cfsuite1__Community_VF_Prefix__c" VARCHAR(255), 
	"cfsuite1__Community_max_file_size_MB__c" VARCHAR(255), 
	"cfsuite1__Complete_Status__c" VARCHAR(255), 
	"cfsuite1__Council_Address__c" VARCHAR(255), 
	"cfsuite1__Council_Phone_Number__c" VARCHAR(255), 
	"cfsuite1__Council_Title__c" VARCHAR(255), 
	"cfsuite1__CouncillorQuestionPortalSLA__c" VARCHAR(255), 
	"cfsuite1__Councillor_Profile__c" VARCHAR(255), 
	"cfsuite1__Councillor_Question_Filter_Date__c" VARCHAR(255), 
	"cfsuite1__Councillor_Req_URL__c" VARCHAR(255), 
	"cfsuite1__Create_Account_URL__c" VARCHAR(255), 
	"cfsuite1__Custom_Map_GUID__c" VARCHAR(255), 
	"cfsuite1__Customer_Alert_Msg__c" VARCHAR(255), 
	"cfsuite1__Customer_Salutations__c" VARCHAR(255), 
	"cfsuite1__Customer_Suppressed_Alert_Msg__c" VARCHAR(255), 
	"cfsuite1__Customer_Suppressed_Msg__c" VARCHAR(255), 
	"cfsuite1__Default_Community_Locale__c" VARCHAR(255), 
	"cfsuite1__Default_Community_Time_Zone__c" VARCHAR(255), 
	"cfsuite1__Default_Council__c" VARCHAR(255), 
	"cfsuite1__Default_Zoom_AO_Map__c" VARCHAR(255), 
	"cfsuite1__Default_Zoom__c" VARCHAR(255), 
	"cfsuite1__Detailed_Knowledge__c" VARCHAR(255), 
	"cfsuite1__Disable_Contact_Addr_Edit__c" VARCHAR(255), 
	"cfsuite1__Disable_Contact_Info_Edit__c" VARCHAR(255), 
	"cfsuite1__Disable_Preference_Edit_Rates__c" VARCHAR(255), 
	"cfsuite1__Disable_Preference_Edit__c" VARCHAR(255), 
	"cfsuite1__Disable_Profile_Edit__c" VARCHAR(255), 
	"cfsuite1__Display_Employee_RT__c" VARCHAR(255), 
	"cfsuite1__Display_Postal_Address_Addr_Update__c" VARCHAR(255), 
	"cfsuite1__Display_Postal_Address_New_Customer__c" VARCHAR(255), 
	"cfsuite1__Display_Residential_Address_New_Customer__c" VARCHAR(255), 
	"cfsuite1__Display_Residential_Address_Update__c" VARCHAR(255), 
	"cfsuite1__Down_For_Maintenance_Site_URL__c" VARCHAR(255), 
	"cfsuite1__Duplicate_Active_Agent_Message__c" VARCHAR(255), 
	"cfsuite1__Duplicate_Radius__c" VARCHAR(255), 
	"cfsuite1__Email_Address_Customer_Service__c" VARCHAR(255), 
	"cfsuite1__Email_Address_to_Contact__c" VARCHAR(255), 
	"cfsuite1__External_CSS__c" VARCHAR(255), 
	"cfsuite1__Find_Other_Council_Services_Text__c" VARCHAR(255), 
	"cfsuite1__Forgot_Password_Confirm_Link__c" VARCHAR(255), 
	"cfsuite1__Forgot_Password_Link__c" VARCHAR(255), 
	"cfsuite1__GenericPostCode__c" VARCHAR(255), 
	"cfsuite1__GoogleAPIkey__c" VARCHAR(255), 
	"cfsuite1__Help_Available_URL__c" VARCHAR(255), 
	"cfsuite1__Hide_On_Behalf_Address__c" VARCHAR(255), 
	"cfsuite1__ImageryLayerURL__c" VARCHAR(255), 
	"cfsuite1__Imagery_Layer_Type__c" VARCHAR(255), 
	"cfsuite1__In_Progress_Status__c" VARCHAR(255), 
	"cfsuite1__Internal_Default_Origin__c" VARCHAR(255), 
	"cfsuite1__Knowledge_Component_Name__c" VARCHAR(255), 
	"cfsuite1__Location_Btn_Hvr_Colour__c" VARCHAR(255), 
	"cfsuite1__Location_Button_Colour__c" VARCHAR(255), 
	"cfsuite1__Logo_Name__c" VARCHAR(255), 
	"cfsuite1__Map_Pin_Images_URL_Community__c" VARCHAR(255), 
	"cfsuite1__Map_Pin_Images_URL__c" VARCHAR(255), 
	"cfsuite1__Matched_User_Error__c" VARCHAR(255), 
	"cfsuite1__MaxFileExternal__c" VARCHAR(255), 
	"cfsuite1__MaxFileInternal__c" VARCHAR(255), 
	"cfsuite1__MaxPaymentLimit__c" VARCHAR(255), 
	"cfsuite1__Max_File_Size_MB__c" VARCHAR(255), 
	"cfsuite1__MinPaymentLimit__c" VARCHAR(255), 
	"cfsuite1__Multi_Council_Login_Suffix__c" VARCHAR(255), 
	"cfsuite1__My_Foll_Requests_URL__c" VARCHAR(255), 
	"cfsuite1__My_Questions_URL__c" VARCHAR(255), 
	"cfsuite1__My_Requests_Page_Banner_Title__c" VARCHAR(255), 
	"cfsuite1__My_Requests_URL__c" VARCHAR(255), 
	"cfsuite1__NewLine__c" VARCHAR(255), 
	"cfsuite1__On_Behalf_Of_Text__c" VARCHAR(255), 
	"cfsuite1__Open_Status__c" VARCHAR(255), 
	"cfsuite1__Outgoing_Email_From__c" VARCHAR(255), 
	"cfsuite1__ParcelAddrAttrText__c" VARCHAR(255), 
	"cfsuite1__ParcelAddrPostcodeField__c" VARCHAR(255), 
	"cfsuite1__ParcelFullAddrAttrText__c" VARCHAR(255), 
	"cfsuite1__ParcelLayerDistanceField__c" VARCHAR(255), 
	"cfsuite1__ParcelLayerPopupTemplate__c" VARCHAR(255), 
	"cfsuite1__ParcelLayerSearchField1__c" VARCHAR(255), 
	"cfsuite1__ParcelLayerSearchField2__c" VARCHAR(255), 
	"cfsuite1__ParcelLayerSearchTemplate__c" VARCHAR(255), 
	"cfsuite1__ParcelLayerSuggestionTemplate__c" VARCHAR(255), 
	"cfsuite1__ParcelLayerUnitField__c" VARCHAR(255), 
	"cfsuite1__ParcelNumberAttrText__c" VARCHAR(255), 
	"cfsuite1__Parcel_Centroid_Label_Field__c" VARCHAR(255), 
	"cfsuite1__Parcel_Council_Name__c" VARCHAR(255), 
	"cfsuite1__Parcel_Street_Name_Field__c" VARCHAR(255), 
	"cfsuite1__Parcel_Suburb_Field__c" VARCHAR(255), 
	"cfsuite1__ParcelsCenLayerName__c" VARCHAR(255), 
	"cfsuite1__ParcelsCenLayerURL__c" VARCHAR(255), 
	"cfsuite1__ParcelsLayerName__c" VARCHAR(255), 
	"cfsuite1__ParcelsLayerURL__c" VARCHAR(255), 
	"cfsuite1__Payment_Event_Type__c" VARCHAR(255), 
	"cfsuite1__Phone_Number_Title__c" VARCHAR(255), 
	"cfsuite1__Profile_Page_Banner_Title__c" VARCHAR(255), 
	"cfsuite1__Profile_Redirect_URL__c" VARCHAR(255), 
	"cfsuite1__Property_Alert_Msg__c" VARCHAR(255), 
	"cfsuite1__Property_Cust_Sup_Msg__c" VARCHAR(255), 
	"cfsuite1__Property_Match_Type__c" VARCHAR(255), 
	"cfsuite1__Property_NAR_Delimeter__c" VARCHAR(255), 
	"cfsuite1__Radius__c" VARCHAR(255), 
	"cfsuite1__RecaptchaSiteKey__c" VARCHAR(255), 
	"cfsuite1__Recat_Default_Lat__c" VARCHAR(255), 
	"cfsuite1__Recat_Default_Lon__c" VARCHAR(255), 
	"cfsuite1__Recat_Default_Request_Location__c" VARCHAR(255), 
	"cfsuite1__Report_Request_Service_Text__c" VARCHAR(255), 
	"cfsuite1__Reporting_Batch_Email__c" VARCHAR(255), 
	"cfsuite1__Reporting_Batch_ReplyTo__c" VARCHAR(255), 
	"cfsuite1__Reporting_Batch_Size__c" VARCHAR(255), 
	"cfsuite1__RequestWizardThankYouDocId__c" VARCHAR(255), 
	"cfsuite1__Request_Detail_Error_Message__c" VARCHAR(255), 
	"cfsuite1__Request_Location__c" VARCHAR(255), 
	"cfsuite1__Request_Submit_Page_Banner_Title__c" VARCHAR(255), 
	"cfsuite1__Request_Submit_URL__c" VARCHAR(255), 
	"cfsuite1__Requests_URL__c" VARCHAR(255), 
	"cfsuite1__Require_Files_Name_Change__c" VARCHAR(255), 
	"cfsuite1__ReserveAddrField__c" VARCHAR(255), 
	"cfsuite1__ReserveLayerDistanceField__c" VARCHAR(255), 
	"cfsuite1__ReserveLayerOutputFields__c" VARCHAR(255), 
	"cfsuite1__ReserveLayerPopupTemplate__c" VARCHAR(255), 
	"cfsuite1__ReserveLayerSearchField1__c" VARCHAR(255), 
	"cfsuite1__ReserveLayerSearchField2__c" VARCHAR(255), 
	"cfsuite1__ReserveLayerSearchTemplate__c" VARCHAR(255), 
	"cfsuite1__ReserveLayerSuggestionTemplate__c" VARCHAR(255), 
	"cfsuite1__ReserveLayerUnitField__c" VARCHAR(255), 
	"cfsuite1__ReserveNameAttrText__c" VARCHAR(255), 
	"cfsuite1__Reserve_Council_Name__c" VARCHAR(255), 
	"cfsuite1__ReservesLayerName__c" VARCHAR(255), 
	"cfsuite1__ReservesLayerURL__c" VARCHAR(255), 
	"cfsuite1__ReservesPostCode__c" VARCHAR(255), 
	"cfsuite1__Reserves_Street_Name_Field__c" VARCHAR(255), 
	"cfsuite1__Reserves_Suburb_Field__c" VARCHAR(255), 
	"cfsuite1__Reset_Password_Confirmation_Email__c" VARCHAR(255), 
	"cfsuite1__Reset_Password_Email_Template__c" VARCHAR(255), 
	"cfsuite1__Reset_Password_Link__c" VARCHAR(255), 
	"cfsuite1__Reset_password_org_wide_email_address__c" VARCHAR(255), 
	"cfsuite1__Restrict_Outside_Area_Cases__c" VARCHAR(255), 
	"cfsuite1__Revised_SLA_Label__c" VARCHAR(255), 
	"cfsuite1__SLA_Label__c" VARCHAR(255), 
	"cfsuite1__SMS_Account_Name__c" VARCHAR(255), 
	"cfsuite1__SMS_Callback_URL__c" VARCHAR(255), 
	"cfsuite1__SMS_Request_Completed__c" VARCHAR(255), 
	"cfsuite1__SMS_Request_Confirmation__c" VARCHAR(255), 
	"cfsuite1__SMS_Request_On_Hold__c" VARCHAR(255), 
	"cfsuite1__SMS_Request_Update__c" VARCHAR(255), 
	"cfsuite1__SMS_Sub_Account_Id__c" VARCHAR(255), 
	"cfsuite1__Scheduled_Entitlement_Batch_Size__c" VARCHAR(255), 
	"cfsuite1__Show_More_Topics_Title__c" VARCHAR(255), 
	"cfsuite1__SiteName__c" VARCHAR(255), 
	"cfsuite1__Site_Down_Msg_Content__c" VARCHAR(255), 
	"cfsuite1__Site_URL__c" VARCHAR(255), 
	"cfsuite1__Space__c" VARCHAR(255), 
	"cfsuite1__StartLat__c" VARCHAR(255), 
	"cfsuite1__StartLon__c" VARCHAR(255), 
	"cfsuite1__Suppressed_Customer_Alert__c" VARCHAR(255), 
	"cfsuite1__Suppressed_Customer_Queue_Name__c" VARCHAR(255), 
	"cfsuite1__System_Administrator__c" VARCHAR(255), 
	"cfsuite1__Thank_You_Page_Component__c" VARCHAR(255), 
	"cfsuite1__Thankyou_Page_Image_Dest__c" VARCHAR(255), 
	"cfsuite1__Thankyou_Page_Image_URL__c" VARCHAR(255), 
	"cfsuite1__Track_Progress_URL__c" VARCHAR(255), 
	"cfsuite1__TransportLayerURL__c" VARCHAR(255), 
	"cfsuite1__Update_Case_On_Category_Change__c" VARCHAR(255), 
	"cfsuite1__Update_Details_Case_Category__c" VARCHAR(255), 
	"cfsuite1__Update_Details_Case_Queue_Name__c" VARCHAR(255), 
	"cfsuite1__Update_Details_Case_RT__c" VARCHAR(255), 
	"cfsuite1__Update_Details_Case_Reason__c" VARCHAR(255), 
	"cfsuite1__Use_Custom_Salutations__c" VARCHAR(255), 
	"cfsuite1__User_Type_CspLitePortal__c" VARCHAR(255), 
	"cfsuite1__Visual_Force_Domain__c" VARCHAR(255), 
	"cfsuite1__WO_ClosedStatus__c" VARCHAR(255), 
	"cfsuite1__WO_Confid_Sup_Alert_Msg__c" VARCHAR(255), 
	"cfsuite1__WO_Confid_Sup_Msg__c" VARCHAR(255), 
	"cfsuite1__WO_Confidential_Msg__c" VARCHAR(255), 
	"cfsuite1__WO_NextStep__c" VARCHAR(255), 
	"cfsuite1__WO_Sup_Alert_Msg__c" VARCHAR(255), 
	"cfsuite1__WO_Sup_No_Alert_Msg__c" VARCHAR(255), 
	"cfsuite1__WorkOrderPrefix__c" VARCHAR(255), 
	"cfsuite1__Work_Order_Approved_Category__c" VARCHAR(255), 
	PRIMARY KEY (id)
);
INSERT INTO "cfsuite1__CFSuiteSettings__c" VALUES('cfsuite1__CFSuiteSettings__c-1','a04Ho00000mGjR5','','','Additional Location Information','ADDRESS','','OBJECTID','PWREF','postcode','','state','street_name','street_number','street_type','suburb','unit','ADDRESS','Please contact your Council to update your address, first name or last name..','Emergency after-hours call','','','doc,dot,docx,docm,dotx,dotm,docb,xls,xlt,xlm,xlsx,xlsm,xltx,xltm,xlsb,xlw,csv,pdf,gif,png,jpg,jpeg,heif,heic,msg,tr5,snote','','https://services-ap1.arcgis.com/cmnuxM68Lj3cF6UZ/arcgis/rest/services/Filtered_LGA_View_Adelaide/FeatureServer','/s/article/','','open','full_address','Descriptio','*','{Descriptio} {full_address}','Descriptio','full_address','{Description} {Building_Address}','{Descriptio} {full_address}','Asset_ID__','Postcode','','buildingsLayer','https://services-ap1.arcgis.com/cmnuxM68Lj3cF6UZ/arcgis/rest/services/Monuments_Adelaide_City_Council/FeatureServer','Roadname_a','','10','busStopLayer','*','{Stop_Numbe} {Roadname_a}','Stop_Numbe','','{Stop_name}','{Stop_Numbe} {Roadname_a}','https://services-ap1.arcgis.com/cmnuxM68Lj3cF6UZ/arcgis/rest/services/Bus_Stops/FeatureServer','meters','NAME','Postcode','Roadname_a','','','Business hours call','8.0','Yes','This Case Record Is Confidential And Has A Suppressed Customer Who Also Has An Alert.','This Case Record Is Confidential And Has A Suppressed Customer','Confidential','3-5 Business Days','1 business day','','/s/case-details','3','This Case Record Is Not Confidential, Has a Suppressed Customer who also has an Alert.','This Case Record Is Not Confidential But Has a Suppressed Customer','Yes','Job Complete;Referred to External Party;Referred to other council;Work Not Undertaken;Closed in Customer Favour;Closed in Council Favour;Closed','https://cfsuite-r30-tso.my.site.com/CustomCommunityLogin','Confirm you want to unfollow this request','My Followed Request','My Request','005Ho000009OcBF','','CFSuite Community Login User','','Community Portal','Customer Community Login User','/s/','','10','approved,not approved,work not undertaken,job complete','','','myCouncil','','CFSuite Councillor Login User','2021-12-21T12:00:00.000+0000','/s/councillor-requests','/createAccount','','Customer Alert','Mr.;Ms.;Mrs.;Dr.;Prof.;EST','Suppressed','Suppressed','','','','15','15','','','','','','','Yes','No','No','','','','An active agent is already associated with this property','.3','','','','Find other Council Services','/CustomCommunityForgotPasswordConfirm','/login/ForgotPassword','postcode','','','No','https://sampleserver6.arcgisonline.com/arcgis/rest/services/NLCDLandCover2001/ImageServer','wms','in progress,assessing,assigned,on hold','','c:categoryKnowledge','#0a4184','#0b4892','','/resource/cfsuite1__PinImages','/resource/cfsuite1__PinImages','Our system shows you already have an account, please Login','','','','100.0','','','/s/my-followed-requests','/s/my-questions','','/s/my-requests','','Provide contact details of the community member to keep them informed on case progress','Work Not Undertaken,Referred to Other Council,Not Council Owned,In Progress,Referred To Extenal Party,On Hold','','Parcel_Address','postcode','ADDRESS','1','{ADDRESS}','ADDRESS','ADDRESS','{ADDRESS}','{ADDRESS}','meters','PWREF','PWREF','','street_name','suburb','','https://services-ap1.arcgis.com/cmnuxM68Lj3cF6UZ/arcgis/rest/services/AdelaideCouncilParcel/FeatureServer','','https://services-ap1.arcgis.com/cmnuxM68Lj3cF6UZ/arcgis/rest/services/AdelaideCouncilParcel/FeatureServer','Success','Urgent Requests','','/s/redirect-to-profile','Property Alert','Suppressed Customer','Parcel','~','.3','','-34.926148','138.60049','Adelaide City Council','Additional Location Information','hugh@ennovative.com.au','hugh@ennovative.com.au','40.0','','You are not authorised to view this record unless you are logged in.','Request Location','','/s/request-submit','/s/requests','Yes','full_address','10','''NAME'', ''full_address''','{NAME} {full_address}','NAME','full_address','{Reserve_Name} {Parcel_Address}','{NAME} {full_address}','meters','NAME','','','https://services-ap1.arcgis.com/cmnuxM68Lj3cF6UZ/arcgis/rest/services/Playgrounds_reserves/FeatureServer','Postcode','','','','','/s/resetpasswordlwc','','','RevisedSLA','SLA','Message Media','','','','','','','40.0','Popular report it topics','Site Name for welcome page','We apologies for the inconvenience and hope to have this fixed as soon as possible.','','- : -','-34.926148','138.60049','','Suppressed_Customer','System Administrator','ThankYou','','','','https://server.arcgisonline.com/ArcGIS/rest/services/Reference/World_Transportation/MapServer','Yes','Finance - Update Personal Details','Finance_Rates','Update_Details','Business Name','No','CspLitePortal','vf.force','Job Complete,Not Council Owned,Referred to Other Council,Referred To External Party,Work Not Undertaken','This WorkOrder Record Is Confidential And Has A Suppressed Customer Who Also Has An Alert.','This WorkOrder Record Is Confidential And Has A Suppressed Customer','This WorkOrder Record is Confidential','Save updates (do not close WO),None,Create Adhoc WO,None - Close Case or leave On Hold','This WorkOrder Record Is Not Confidential, Has a Suppressed Customer who also has an Alert.','This WorkOrder Is Not Confidential But Has a Suppressed Customer','0WO','Rates - Request for Extension: Process Request;Rates - Request for Payment Plan: Process Request');
CREATE TABLE "cfsuite1__CFSuite_Application__c" (
	id VARCHAR(255) NOT NULL, 
	"cfsuite1__Account__c" VARCHAR(255), 
	PRIMARY KEY (id)
);
CREATE TABLE "cfsuite1__CFSuite_Bill_Type_Settings__c" (
	id VARCHAR(255) NOT NULL, 
	"Name" VARCHAR(255), 
	"cfsuite1__Bill_Type__c" VARCHAR(255), 
	"cfsuite1__Bypass_Email_Question__c" VARCHAR(255), 
	"cfsuite1__Case_On_Hold_Text__c" VARCHAR(255), 
	"cfsuite1__Detail_Object_Fields__c" VARCHAR(255), 
	"cfsuite1__Detail_Object_Labels__c" VARCHAR(255), 
	"cfsuite1__Detail_Object__c" VARCHAR(255), 
	"cfsuite1__Display_in_Portal__c" VARCHAR(255), 
	"cfsuite1__Enforce_Last_Name_Check__c" VARCHAR(255), 
	"cfsuite1__On_Hold_Email_Subject__c" VARCHAR(255), 
	PRIMARY KEY (id)
);
CREATE TABLE "cfsuite1__CFSuite_MLG_Community_Link__c" (
	id VARCHAR(255) NOT NULL, 
	"Name" VARCHAR(255), 
	"cfsuite1__Back_Label__c" VARCHAR(255), 
	"cfsuite1__Back_URL__c" VARCHAR(255), 
	"cfsuite1__Title__c" VARCHAR(255), 
	PRIMARY KEY (id)
);
CREATE TABLE "cfsuite1__CFSuite_Map_Layers__c" (
	id VARCHAR(255) NOT NULL, 
	"Name" VARCHAR(255), 
	"cfsuite1__Allow_Without_Asset_Selection__c" VARCHAR(255), 
	"cfsuite1__Case_Fields__c" VARCHAR(255), 
	"cfsuite1__Data_Field__c" VARCHAR(255), 
	"cfsuite1__Default_Zone__c" VARCHAR(255), 
	"cfsuite1__Display_Name__c" VARCHAR(255), 
	"cfsuite1__GIS_Data_Fields__c" VARCHAR(255), 
	"cfsuite1__GIS_Responsibility_field__c" VARCHAR(255), 
	"cfsuite1__Initial_Zoom__c" VARCHAR(255), 
	"cfsuite1__Layer_Fill_Colour__c" VARCHAR(255), 
	"cfsuite1__Layer_Id__c" VARCHAR(255), 
	"cfsuite1__Layer_Type__c" VARCHAR(255), 
	"cfsuite1__Layer_URL__c" VARCHAR(255), 
	"cfsuite1__Max_Results__c" VARCHAR(255), 
	"cfsuite1__Max_Suggestions__c" VARCHAR(255), 
	"cfsuite1__Min_Scale__c" VARCHAR(255), 
	"cfsuite1__Order__c" VARCHAR(255), 
	"cfsuite1__Out_Fields__c" VARCHAR(255), 
	"cfsuite1__Outline_Colour__c" VARCHAR(255), 
	"cfsuite1__Outline_Width__c" VARCHAR(255), 
	"cfsuite1__Planned_Maintenance_Days_in_Future__c" VARCHAR(255), 
	"cfsuite1__Planned_Maintenance_End_Field__c" VARCHAR(255), 
	"cfsuite1__Planned_Maintenance_Message__c" VARCHAR(255), 
	"cfsuite1__Planned_Maintenance_Start_Field__c" VARCHAR(255), 
	"cfsuite1__Resp_Message_Field__c" VARCHAR(255), 
	"cfsuite1__Responsibility_value__c" VARCHAR(255), 
	"cfsuite1__Search_Fields__c" VARCHAR(255), 
	"cfsuite1__Search_Template__c" VARCHAR(255), 
	"cfsuite1__Selection_Error_Message__c" VARCHAR(255), 
	"cfsuite1__Suggestion_Template__c" VARCHAR(255), 
	PRIMARY KEY (id)
);
INSERT INTO "cfsuite1__CFSuite_Map_Layers__c" VALUES('cfsuite1__CFSuite_Map_Layers__c-1','ZoneNorthSouth','False','','ZoneNS','North','ZoneNorthSouth','','','','','ZoneNorthSouth','Zone','https://services-ap1.arcgis.com/cmnuxM68Lj3cF6UZ/ArcGIS/rest/services/Planning_Zones/FeatureServer/0','','','9300.0','0.0','*','','','','','','','','','','','','');
INSERT INTO "cfsuite1__CFSuite_Map_Layers__c" VALUES('cfsuite1__CFSuite_Map_Layers__c-2','Footpaths','False','cfsuite1__AssetId__c;cfsuite1__Surface__c;cfsuite1__Road__c','','','Footpaths','Footpath_I;Material__;Road_Name','Resp','16.0','','Footpaths','Asset','https://services-ap1.arcgis.com/cmnuxM68Lj3cF6UZ/ArcGIS/rest/services/Adelaide_Council_Footpaths/FeatureServer/0','','','9300.0','0.0','*','','','','','','','This footpath is not maintained by council.','Council','Road_Name','Road_Name','Please make a selection from the footpaths displayed to continue.','Road_Name');
CREATE TABLE "cfsuite1__CFSuite_Map_Management__c" (
	id VARCHAR(255) NOT NULL, 
	"Name" VARCHAR(255), 
	"cfsuite1__Status_Group__c" VARCHAR(255), 
	"cfsuite1__Status_Values__c" VARCHAR(255), 
	"cfsuite1__Used_For__c" VARCHAR(255), 
	PRIMARY KEY (id)
);
INSERT INTO "cfsuite1__CFSuite_Map_Management__c" VALUES('cfsuite1__CFSuite_Map_Management__c-1','Assess and Assign','Assess and Assign','Assess and Assign','Filter-AO-Map');
INSERT INTO "cfsuite1__CFSuite_Map_Management__c" VALUES('cfsuite1__CFSuite_Map_Management__c-2','Assigned','Assigned','Assigned','Filter-AO-Map');
INSERT INTO "cfsuite1__CFSuite_Map_Management__c" VALUES('cfsuite1__CFSuite_Map_Management__c-3','In Progress','In Progress','In Progress','Filter-AO-Map');
INSERT INTO "cfsuite1__CFSuite_Map_Management__c" VALUES('cfsuite1__CFSuite_Map_Management__c-4','On Hold','On Hold','On Hold','Filter-AO-Map');
INSERT INTO "cfsuite1__CFSuite_Map_Management__c" VALUES('cfsuite1__CFSuite_Map_Management__c-5','Closed','Closed','Approved,Not Approved,Referred to External Party,Work Not Undertaken,Job Completed','Filter-AO-Map');
CREATE TABLE "cfsuite1__CFSuite_Map__c" (
	id VARCHAR(255) NOT NULL, 
	"Name" VARCHAR(255), 
	"cfsuite1__Color_Code__c" VARCHAR(255), 
	"cfsuite1__Sort_Order__c" VARCHAR(255), 
	"cfsuite1__Status__c" VARCHAR(255), 
	PRIMARY KEY (id)
);
INSERT INTO "cfsuite1__CFSuite_Map__c" VALUES('cfsuite1__CFSuite_Map__c-1','All Status2','Arylide-Yellow.png','3','');
INSERT INTO "cfsuite1__CFSuite_Map__c" VALUES('cfsuite1__CFSuite_Map__c-2','Job Complete','green.png','1','Job Complete');
INSERT INTO "cfsuite1__CFSuite_Map__c" VALUES('cfsuite1__CFSuite_Map__c-3','MapPin7','Iguana-Green.png','7','');
INSERT INTO "cfsuite1__CFSuite_Map__c" VALUES('cfsuite1__CFSuite_Map__c-4','MapPin3','water.png','3','');
INSERT INTO "cfsuite1__CFSuite_Map__c" VALUES('cfsuite1__CFSuite_Map__c-5','MapPin6','Jordy-Blue.png','6','');
INSERT INTO "cfsuite1__CFSuite_Map__c" VALUES('cfsuite1__CFSuite_Map__c-6','MapPin8','North_Sea','8','');
INSERT INTO "cfsuite1__CFSuite_Map__c" VALUES('cfsuite1__CFSuite_Map__c-7','All Statuses','trees.png','2','');
INSERT INTO "cfsuite1__CFSuite_Map__c" VALUES('cfsuite1__CFSuite_Map__c-8','MapPin4','inprogress.png','4','');
INSERT INTO "cfsuite1__CFSuite_Map__c" VALUES('cfsuite1__CFSuite_Map__c-9','MapPin1','duplicate.png','1','');
INSERT INTO "cfsuite1__CFSuite_Map__c" VALUES('cfsuite1__CFSuite_Map__c-10','MapPin9','Royal-Orange.png','9','');
INSERT INTO "cfsuite1__CFSuite_Map__c" VALUES('cfsuite1__CFSuite_Map__c-11','MapPin2','green.png','2','job complete');
INSERT INTO "cfsuite1__CFSuite_Map__c" VALUES('cfsuite1__CFSuite_Map__c-12','MapPin5','purple.png','5','');
CREATE TABLE "cfsuite1__CFSuite_Message_Folder__c" (
	id VARCHAR(255) NOT NULL, 
	"Name" VARCHAR(255), 
	"cfsuite1__Tag__c" VARCHAR(255), 
	PRIMARY KEY (id)
);
CREATE TABLE "cfsuite1__CFSuite_Preferred_Comms_Config__c" (
	id VARCHAR(255) NOT NULL, 
	"Name" VARCHAR(255), 
	"RecordTypeId" VARCHAR(255), 
	"cfsuite1__Active__c" VARCHAR(255), 
	"cfsuite1__Attachment_Ids__c" VARCHAR(255), 
	"cfsuite1__Case_Reason__c" VARCHAR(255), 
	"cfsuite1__Case_Sub_Reason__c" VARCHAR(255), 
	"cfsuite1__Council__c" VARCHAR(255), 
	"cfsuite1__Description__c" VARCHAR(255), 
	"cfsuite1__Email_Template_Id__c" VARCHAR(255), 
	"cfsuite1__Events__c" VARCHAR(255), 
	"cfsuite1__Excluded_Categories__c" VARCHAR(255), 
	"cfsuite1__From_email_Address_Id__c" VARCHAR(255), 
	"cfsuite1__Included_Categories__c" VARCHAR(255), 
	"cfsuite1__Interested_Party_Email_Template__c" VARCHAR(255), 
	"cfsuite1__Interested_Party_SMS_Template__c" VARCHAR(255), 
	"cfsuite1__Internal_Email_Template_Id__c" VARCHAR(255), 
	"cfsuite1__Internal_SMS_Template_Id__c" VARCHAR(255), 
	"cfsuite1__Internal_To_Address__c" VARCHAR(255), 
	"cfsuite1__Object_API_Name__c" VARCHAR(255), 
	"cfsuite1__Reasons__c" VARCHAR(255), 
	"cfsuite1__Record_Type_Names__c" VARCHAR(255), 
	"cfsuite1__SMS_Template__c" VARCHAR(255), 
	"cfsuite1__SMS_Track_Replies__c" VARCHAR(255), 
	"cfsuite1__SMS_Track_Status__c" VARCHAR(255), 
	"cfsuite1__Status__c" VARCHAR(255), 
	"cfsuite1__Zone__c" VARCHAR(255), 
	PRIMARY KEY (id)
);
INSERT INTO "cfsuite1__CFSuite_Preferred_Comms_Config__c" VALUES('cfsuite1__CFSuite_Preferred_Comms_Config__c-1','ID006: On Hold (Other):CS','012O5000006qu7gIAA','True','','','','','Send notification if for all on HOLDs','CS_On_Hold_Customer_Other','Create;Update','','ADD Ord Wide Email Id','','CS_AA_On_Hold_Interested_Party','','','CS_On Hold - Interested Party (Other)','','Case','Other;','Investigation;Perform Works;Request New;Standard Request;Assess Assign;Application;Councillor Question;','SMS CS - On Hold - Customer (Other)','False','False','On Hold','');
INSERT INTO "cfsuite1__CFSuite_Preferred_Comms_Config__c" VALUES('cfsuite1__CFSuite_Preferred_Comms_Config__c-2','ID007: Closed - Referred To External:CS','012O5000006qu7gIAA','True','','','','','Configuration for Status = Referred to External Party for all WO record types.','CS_All_Referred_to_External_Customer','Create;Update','','ADD Ord Wide Email Id','','CS_All_Referred_to_External_Interested_Party','','','CS_Closed - Referred to External - Interested Party/Interested Party (Other)','','Case','PA;NBN;Ombudsman;Primary Industries;RFS;RMS;NSW Police;
Water NSW;Railcorp;Sydney Water;Safework NSW;Telstra;
Transport NSW;State Rail Authority;NSW Food Authority;
NSW Health;','Investigation;Perform Works;Request New;Standard Request;Assess Assign;Application;Councillor Question;','SMS Closed - Referred to External - Customer','False','False','Referred To External Party','');
INSERT INTO "cfsuite1__CFSuite_Preferred_Comms_Config__c" VALUES('cfsuite1__CFSuite_Preferred_Comms_Config__c-3','ID008: Closed - Referred To External (Other):CS','012O5000006qu7gIAA','True','','','','','Configuration for Status = Referred to External Party for all Case record types.','CS_AA_PW_Referred_to_External_Customer_Other','Create;Update','','ADD Ord Wide Email Id','','CS_All_Referred_to_External_Interested_Party','','','CS_Closed - Referred to External - Interested Party/Interested Party (Other)','','Case','Other;','Investigation;Perform Works;Request New;Standard Request;Assess Assign;Application;Councillor Question;','SMS Closed - Referred to External - Customer (Other)','False','False','Referred To External Party','');
INSERT INTO "cfsuite1__CFSuite_Preferred_Comms_Config__c" VALUES('cfsuite1__CFSuite_Preferred_Comms_Config__c-4','ID009: Closed - Referred to Other Council:CS','012O5000006qu7gIAA','True','','','','','Configuration for Status = Referred to Other Council for all Case record types.','CS_All_Referred_to_Other_Council_Customer','Create;Update','','ADD Ord Wide Email Id','','CS_All_Referred_to_Other_Council_Interested_Party','','','CS_Closed - Referred to Other Council - Interested Party/Interest Party (Other)','','Case','Camden;Campbelltown;Wingecaribee;','Investigation;Perform Works;Request New;Standard Request;Assess Assign;Application;Councillor Question;','SMS Closed - Referred to Other Council - Customer','False','False','Referred to Other Council','');
INSERT INTO "cfsuite1__CFSuite_Preferred_Comms_Config__c" VALUES('cfsuite1__CFSuite_Preferred_Comms_Config__c-5','ID010: Closed - Referred to Other Council (Other):CS','012O5000006qu7gIAA','True','','','','','Configuration for Status = Referred to Other Council for all Case record types.','CS_AA_PW_Referred_to_Other_Council_Customer_Other','Create;Update','','ADD Ord Wide Email Id','','CS_All_Referred_to_Other_Council_Interested_Party','','','CS_Closed - Referred to Other Council - Interested Party/Interest Party (Other)','','Case','Other;','Investigation;Perform Works;Request New;Standard Request;Assess Assign;Application;Councillor Question;','SMS Closed - Referred to Other Council - Customer (Other)','False','False','Referred to Other Council','');
INSERT INTO "cfsuite1__CFSuite_Preferred_Comms_Config__c" VALUES('cfsuite1__CFSuite_Preferred_Comms_Config__c-6','ID011: Work Not Undertaken (Incorrect Case Category):CS','012O5000006qu7gIAA','True','','','','','Sends a message when Status = ''Work Not Undertaken'' and Reason = ''Incorrect Request Category''.','CS_Work_Not_Undertaken_Incorrect_Category_Customer','Create;Update','','ADD Ord Wide Email Id','','','','','','','Case','Incorrect Request Category','Investigation;Perform Works;Request New;Standard Request;Assess Assign;Application;Councillor Question;','SMS Closed - Work Not Undertaken - Customer (Incorrect Category)','False','False','Work Not Undertaken','');
INSERT INTO "cfsuite1__CFSuite_Preferred_Comms_Config__c" VALUES('cfsuite1__CFSuite_Preferred_Comms_Config__c-7','ID012: Closed - Work Not Undertaken:CS','012O5000006qu7gIAA','True','','','','','Configuration for Status = Work not Undertaken for all Case record types.','CS_All_Work_Not_Undertaken_Customer','Create;Update','','ADD Ord Wide Email Id','','CS_All_Work_Not_Undertaken_Interested_Party','','','CS_Closed - Work Not Undertaken - Interested Party','','Case','Current State of Asset meets Requirements/Regulations;
Work has been added to the Priority Works Program;
Not Council Land;Not a Council Asset;Not a Council Road;
Owner''s Responsibility to Maintain;Unable to Locate;
Unable to Repair;Withdrawn by Applicant;
Vehicle is registered;Not Abandoned;Owner''s Responsibility;Withdrawn by Applicant;Representation Received;','Investigation;Perform Works;Request New;Standard Request;Assess Assign;Application;Councillor Question;','SMS Closed - Work Not Undertaken - Customer','False','False','Work Not Undertaken','');
INSERT INTO "cfsuite1__CFSuite_Preferred_Comms_Config__c" VALUES('cfsuite1__CFSuite_Preferred_Comms_Config__c-8','ID013: Closed - Work Not Undertaken (Other):CS','012O5000006qu7gIAA','True','','','','','Configuration for Status = Work not Undertaken for all WO record types.','CS_AA_PW_Work_Not_Undertaken_Customer_Other','Create;Update','','ADD Ord Wide Email Id','','CS_All_Work_Not_Undertaken_Interested_Party','','','CS_e	Closed - Work Not Undertaken - Interested Party','','Case','Other;','Investigation;Perform Works;Request New;Standard Request;Assess Assign;Application;Councillor Question;','SMS Closed - Work Not Undertaken - Customer (Other)','False','False','Work Not Undertaken','');
INSERT INTO "cfsuite1__CFSuite_Preferred_Comms_Config__c" VALUES('cfsuite1__CFSuite_Preferred_Comms_Config__c-9','ID005: On Hold:CS','012O5000006qu7gIAA','True','','','','','Send notification if for all on HOLDs','CS_AA_On_Hold_Customer','Create;Update','','ADD Ord Wide Email Id','','CS_AA_On_Hold_Interested_Party','','','CS_On Hold - Interested Party','','Case','Awaiting Contractor;Awaiting Equipment;Awaiting External Party;Awaiting Reinspection;Customer to Provide further Information;NISO Issued - resubmit;Obstruction/Not Accessible;Order Issued - resumbit;PIN Issued - non Compliance;Removed for Repair;Weather;Work has been added to the Priority Works Program;Works have been Programmed;','Investigation;Perform Works;Request New;Standard Request;Assess Assign;Application;Councillor Question;','SMS CS - On Hold - Customer','False','False','On Hold','');
INSERT INTO "cfsuite1__CFSuite_Preferred_Comms_Config__c" VALUES('cfsuite1__CFSuite_Preferred_Comms_Config__c-10','ID002: Assess & Assign:CS','012O5000006qu7gIAA','True','','','','','Sends a message when AA Case is created.','CS_Assess_Assign','Create','','ADD Ord Wide Email Id','','CS_AA_Interested_Party','','','CS_Assess & Assign - Interested Party','','Case','','Investigation;Perform Works;Request New;Standard Request;Assess Assign;Application;Councillor Question;','SMS CS - Assess & Assign - Customer','False','False','Assess and Assign','');
INSERT INTO "cfsuite1__CFSuite_Preferred_Comms_Config__c" VALUES('cfsuite1__CFSuite_Preferred_Comms_Config__c-11','ID003: Assigned:CS','012O5000006qu7gIAA','True','','','','','Sends a message when Case is assigned','CS_Assigned_Customer','Create;Update','','ADD Ord Wide Email Id','','CS_Assigned_Interested_Party','','','CS_Assigned - Interested Party','','Case','','Investigation;Perform Works;Request New;Standard Request;Assess Assign;Application;Councillor Question;','SMS CS - Assigned - Customer','False','False','Assigned','');
INSERT INTO "cfsuite1__CFSuite_Preferred_Comms_Config__c" VALUES('cfsuite1__CFSuite_Preferred_Comms_Config__c-12','ID004: Closed - Completed:CS','012O5000006qu7gIAA','True','','','','','Configuration for Status = Job Complete for PW only (excluding Request New).','CS_Completed_Customer','Create;Update','','ADD Ord Wide Email Id','','CS_Completed_Interested_Party','','','CS_Closed - Completed - Interested Party','','Case','Work Complete;Other;','Investigation;Perform Works;Standard Request;Assess Assign;Application;','SMS CS - Closed - Completed - Customer','False','False','Job Complete','');
CREATE TABLE "cfsuite1__CFSuite_Preferred_Comms_Config__c_rt_mapping" (
	record_type_id VARCHAR(18) NOT NULL, 
	developer_name VARCHAR(255), 
	is_person_type BOOLEAN, 
	PRIMARY KEY (record_type_id)
);
INSERT INTO "cfsuite1__CFSuite_Preferred_Comms_Config__c_rt_mapping" VALUES('012O5000006qu7gIAA','Customer_Notification',0);
INSERT INTO "cfsuite1__CFSuite_Preferred_Comms_Config__c_rt_mapping" VALUES('012O5000006qu7hIAA','Emergency_Notification',0);
CREATE TABLE "cfsuite1__CFSuite_Product__c" (
	id VARCHAR(255) NOT NULL, 
	"Name" VARCHAR(255), 
	"cfsuite1__Active__c" VARCHAR(255), 
	"cfsuite1__Additional_Fee__c" VARCHAR(255), 
	"cfsuite1__Additional_Information__c" VARCHAR(255), 
	"cfsuite1__Category__c" VARCHAR(255), 
	"cfsuite1__Community_Name__c" VARCHAR(255), 
	"cfsuite1__End_Date__c" VARCHAR(255), 
	"cfsuite1__GL_Code__c" VARCHAR(255), 
	"cfsuite1__GST_Condition__c" VARCHAR(255), 
	"cfsuite1__GST__c" VARCHAR(255), 
	"cfsuite1__Price__c" VARCHAR(255), 
	"cfsuite1__Reason__c" VARCHAR(255), 
	"cfsuite1__Start_Date__c" VARCHAR(255), 
	"cfsuite1__Sub_Reason__c" VARCHAR(255), 
	PRIMARY KEY (id)
);
CREATE TABLE "cfsuite1__CFSuite_Request_Flow__c" (
	id VARCHAR(255) NOT NULL, 
	"Name" VARCHAR(255), 
	"RecordTypeId" VARCHAR(255), 
	"cfsuite1__AMS_Code__c" VARCHAR(255), 
	"cfsuite1__Additional_Reason__c" VARCHAR(255), 
	"cfsuite1__Animal_Description__c" VARCHAR(255), 
	"cfsuite1__Asset_Layer_Id__c" VARCHAR(255), 
	"cfsuite1__Assignment_Field__c" VARCHAR(255), 
	"cfsuite1__Assignment_Value__c" VARCHAR(255), 
	"cfsuite1__Attribute_1__c" VARCHAR(255), 
	"cfsuite1__Attribute_2__c" VARCHAR(255), 
	"cfsuite1__Attribute_3__c" VARCHAR(255), 
	"cfsuite1__Case_Category__c" VARCHAR(255), 
	"cfsuite1__Case_Note_Text_Template__c" VARCHAR(255), 
	"cfsuite1__Case_Owner__c" VARCHAR(255), 
	"cfsuite1__Case_Record_Type_Developer_Name__c" VARCHAR(255), 
	"cfsuite1__Case_Status__c" VARCHAR(255), 
	"cfsuite1__Case_Zone__c" VARCHAR(255), 
	"cfsuite1__Category_Icon__c" VARCHAR(255), 
	"cfsuite1__Category_Type__c" VARCHAR(255), 
	"cfsuite1__Classification__c" VARCHAR(255), 
	"cfsuite1__Close_Parent_WO__c" VARCHAR(255), 
	"cfsuite1__Confidential__c" VARCHAR(255), 
	"cfsuite1__Council__c" VARCHAR(255), 
	"cfsuite1__Create_Work_Order__c" VARCHAR(255), 
	"cfsuite1__Deflection_Text__c" VARCHAR(255), 
	"cfsuite1__Department__c" VARCHAR(255), 
	"cfsuite1__Display_Case_Note_Template__c" VARCHAR(255), 
	"cfsuite1__Division_Portfolio__c" VARCHAR(255), 
	"cfsuite1__Duplicate_Work_Categories__c" VARCHAR(255), 
	"cfsuite1__Emergency_Notification__c" VARCHAR(255), 
	"cfsuite1__Emergency__c" VARCHAR(255), 
	"cfsuite1__Enable_Staff_Notifications_Assign__c" VARCHAR(255), 
	"cfsuite1__Enable_Staff_Notifications_Create__c" VARCHAR(255), 
	"cfsuite1__Entitlement_Process_Name__c" VARCHAR(255), 
	"cfsuite1__Equipment__c" VARCHAR(255), 
	"cfsuite1__File_Sync__c" VARCHAR(255), 
	"cfsuite1__Flow_Name__c" VARCHAR(255), 
	"cfsuite1__Form_Type__c" VARCHAR(255), 
	"cfsuite1__GDS_Code__c" VARCHAR(255), 
	"cfsuite1__Hazard_SLA__c" VARCHAR(255), 
	"cfsuite1__Help_Text__c" VARCHAR(255), 
	"cfsuite1__Is_Closed__c" VARCHAR(255), 
	"cfsuite1__Is_Hidden_From_Community__c" VARCHAR(255), 
	"cfsuite1__Is_Hidden_From_Map__c" VARCHAR(255), 
	"cfsuite1__Is_Hidden_From_Map_and_Case_Details__c" VARCHAR(255), 
	"cfsuite1__Is_Primary__c" VARCHAR(255), 
	"cfsuite1__My_Request_Button_Flow__c" VARCHAR(255), 
	"cfsuite1__My_Request_Button_Name__c" VARCHAR(255), 
	"cfsuite1__New_Record_Type_Developer_Name__c" VARCHAR(255), 
	"cfsuite1__New_Status__c" VARCHAR(255), 
	"cfsuite1__Next_Steps__c" VARCHAR(255), 
	"cfsuite1__Notify_After_Hours__c" VARCHAR(255), 
	"cfsuite1__Pin_Image__c" VARCHAR(255), 
	"cfsuite1__Popular_For_Groups__c" VARCHAR(255), 
	"cfsuite1__Reason_Not_Equal__c" VARCHAR(255), 
	"cfsuite1__Record_Type_Developer_Name__c" VARCHAR(255), 
	"cfsuite1__Request_Reason__c" VARCHAR(255), 
	"cfsuite1__Request_Sub_Reason__c" VARCHAR(255), 
	"cfsuite1__Require_Customer__c" VARCHAR(255), 
	"cfsuite1__Restricted_Page_Access__c" VARCHAR(255), 
	"cfsuite1__Roads_Description__c" VARCHAR(255), 
	"cfsuite1__SLA__c" VARCHAR(255), 
	"cfsuite1__SWMS_Code__c" VARCHAR(255), 
	"cfsuite1__Search_Tag__c" VARCHAR(255), 
	"cfsuite1__Skip_Duplicate_Check__c" VARCHAR(255), 
	"cfsuite1__Subject_Line_Override__c" VARCHAR(255), 
	"cfsuite1__Team__c" VARCHAR(255), 
	"cfsuite1__Update_Case_Team_Details__c" VARCHAR(255), 
	"cfsuite1__Update_Case__c" VARCHAR(255), 
	"cfsuite1__Vehicle_Description__c" VARCHAR(255), 
	"cfsuite1__WO_Record_Type_Developer_Name__c" VARCHAR(255), 
	"cfsuite1__WO_Src_Category__c" VARCHAR(255), 
	"cfsuite1__WO_Src_Record_Type_Developer_Name__c" VARCHAR(255), 
	"cfsuite1__Work_Order_Action__c" VARCHAR(255), 
	"cfsuite1__Work_Order_Category__c" VARCHAR(255), 
	"cfsuite1__Work_Order_Hazard_SLA__c" VARCHAR(255), 
	"cfsuite1__Work_Order_Queue__c" VARCHAR(255), 
	"cfsuite1__Work_Order_Status__c" VARCHAR(255), 
	"cfsuite1__Zone_Layer_Id__c" VARCHAR(255), 
	"cfsuite1__cfReq_Work_Category__c" VARCHAR(255), 
	"cfsuite1__is_Hidden_From_Internal_Staff__c" VARCHAR(255), 
	"cfsuite1__Category_Journey__c" VARCHAR(255), 
	"cfsuite1__Display_Category__c" VARCHAR(255), 
	PRIMARY KEY (id)
);
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-1','CJ - Animals - Dog and Cat - Unauthorised Breeder','012O5000006qu7kIAA','','','False','','','','','','','Animals','Where is the property?



What evidence do you have of animals being sold?



Is this the first instance? (Provide evidence of previous instances)



What contact has already been made? (If Board is reporting) 



What is your name and contact details?','Community_Compliance','Standard_Request_Initial','Assess and Assign','','','','','False','False','','False','','Environmental Health and Community Compliance','True','City Development','','No','No','True','True','Community Compliance','','False','','Map','','1','','False','True','False','True','True','','','Investigation','Assess and Assign','','','other.png','','False','','Dog','Unauthorised Breeder','True','False','False','1','','','False','','Community Compliance','True','True','False','','','','Update','','','','','','Animals - Dog and Cat - Unauthorised Breeder','False','','cfsuite1__CFSuite_Request_Flow__c-10');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-2','CA - Animals - Dog - Noise','012O5000006qu7iIAA','','','False','','','','','','','Animals','','Community Compliance','Investigation','Assess and Assign','','','','','False','False','','False','<table class="ql-table-blob" style="width: 161pt;" width="214"><colgroup><col width="214" style="width: 161pt;"></col></colgroup><tbody><tr height="36" style="height: 27pt;"><td colspan="1" rowspan="1" width="214" height="36" style="padding-top: 1px; padding-right: 1px; padding-left: 1px; font-size: 11pt; font-family: Calibri; border: none; width: 161pt; height: 27pt;">https://www.google.com</td></tr></tbody></table><p><br></p>','Environmental Health and Community Compliance','False','City Development','','No','No','True','True','','','False','','Deflection','','60','','False','True','False','True','True','','','Investigation','Assess and Assign','','','other.png','','False','','Dog','Noise','True','False','False','60','','','False','','Community Compliance','True','True','False','','','','Update','','','','','','Animals - Dog - Noise','False','cfsuite1__CFSuite_Request_Flow__c-3','');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-3','CJ - Animals - Dog - Noise','012O5000006qu7kIAA','','','False','','','','','','','Animals','','Community_Compliance','Standard_Request_Initial','Assess and Assign','','','','','False','False','','False','<p><strong style="font-size: 18px;">Excess noise from pets at a neighbouring property</strong></p><p><br></p><p>Disruptive behaviour that unreasonably interferes with the enjoyment of your home, including excessive noise and disturbance from pets can be reported to the office of pet Harmony.</p><p><br></p><p>For more information see the Office of Pet Harmony website.</p><p><br></p><p>If you feel your safety or the safety of others is at risk contact the police on 131 444 (or 000 in an emergency).</p>','Environmental Health and Community Compliance','False','City Development','','No','No','True','True','','','False','','Deflection','','1','','False','True','False','True','True','','','Investigation','Assess and Assign','','','other.png','','False','','Dog','Noise','True','False','False','1','','','False','','Community Compliance','True','True','False','','','','Update','','','','','','Animals - Dog - Noise','False','','cfsuite1__CFSuite_Request_Flow__c-10');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-4','CJ - Footpaths - Maintenance - Repair','012O5000006qu7kIAA','','','False','Footpaths','','','','','','Footpaths','','Community_Compliance','Standard_Request_Initial','Assess and Assign','','','Request','','False','False','','False','','Environmental Health and Community Compliance','False','City Development','','No','No','True','True','Community Compliance','','False','','Map','','1','','False','False','False','False','True','','','Investigation','Assess and Assign','','','other.png','','False','','Maintenance','Repair','False','False','False','2','','','False','','Community Compliance','True','True','False','','','','Update','','','','','','Footpaths - Maintenance - Repair','False','','');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-5','CA - Councillor Question','012O5000006qu7iIAA','','','False','','','','','','','Councillor Question','','Community_Compliance','Councillor_Question','','','','','','False','False','','False','','','False','','','No','No','True','True','Community Compliance','','False','','Deflection','','','','False','False','False','False','True','','','Councillor_Question','Assigned','','','other.png','','False','','','','False','False','False','10','','','False','','','True','True','False','','','','Update','','','','','','Councillor Question','False','cfsuite1__CFSuite_Request_Flow__c-18','');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-6','CJ - Animals - Dog - Wandering at Large','012O5000006qu7kIAA','','','False','','','','','','','Animals','Is the dog contained?','Community_Compliance','Standard_Request_Initial','Assess and Assign','','','','','False','False','','False','','Environmental Health and Community Compliance','True','City Development','','No','Yes','True','True','Community Compliance','','False','','Map','','1','','False','True','False','True','True','','','Investigation','Assess and Assign','','','other.png','','False','','Dog','Wandering at Large','False','False','False','1','','','False','','Community Compliance','False','False','False','','','','Update','','','','','','Animals - Dog - Wandering at Large','False','','cfsuite1__CFSuite_Request_Flow__c-10');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-7','CA - Animals - Dog and Cat - Unauthorised Breeder','012O5000006qu7iIAA','','','False','','','','','','','Animals','Where is the property?



What evidence do you have of animals being sold?



Is this the first instance? (Provide evidence of previous instances)



What contact has already been made? (If Board is reporting) 



What is your name and contact details?','Community Compliance','Investigation','Assess and Assign','','','Request','','False','False','','False','','Environmental Health and Community Compliance','True','City Development','','No','No','True','True','Community Compliance','','False','','Map','','10','','False','True','False','True','True','','','Investigation','Assigned','','','other.png','','False','','Dog','Unauthorised Breeder','True','False','False','10','','','False','','Community Compliance','True','True','False','','','','Update','','','','','','Animals - Dog and Cat - Unauthorised Breeder','False','cfsuite1__CFSuite_Request_Flow__c-1','');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-8','DC - Finance - Update Personal Details','012O5000006qu7lIAA','','','False','','','','','','','Finance - Update Personal Details','','','','','','','Request','','False','False','','False','','','False','','','No','No','True','True','','','False','','','','','','False','False','False','True','True','','','','','','','other.png','','False','','','','False','False','False','','','','False','','','False','False','False','','','','Update','','','','','','','True','','');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-9','CA - Animals - Dog - Wandering at Large','012O5000006qu7iIAA','','','False','','','','','','','Animals','','Community_Compliance','Investigation','Assess and Assign','','','','','False','False','','False','','Environmental Health and Community Compliance','False','City Development','','No','Yes','True','True','Community Compliance','','False','','Deflection','','1','','False','True','False','True','True','','','Investigation','Assigned','','','other.png','','False','','Dog','Wandering at Large','False','False','False','1','','','False','','Community Compliance','False','False','False','','','','Update','','','','','','Animals - Dog - Wandering at Large','False','cfsuite1__CFSuite_Request_Flow__c-6','');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-10','DC - Animals','012O5000006qu7lIAA','','','False','','','','','','','Animals','','','','','','','Request','','False','False','','False','','','False','','','No','No','True','True','','','False','','','','','All animal related requests','False','False','False','False','True','','','','','','','other.png','','False','','','','False','False','False','','','Animal,Animals','False','','','False','False','False','','','','Update','','','','','','','False','','');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-11','DC - Bill Posting','012O5000006qu7lIAA','','','False','','','','','','','Bill Posting','','','','','','','Request','','False','False','','False','','','False','','','No','No','True','True','','','False','','','','','Bill Posting','False','False','False','False','True','','','','','','','other.png','','False','','','','False','False','False','','','','False','','','False','False','False','','','','Update','','','','','','','False','','');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-12','CJ - Bills Posting - Unauthorised - South','012O5000006qu7kIAA','','','False','','','','','','','Bill Posting','','Community_Compliance','Standard_Request_Initial','Assess and Assign','South','','Request','','False','False','','False','','Environmental Health and Community Compliance','False','City Development','','No','No','True','True','Community Compliance','','False','','Map','','1','','False','False','False','False','True','','','Investigation','Assess and Assign','','','other.png','','False','','Unauthorised','','False','False','False','2','','','False','','Community Compliance','True','True','False','','','','Update','','','','','ZoneNorthSouth','Bills Posting - Unauthorised','False','','cfsuite1__CFSuite_Request_Flow__c-11');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-13','CA - Bills Posting - Unauthorised - South','012O5000006qu7iIAA','','','False','','','','','','','Bill Posting','','Community_Compliance','Standard_Request_Initial','Assess and Assign','South','','Request','','False','False','','False','','Environmental Health and Community Compliance','False','City Development','','No','No','True','True','Community Compliance','','False','','Map','','80','','False','False','False','False','True','','','Investigation','Assigned','','','other.png','','False','','Unauthorised','','False','False','False','90','','','False','','Community Compliance','True','True','False','','','','Update','','','','','Zone','Bills Posting - Unauthorised','False','cfsuite1__CFSuite_Request_Flow__c-12','cfsuite1__CFSuite_Request_Flow__c-11');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-14','CJ - Bills Posting - Unauthorised - North','012O5000006qu7kIAA','','','False','','','','','','','Bill Posting','','Community_Compliance','Standard_Request_Initial','Assess and Assign','North','','Request','','False','False','','False','','Environmental Health and Community Compliance','False','City Development','','No','No','True','True','Community Compliance','','False','','Map','','1','','False','False','False','False','True','','','Investigation','Assess and Assign','','','other.png','','False','','Unauthorised','','False','False','False','2','','','False','','Community Compliance','True','True','False','','','','Update','','','','','ZoneNorthSouth','Bills Posting - Unauthorised','False','','cfsuite1__CFSuite_Request_Flow__c-11');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-15','CA - Bills Posting - Unauthorised - North','012O5000006qu7iIAA','','','False','','','','','','','Bill Posting','','Community_Compliance','Standard_Request_Initial','Assess and Assign','North','','Request','','False','False','','False','','Environmental Health and Community Compliance','False','City Development','','No','No','True','True','Community Compliance','','False','','Map','','40','','False','False','False','False','True','','','Investigation','Assigned','','','other.png','','False','','Unauthorised','','False','False','False','40','','','False','','Community Compliance','True','True','False','','','','Update','','','','','Zone','Bills Posting - Unauthorised','False','cfsuite1__CFSuite_Request_Flow__c-14','cfsuite1__CFSuite_Request_Flow__c-11');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-16','CA - Finance - Update Personal Details - Business Name','012O5000006qu7iIAA','','','False','','','','','','','Finance - Update Personal Details','','Finance_Rates','Update_Details','Assess and Assign','','','Request','','False','False','','False','','Finance','False','City Development','','No','No','True','True','','','False','','Deflection','','2','','False','True','False','True','True','','','Update_Details','Assigned','','','other.png','','False','','Business Name','','True','False','False','2','','','False','','Property and Rating','True','True','False','','','','Update','','','','','','Finance - Update Personal Details - Business Name','True','cfsuite1__CFSuite_Request_Flow__c-17','cfsuite1__CFSuite_Request_Flow__c-8');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-17','CJ - Finance - Update Personal Details - Business Name','012O5000006qu7kIAA','','','False','','','','','','','Finance - Update Personal Details','','Finance_Rates','Standard_Request_Initial','Assess and Assign','','','Request','','False','False','','False','','Finance','False','City Development','','No','No','True','True','','','False','','Deflection','','1','','False','True','False','True','True','','','Update_Details','Assess and Assign','','','other.png','','False','','Business Name','','True','False','False','1','','','False','','Property and Rating','True','True','False','','','','Update','','','','','','Finance - Update Personal Details - Business Name','True','','cfsuite1__CFSuite_Request_Flow__c-8');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-18','CJ - Councillor Question','012O5000006qu7kIAA','','','False','','','','','','','Councillor Question','','Community_Compliance','Standard_Request_Initial','Assess and Assign','','','Request','','False','False','','False','','','False','','','No','No','True','True','Community Compliance','','False','','Deflection','','','','False','True','False','True','True','','','Councillor_Question','Assess and Assign','','','other.png','','False','','','','False','False','False','2','','','False','','','True','True','False','','','','Update','','','','','','Councillor Question','True','','cfsuite1__CFSuite_Request_Flow__c-19');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-19','DC - Councillor Question','012O5000006qu7lIAA','','','False','','','','','','','Councillor Question','','','','','','','Request','','False','False','','False','','','False','','','No','No','True','True','','','False','','','','','','False','False','False','True','True','','','','','','','other.png','','False','','','','False','False','False','','','','False','','','False','False','False','','','','Update','','','','','','','True','','');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-20','CA - Footpaths - Maintenance - Repair','012O5000006qu7iIAA','','','False','Footpaths','','','','','','Footpaths','','Community_Compliance','Standard_Request_Initial','Assess and Assign','','','Request','','False','False','','False','','Environmental Health and Community Compliance','False','City Development','','No','No','True','True','Community Compliance','','False','','Map','','60','','False','False','False','False','True','','','Investigation','Assigned','','','other.png','','False','','Maintenance','Repair','False','False','False','60','','','False','','Community Compliance','True','True','False','','','','Update','','','','','','Footpaths - Maintenance - Repair','False','cfsuite1__CFSuite_Request_Flow__c-4','');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-21','DC - Footpaths','012O5000006qu7lIAA','','','False','','','','','','','Footpaths','','','','','','','Request','','False','False','','False','','','False','','','No','No','True','True','','','False','','','','','Footpath repair and maintenance','False','False','False','False','True','','','','','','','other.png','','False','','','','False','False','False','','','','False','','','False','False','False','','','','Update','','','','','','','False','','');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-22','CA - Animals - Dog - Keeping Excess Dogs','012O5000006qu7iIAA','','','False','','','','','','','Animals','','Community_Compliance','Standard_Request_Initial','Assess and Assign','','','Request','','False','False','','False','','Environmental Health and Community Compliance','False','City Development','','No','Yes','True','True','Community Compliance','','False','','Map','','1','','False','True','False','True','True','','','Investigation','Assess and Assign','','','other.png','','False','','Dog','Keeping Excess Dogs','False','False','False','5','','','False','','Community Compliance','False','False','False','','','','Update','','','','','','Animals - Dog - Keeping Excess Dogs','False','cfsuite1__CFSuite_Request_Flow__c-23','cfsuite1__CFSuite_Request_Flow__c-10');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-23','CJ - Animals - Dog - Keeping Excess Dogs','012O5000006qu7kIAA','','','False','','','','','','','Animals','','Community_Compliance','Standard_Request_Initial','Assess and Assign','','','Request','','False','False','','False','','Environmental Health and Community Compliance','False','City Development','','No','Yes','True','True','Community Compliance','','False','','Map','','1','','False','True','False','True','True','','','Investigation','Assess and Assign','','','other.png','','False','','Dog','Keeping Excess Dogs','False','False','False','1','','','False','','Community Compliance','False','False','False','','','','Update','','','','','','Animals - Dog - Keeping Excess Dogs','False','','cfsuite1__CFSuite_Request_Flow__c-10');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-24','Rates - Reverse Payment (Bank)','012O5000006qu7lIAA','','','False','','','','','','','Rates - Reverse Payment (Bank)','','','','','','','','','False','False','','False','','','False','','','No','No','True','True','','','False','','Deflection','','','','False','False','False','False','True','','','','','','','other.png','','False','','','','False','False','False','','','','False','','','False','False','False','','','','Update','','','','','','','False','','');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-25','Rates - Extension Request','012O5000006qu7lIAA','','','False','','','','','','','Rates - Extension Request','','','','','','','','','False','False','','False','','','False','','','No','No','True','True','','','False','','Deflection','','','Customer wants to extend payment of their current outstanding balance (current charges plus any arrears) to a later date. Dept: Finance/Rates','False','False','True','True','True','','','','','','','other.png','','False','','','','False','False','False','','','rates, extend due date, extend payment, extend','False','','','False','False','False','','','','Update','','','','','','','True','','');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-26','Rates - Missing Payment','012O5000006qu7lIAA','','','False','','','','','','','Rates - Missing Payment','','','','','','','','','False','False','','False','','','False','','','No','No','True','True','','','False','','Deflection','','','Customer reports they made a payment for rates but that payment it is not showing as received by Council. Proof of payment must be attached to the case. Dept: Finance/Rates','False','False','True','True','True','','','','','','','other.png','','False','','','','False','False','False','','','missing rates, missing rates payment, rates, missing payment Restricted page access','False','','','False','False','False','','','','Update','','','','','','','True','','');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-27','Rates - Payment Plan','012O5000006qu7lIAA','','','False','','','','','','','Rates - Payment Plan','','','','','','','','','False','False','','False','','','False','','','No','No','True','True','','','False','','Deflection','','','Customer wants to establish a payment plan to pay outstanding rates (including arrears) in full via equal weekly, fortnightly or monthly instalments. Is automatically approved if paid in full by June 30 of current rates year. Dept: Finance/Rates','False','False','True','True','True','','','','','','','other.png','','False','','','','False','False','False','','','rates plan, payment plan','False','','','False','False','False','','','','Update','','','','','','','True','','');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-28','Rates - Refund Credit Balance','012O5000006qu7lIAA','','','False','','','','','','','Rates - Refund Credit Balance','','','','','','','','','False','False','','False','','','False','','','No','No','True','True','','','False','','Deflection','','','Customer has over-paid their full year assessment and wants a full or part refund of their credit balance in the current rating year (following rating year has not yet commenced). Dept: Finance/Rates','False','False','True','True','True','','','','','','','other.png','','False','','','','False','False','False','','','rates, overpaid, over-paid, credit','False','','','False','False','False','','','','Update','','','','','','','True','','');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-29','Rates - Reverse Payment (Bank)','012O5000006qu7lIAA','','','False','','','','','','','Rates - Reverse Payment (Bank)','','','','','','','','','False','False','','False','','','False','','','No','No','True','True','','','False','','Deflection','','','Customer wants a recent rates payment reversed (refunded) and the Payment Method is either Front Counter, Direct Transfer, Australia Post or Other (these payments can only be reversed via EFT - BSB & A/C No required). Dept: Finance/Rates','False','False','True','True','True','','','','','','','other.png','','False','','','','False','False','False','','','reverse payment, rates, refund payment','False','','','False','False','False','','','','Update','','','','','','','True','','');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-30','Rates - Reverse Payment (Source)','012O5000006qu7lIAA','','','False','','','','','','','Rates - Reverse Payment (Source)','','','','','','','','','False','False','','False','','','False','','','No','No','True','True','','','False','','Deflection','','','Customer wants a recent rates payment reversed (refunded) and the Payment Method is not Front Counter, Direct Transfer, Australia Post or Other. Payment will be refunded to the sourced account/credit card. Dept: Finance/Rates','False','False','True','True','True','','','','','','','other.png','','False','','','','False','False','False','','','reverse payment, rates, refund payment','False','','','False','False','False','','','','Update','','','','','','','True','','');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-31','Rates - Transfer Payment','012O5000006qu7lIAA','','','False','','','','','','','Rates - Transfer Payment','','','','','','','','','False','False','','False','','','False','','','No','No','True','True','','','False','','Deflection','','','Customer linked to multiple properties wants to transfer a payment from one property they own to another property they own (mistakenly paid rates to their wrong property). Dept: Finance/Rates','False','False','True','True','True','','','','','','','other.png','','False','','','','False','False','False','','','paid wrong property, paid incorrect property, paid wrong assessment, paid incorrect assessment','False','','','False','False','False','','','','Update','','','','','','','True','','');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-32','CJ-Rates - Extension Request-Financial Hardship----','012O5000006qu7kIAA','','','False','','','','','','','Rates - Extension Request','','Finance','Create_Case_Finance_Unrestricted','','','','','Rates','False','False','','False','','Finance','False','Corporate Services','','No','No','True','True','Finance Rates','','False','','Map','','5','','False','True','False','False','True','','','Finance_Unrestricted','','','','other.png','','False','','Financial Hardship','','False','False','False','5','','','False','','Property and Rating','True','True','False','','','','Update','','','','','','Finance - Update Personal Details - Business Name','False','','cfsuite1__CFSuite_Request_Flow__c-25');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-33','CJ-Rates - Extension Request-Non-receipt of Rates Notice----','012O5000006qu7kIAA','','','False','','','','','','','Rates - Extension Request','','Finance','Create_Case_Finance_Unrestricted','','','','','Rates','False','False','','False','','Finance','False','Corporate Services','','No','No','True','True','Finance Rates','','False','','Map','','5','','False','True','False','False','True','','','Finance_Unrestricted','','','','other.png','','False','','Non-receipt of Rates Notice','','False','False','False','5','','','False','','Property and Rating','True','True','False','','','','Update','','','','','','Finance - Update Personal Details - Business Name','False','','cfsuite1__CFSuite_Request_Flow__c-25');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-34','CJ-Rates - Extension Request-Previous Good Payment History----','012O5000006qu7kIAA','','','False','','','','','','','Rates - Extension Request','','Finance','Create_Case_Finance_Unrestricted','','','','','Rates','False','False','','False','','Finance','False','Corporate Services','','No','No','True','True','Finance Rates','','False','','Map','','5','','False','True','False','False','True','','','Finance_Unrestricted','','','','other.png','','False','','Previous Good Payment History','','False','False','False','5','','','False','','Property and Rating','True','True','False','','','','Update','','','','','','Finance - Update Personal Details - Business Name','False','','cfsuite1__CFSuite_Request_Flow__c-25');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-35','CJ-Rates - Extension Request-Sickness, Accident or Hospitalisation----','012O5000006qu7kIAA','','','False','','','','','','','Rates - Extension Request','','Finance','Create_Case_Finance_Unrestricted','','','','','Rates','False','False','','False','','Finance','False','Corporate Services','','No','No','True','True','Finance Rates','','False','','Map','','5','','False','True','False','False','True','','','Finance_Unrestricted','','','','other.png','','False','','Sickness, Accident or Hospitalisation','','False','False','False','5','','','False','','Property and Rating','True','True','False','','','','Update','','','','','','Finance - Update Personal Details - Business Name','False','','cfsuite1__CFSuite_Request_Flow__c-25');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-36','CJ-Rates - Extension Request-Other----','012O5000006qu7kIAA','','','False','','','','','','','Rates - Extension Request','','Finance','Create_Case_Finance_Unrestricted','','','','','Rates','False','False','','False','','Finance','False','Corporate Services','','No','No','True','True','Finance Rates','','False','','Map','','5','','False','True','False','False','True','','','Finance_Unrestricted','','','','other.png','','False','','Other','','False','False','False','5','','','False','','Property and Rating','True','True','False','','','','Update','','','','','','Finance - Update Personal Details - Business Name','False','','cfsuite1__CFSuite_Request_Flow__c-25');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-37','CJ-Rates - Missing Payment-----','012O5000006qu7kIAA','','','False','','','','','','','Rates - Missing Payment','','Finance','Create_Case_Finance_Unrestricted','','','','','Rates','False','False','','False','','Finance','False','Corporate Services','','No','No','True','True','Finance Rates','','False','','Map','','5','','False','True','False','False','True','','','Finance_Unrestricted','','','','other.png','','False','','','','False','False','False','5','','','False','','Property and Rating','True','True','False','','','','Update','','','','','','Finance - Update Personal Details - Business Name','False','','cfsuite1__CFSuite_Request_Flow__c-26');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-38','CJ-Rates - Payment Plan-----','012O5000006qu7kIAA','','','False','','','','','','','Rates - Payment Plan','','Finance','Finance_Unrestricted','','','','','','False','False','','False','','Finance','False','Corporate Services','','No','No','True','True','Finance Rates','','False','','Map','','5','','False','True','False','False','True','','','Finance_Unrestricted','','','','other.png','','False','','','','False','False','False','5','','','False','','Property and Rating','True','True','False','','','','Update','','','','','','Finance - Update Personal Details - Business Name','False','','cfsuite1__CFSuite_Request_Flow__c-27');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-39','CJ-Rates - Refund Credit Balance-----','012O5000006qu7kIAA','','','False','','','','','','','Rates - Refund Credit Balance','','Finance','Create_Case_Finance_Restricted','','','','','Rates','False','False','','False','','Finance','False','Corporate Services','','No','No','True','True','Finance Rates','','False','','Map','','5','','False','True','False','False','True','','','Finance_Restricted','','','','other.png','','False','','','','False','False','False','5','','','False','','Property and Rating','True','True','False','','','','Update','','','','','','Finance - Update Personal Details - Business Name','False','','cfsuite1__CFSuite_Request_Flow__c-28');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-40','CJ-Rates - Reverse Payment (Bank)-----','012O5000006qu7kIAA','','','False','','','','','','','Rates - Reverse Payment (Bank)','','Finance','Finance_Restricted','','','','','','False','False','','False','','Finance','False','Corporate Services','','No','No','True','True','Finance Rates','','False','','Map','','5','','False','True','False','False','True','','','Finance_Restricted','','','','other.png','','False','','','','False','False','False','5','','','False','','Property and Rating','True','True','False','','','','Update','','','','','','Finance - Update Personal Details - Business Name','False','','cfsuite1__CFSuite_Request_Flow__c-29');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-41','CJ-Rates - Reverse Payment (Source)-----','012O5000006qu7kIAA','','','False','','','','','','','Rates - Reverse Payment (Source)','','Finance','Create_Case_Finance_Unrestricted','','','','','Rates','False','False','','False','','Finance','False','Corporate Services','','No','No','True','True','Finance Rates','','False','','Map','','5','','False','True','False','False','True','','','Finance_Unrestricted','','','','other.png','','False','','','','False','False','False','5','','','False','','Property and Rating','True','True','False','','','','Update','','','','','','Finance - Update Personal Details - Business Name','False','','cfsuite1__CFSuite_Request_Flow__c-30');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-42','CJ-Rates - Transfer Payment-----','012O5000006qu7kIAA','','','False','','','','','','','Rates - Transfer Payment','','Finance','Create_Case_Finance_Unrestricted','','','','','Rates','False','False','','False','','Finance','False','Corporate Services','','No','No','True','True','Finance Rates','','False','','Map','','5','','False','True','False','False','True','','','Finance_Unrestricted','','','','other.png','','False','','','','False','False','False','5','','','False','','Property and Rating','True','True','False','','','','Update','','','','','','Finance - Update Personal Details - Business Name','False','','cfsuite1__CFSuite_Request_Flow__c-31');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-43','CA-Rates - Extension Request-Financial Hardship----','012O5000006qu7iIAA','','','False','','','','','','','Rates - Extension Request','','','Finance_Unrestricted','Assess and Assign','','','','Rates','False','False','','False','','Finance','False','Corporate Services','','No','No','True','True','Finance Rates','','False','','Deflection','','5','','False','False','False','False','True','','','Finance_Unrestricted','In Progress','','','other.png','','False','','Financial Hardship','','False','False','False','5','','','False','','Property and Rating','False','False','False','','','','Update','','','','','','Finance - Update Personal Details - Business Name','False','cfsuite1__CFSuite_Request_Flow__c-32','');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-44','CA-Rates - Extension Request-Non-receipt of Rates Notice----','012O5000006qu7iIAA','','','False','','','','','','','Rates - Extension Request','','','Finance_Unrestricted','Assess and Assign','','','','Rates','False','False','','False','','Finance','False','Corporate Services','','No','No','True','True','Finance Rates','','False','','Deflection','','5','','False','False','False','False','True','','','Finance_Unrestricted','In Progress','','','other.png','','False','','Non-receipt of Rates Notice','','False','False','False','5','','','False','','Property and Rating','False','False','False','','','','Update','','','','','','Finance - Update Personal Details - Business Name','False','cfsuite1__CFSuite_Request_Flow__c-33','');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-45','CA-Rates - Extension Request-Previous Good Payment History----','012O5000006qu7iIAA','','','False','','','','','','','Rates - Extension Request','','','Finance_Unrestricted','Assess and Assign','','','','Rates','False','False','','False','','Finance','False','Corporate Services','','No','No','True','True','Finance Rates','','False','','Deflection','','5','','False','False','False','False','True','','','Finance_Unrestricted','In Progress','','','other.png','','False','','Previous Good Payment History','','False','False','False','5','','','False','','Property and Rating','False','False','False','','','','Update','','','','','','Finance - Update Personal Details - Business Name','False','cfsuite1__CFSuite_Request_Flow__c-34','');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-46','CA-Rates - Extension Request-Sickness, Accident or Hospitalisation----','012O5000006qu7iIAA','','','False','','','','','','','Rates - Extension Request','','','Finance_Unrestricted','Assess and Assign','','','','Rates','False','False','','False','','Finance','False','Corporate Services','','No','No','True','True','Finance Rates','','False','','Deflection','','5','','False','False','False','False','True','','','Finance_Unrestricted','In Progress','','','other.png','','False','','Sickness, Accident or Hospitalisation','','False','False','False','5','','','False','','Property and Rating','False','False','False','','','','Update','','','','','','Finance - Update Personal Details - Business Name','False','cfsuite1__CFSuite_Request_Flow__c-35','');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-47','CA-Rates - Extension Request-Other----','012O5000006qu7iIAA','','','False','','','','','','','Rates - Extension Request','','','Finance_Unrestricted','Assess and Assign','','','','Rates','False','False','','False','','Finance','False','Corporate Services','','No','No','True','True','Finance Rates','','False','','Deflection','','5','','False','False','False','False','True','','','Finance_Unrestricted','In Progress','','','other.png','','False','','Other','','False','False','False','5','','','False','','Property and Rating','False','False','False','','','','Update','','','','','','Finance - Update Personal Details - Business Name','False','cfsuite1__CFSuite_Request_Flow__c-36','');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-48','CA-Rates - Missing Payment-----','012O5000006qu7iIAA','','','False','','','','','','','Rates - Missing Payment','','','Finance_Unrestricted','Assess and Assign','','','','Rates','False','False','','False','','Finance','False','Corporate Services','','No','No','True','True','Finance Rates','','False','','Deflection','','5','','False','False','False','False','True','','','Finance_Unrestricted','In Progress','','','other.png','','False','','','','False','False','False','5','','','False','','Property and Rating','False','False','False','','','','Update','','','','','','Finance - Update Personal Details - Business Name','False','cfsuite1__CFSuite_Request_Flow__c-37','');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-49','CA-Rates - Payment Plan-----','012O5000006qu7iIAA','','','False','','','','','','','Rates - Payment Plan','','','Finance_Unrestricted','Assess and Assign','','','','Rates','False','False','','False','','Finance','False','Corporate Services','','No','No','True','True','Finance Rates','','False','','Deflection','','5','','False','False','False','False','True','','','Finance_Unrestricted','In Progress','','','other.png','','False','','','','False','False','False','5','','','False','','Property and Rating','False','False','False','','','','Update','','','','','','Finance - Update Personal Details - Business Name','False','cfsuite1__CFSuite_Request_Flow__c-38','');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-50','CA-Rates - Refund Credit Balance-----','012O5000006qu7iIAA','','','False','','','','','','','Rates - Refund Credit Balance','','','Finance_Restricted','Assess and Assign','','','','Rates','False','False','','False','','Finance','False','Corporate Services','','No','No','True','True','Finance Rates','','False','','Deflection','','5','','False','False','False','False','True','','','Finance_Restricted','In Progress','','','other.png','','False','','','','False','False','False','5','','','False','','Property and Rating','False','False','False','','','','Update','','','','','','Finance - Update Personal Details - Business Name','False','cfsuite1__CFSuite_Request_Flow__c-39','');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-51','CA-Rates - Reverse Payment (Bank)-----','012O5000006qu7iIAA','','','False','','','','','','','Rates - Reverse Payment (Bank)','','','Finance_Restricted','Assess and Assign','','','','Rates','False','False','','False','','Finance','False','Corporate Services','','No','No','True','True','Finance Rates','','False','','Deflection','','5','','False','False','False','False','True','','','Finance_Restricted','In Progress','','','other.png','','False','','','','False','False','False','5','','','False','','Property and Rating','False','False','False','','','','Update','','','','','','Finance - Update Personal Details - Business Name','False','cfsuite1__CFSuite_Request_Flow__c-40','');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-52','CA-Rates - Reverse Payment (Source)-----','012O5000006qu7iIAA','','','False','','','','','','','Rates - Reverse Payment (Source)','','','Finance_Unrestricted','Assess and Assign','','','','Rates','False','False','','False','','Finance','False','Corporate Services','','No','No','True','True','Finance Rates','','False','','Deflection','','5','','False','False','False','False','True','','','Finance_Unrestricted','In Progress','','','other.png','','False','','','','False','False','False','5','','','False','','Property and Rating','False','False','False','','','','Update','','','','','','Finance - Update Personal Details - Business Name','False','cfsuite1__CFSuite_Request_Flow__c-41','');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-53','CA-Rates - Transfer Payment-----','012O5000006qu7iIAA','','','False','','','','','','','Rates - Transfer Payment','','','Finance_Unrestricted','Assess and Assign','','','','Rates','False','False','','False','','Finance','False','Corporate Services','','No','No','True','True','Finance Rates','','False','','Deflection','','5','','False','False','False','False','True','','','Finance_Unrestricted','In Progress','','','other.png','','False','','','','False','False','False','5','','','False','','Property and Rating','False','False','False','','','','Update','','','','','','Finance - Update Personal Details - Business Name','False','cfsuite1__CFSuite_Request_Flow__c-42','');
CREATE TABLE "cfsuite1__CFSuite_Request_Flow__c_rt_mapping" (
	record_type_id VARCHAR(18) NOT NULL, 
	developer_name VARCHAR(255), 
	is_person_type BOOLEAN, 
	PRIMARY KEY (record_type_id)
);
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c_rt_mapping" VALUES('012O5000006qu7iIAA','Case_Assignment',0);
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c_rt_mapping" VALUES('012O5000006qu7jIAA','Case_Mapping',0);
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c_rt_mapping" VALUES('012O5000006qu7kIAA','Category_Journey',0);
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c_rt_mapping" VALUES('012O5000006qu7lIAA','Display_Category',0);
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c_rt_mapping" VALUES('012O5000006qu7mIAA','Work_Order_Mapping',0);
CREATE TABLE "cfsuite1__CFSuite_Restricted_Page_Access__c" (
	id VARCHAR(255) NOT NULL, 
	"cfsuite1__Message__c" VARCHAR(255), 
	PRIMARY KEY (id)
);
CREATE TABLE "cfsuite1__CFSuite_User_Setting__c" (
	id VARCHAR(255) NOT NULL, 
	"cfsuite1__CreatedDate__c" VARCHAR(255), 
	"cfsuite1__Default__c" VARCHAR(255), 
	"cfsuite1__End_Date__c" VARCHAR(255), 
	"cfsuite1__Filter_Name__c" VARCHAR(255), 
	"cfsuite1__Predefined_Date_Range__c" VARCHAR(255), 
	"cfsuite1__Start_Date__c" VARCHAR(255), 
	"cfsuite1__Status__c" VARCHAR(255), 
	"cfsuite1__Team_Name__c" VARCHAR(255), 
	"cfsuite1__User_Id__c" VARCHAR(255), 
	"cfsuite1__Work_Category__c" VARCHAR(255), 
	PRIMARY KEY (id)
);
CREATE TABLE "cfsuite1__CFSuite_User_Team__c" (
	id VARCHAR(255) NOT NULL, 
	"Name" VARCHAR(255), 
	"cfsuite1__CreatedDate__c" VARCHAR(255), 
	"cfsuite1__Default__c" VARCHAR(255), 
	"cfsuite1__End_Date__c" VARCHAR(255), 
	"cfsuite1__Filter_Name__c" VARCHAR(255), 
	"cfsuite1__Predefined_Date_Range__c" VARCHAR(255), 
	"cfsuite1__Start_Date__c" VARCHAR(255), 
	"cfsuite1__Status__c" VARCHAR(255), 
	"cfsuite1__Team_Name__c" VARCHAR(255), 
	"cfsuite1__User_Id__c" VARCHAR(255), 
	"cfsuite1__Work_Category__c" VARCHAR(255), 
	PRIMARY KEY (id)
);
CREATE TABLE "cfsuite1__Customer_Settings__c" (
	id VARCHAR(255) NOT NULL, 
	"Name" VARCHAR(255), 
	"cfsuite1__Value__c" VARCHAR(255), 
	"cfsuite1__Customer__c" VARCHAR(255), 
	"cfsuite1__Notification_Settings__c" VARCHAR(255), 
	PRIMARY KEY (id)
);
CREATE TABLE "cfsuite1__Data_Settings__c" (
	id VARCHAR(255) NOT NULL, 
	"RecordTypeId" VARCHAR(255), 
	"cfsuite1__Allow_Anonymous_Submission__c" VARCHAR(255), 
	"cfsuite1__Alt_Text__c" VARCHAR(255), 
	"cfsuite1__Case_Record_Type__c" VARCHAR(255), 
	"cfsuite1__Category__c" VARCHAR(255), 
	"cfsuite1__Contact_Form_Type__c" VARCHAR(255), 
	"cfsuite1__Council__c" VARCHAR(255), 
	"cfsuite1__Deflection_Text__c" VARCHAR(255), 
	"cfsuite1__Deflection_URL__c" VARCHAR(255), 
	"cfsuite1__External_Id__c" VARCHAR(255), 
	"cfsuite1__Field_Set__c" VARCHAR(255), 
	"cfsuite1__Flow_Name__c" VARCHAR(255), 
	"cfsuite1__Guided_Request_Process_Name__c" VARCHAR(255), 
	"cfsuite1__KB_Tag__c" VARCHAR(255), 
	"cfsuite1__Navigation_Steps__c" VARCHAR(255), 
	"cfsuite1__Next_Step__c" VARCHAR(255), 
	"cfsuite1__Question__c" VARCHAR(255), 
	"cfsuite1__Reason__c" VARCHAR(255), 
	"cfsuite1__Search_Tag__c" VARCHAR(255), 
	"cfsuite1__Search_Title__c" VARCHAR(255), 
	"cfsuite1__Sort_Order__c" VARCHAR(255), 
	"cfsuite1__Sub_Reason__c" VARCHAR(255), 
	"cfsuite1__isDeflection__c" VARCHAR(255), 
	"cfsuite1__CFSuite_Request_Flow__c" VARCHAR(255), 
	"cfsuite1__Parent_Question__c" VARCHAR(255), 
	PRIMARY KEY (id)
);
INSERT INTO "cfsuite1__Data_Settings__c" VALUES('cfsuite1__Data_Settings__c-1','012O5000006qu7zIAA','True','','','','Allow anonymous with no contact details','','','','','Default','','','','','Flow','I would like to report:','','','','','','False','','cfsuite1__Data_Settings__c-4');
INSERT INTO "cfsuite1__Data_Settings__c" VALUES('cfsuite1__Data_Settings__c-2','012O5000006qu7zIAA','True','','','','Allow anonymous with no contact details','','','','','Default','','','','','Flow','I would like to report','','','','','','False','','cfsuite1__Data_Settings__c-3');
INSERT INTO "cfsuite1__Data_Settings__c" VALUES('cfsuite1__Data_Settings__c-3','012O5000006qu7yIAA','True','','','','Allow anonymous with no contact details','','','','','Default','','','','Request;Location;Details;Complete','Flow','Footpaths','','','','','','False','','');
INSERT INTO "cfsuite1__Data_Settings__c" VALUES('cfsuite1__Data_Settings__c-4','012O5000006qu7yIAA','True','','','','Allow anonymous with no contact details','','','','','Default','','','','Request;Location;Details;Complete','Flow','Bill Posting','','','','','','False','','');
INSERT INTO "cfsuite1__Data_Settings__c" VALUES('cfsuite1__Data_Settings__c-5','012O5000006qu7yIAA','True','','','','Allow anonymous with no contact details','','','','','Default','','','','Request;Location;Details;Complete','Flow','Animals','','','','','','False','','');
INSERT INTO "cfsuite1__Data_Settings__c" VALUES('cfsuite1__Data_Settings__c-6','012O5000006qu7zIAA','True','','','','Allow anonymous with no contact details','','','','','Default','','','','','Flow','I would like to report:','','','','','','False','','cfsuite1__Data_Settings__c-5');
INSERT INTO "cfsuite1__Data_Settings__c" VALUES('cfsuite1__Data_Settings__c-7','012O5000006qu80IAA','True','','','','Allow anonymous with no contact details','','','https://www.google.com','','Default','','','','','Flow','Unauthorised Dog Show','','','','','','True','cfsuite1__CFSuite_Request_Flow__c-1','cfsuite1__Data_Settings__c-5');
INSERT INTO "cfsuite1__Data_Settings__c" VALUES('cfsuite1__Data_Settings__c-8','012O5000006qu80IAA','True','','','','Allow anonymous with no contact details','','','','','Default','','','','Request;Location;Details;Complete','Map','Unauthorised Breeder','','Breeder','Unauthorised Breeder','3.0','','False','cfsuite1__CFSuite_Request_Flow__c-1','cfsuite1__Data_Settings__c-5');
INSERT INTO "cfsuite1__Data_Settings__c" VALUES('cfsuite1__Data_Settings__c-9','012O5000006qu80IAA','True','','','','Allow anonymous with no contact details','','','','','Default','','','','Request;Location;Details;Complete','Map','Bills posted on private property','','Bills','Bills on private property','1.0','','False','cfsuite1__CFSuite_Request_Flow__c-14','cfsuite1__Data_Settings__c-4');
INSERT INTO "cfsuite1__Data_Settings__c" VALUES('cfsuite1__Data_Settings__c-10','012O5000006qu80IAA','True','','','','Allow anonymous with no contact details','','','','','Default','','','','Request;Location;Details;Complete','Map','Bills posted on council property','','Bills','Bills on council property','1.0','','False','cfsuite1__CFSuite_Request_Flow__c-14','cfsuite1__Data_Settings__c-4');
INSERT INTO "cfsuite1__Data_Settings__c" VALUES('cfsuite1__Data_Settings__c-11','012O5000006qu80IAA','True','','','','Allow anonymous with no contact details','','','','','Default','General_QA_Flow','','Excessive Dogs','Request;Location;Details;Complete','Flow','Excessive Dogs at a Property','','Excessive Dogs','Excessive Dogs','','','False','cfsuite1__CFSuite_Request_Flow__c-23','cfsuite1__Data_Settings__c-5');
INSERT INTO "cfsuite1__Data_Settings__c" VALUES('cfsuite1__Data_Settings__c-12','012O5000006qu80IAA','True','','','','Allow anonymous with no contact details','','<h2>Excess noise from pets at a neighbouring property</h2>

<br />

<p>Disruptive behaviour that unreasonably interferes with the enjoyment of your home, including excessive noise and disturbance from pets can be reported to the office of pet matters.</p><br />

<p>For more information see the <a target="_blank" href="https://www.epa.nsw.gov.au/your-environment/noise/neighbourhood-noise/dealing-with-barking-dogs">Office or Pet Harmony</a> website.</p>

<br />

<p>If you feel your safety or the safety of others is at risk contact the police on 131 444 (or 000 in an emergency).</p>','','','Default','','','','Request','Flow','A Barking Dog','','Barking Dog','Barking Dog','1.0','','True','cfsuite1__CFSuite_Request_Flow__c-3','cfsuite1__Data_Settings__c-5');
INSERT INTO "cfsuite1__Data_Settings__c" VALUES('cfsuite1__Data_Settings__c-13','012O5000006qu80IAA','True','','','','Allow anonymous with no contact details','','','','','Default','','','','Request;Location;Details;Complete','Map','An uneven footpath','','Uneven Footpath','Uneven Footpath','1.0','','False','cfsuite1__CFSuite_Request_Flow__c-4','cfsuite1__Data_Settings__c-3');
INSERT INTO "cfsuite1__Data_Settings__c" VALUES('cfsuite1__Data_Settings__c-14','012O5000006qu80IAA','True','','','','Allow anonymous with no contact details','','','','','Default','','','','Request;Location;Details;Complete','Map','Damage to a footpath','','Footpath damage','Footpath damage','2.0','','False','cfsuite1__CFSuite_Request_Flow__c-4','cfsuite1__Data_Settings__c-3');
INSERT INTO "cfsuite1__Data_Settings__c" VALUES('cfsuite1__Data_Settings__c-15','012O5000006qu80IAA','True','','','','Allow anonymous with no contact details','','','','','Default','','','','Request;Location;Details;Complete','Map','A Wandering Dog','','Wandering Dog','Wandering Dog','2.0','','False','cfsuite1__CFSuite_Request_Flow__c-6','cfsuite1__Data_Settings__c-5');
CREATE TABLE "cfsuite1__Data_Settings__c_rt_mapping" (
	record_type_id VARCHAR(18) NOT NULL, 
	developer_name VARCHAR(255), 
	is_person_type BOOLEAN, 
	PRIMARY KEY (record_type_id)
);
INSERT INTO "cfsuite1__Data_Settings__c_rt_mapping" VALUES('012O5000006qu7yIAA','Guided_Request_Process',0);
INSERT INTO "cfsuite1__Data_Settings__c_rt_mapping" VALUES('012O5000006qu7zIAA','Question',0);
INSERT INTO "cfsuite1__Data_Settings__c_rt_mapping" VALUES('012O5000006qu80IAA','Response',0);
CREATE TABLE "cfsuite1__Notification_Settings__c" (
	id VARCHAR(255) NOT NULL, 
	"Name" VARCHAR(255), 
	"cfsuite1__Active_Flag__c" VARCHAR(255), 
	"cfsuite1__Description__c" VARCHAR(255), 
	"cfsuite1__Description_rich__c" VARCHAR(255), 
	"cfsuite1__Display_Name__c" VARCHAR(255), 
	"cfsuite1__Hide_toggle__c" VARCHAR(255), 
	"cfsuite1__Type__c" VARCHAR(255), 
	PRIMARY KEY (id)
);
CREATE TABLE "cfsuite1__Property_Customer__c" (
	id VARCHAR(255) NOT NULL, 
	"Name" VARCHAR(255), 
	"cfsuite1__Assessment_Name_ID__c" VARCHAR(255), 
	"cfsuite1__Comments_Notes__c" VARCHAR(255), 
	"cfsuite1__Contact_Email__c" VARCHAR(255), 
	"cfsuite1__Date_Linked_to_Property__c" VARCHAR(255), 
	"cfsuite1__Inactive_Reason__c" VARCHAR(255), 
	"cfsuite1__Inactive_Since__c" VARCHAR(255), 
	"cfsuite1__Last_Sync_Date__c" VARCHAR(255), 
	"cfsuite1__NAR_Id__c" VARCHAR(255), 
	"cfsuite1__Name_on_Rates_Notice__c" VARCHAR(255), 
	"cfsuite1__Ownership_End_Date__c" VARCHAR(255), 
	"cfsuite1__Ownership_Start_Date__c" VARCHAR(255), 
	"cfsuite1__Primary_Email__c" VARCHAR(255), 
	"cfsuite1__Property_Assessment_No__c" VARCHAR(255), 
	"cfsuite1__Relationship_Status__c" VARCHAR(255), 
	"cfsuite1__Relationship_Type__c" VARCHAR(255), 
	"cfsuite1__Relationship__c" VARCHAR(255), 
	"cfsuite1__Resend_OBM__c" VARCHAR(255), 
	"cfsuite1__Suppressed__c" VARCHAR(255), 
	"cfsuite1__Surname__c" VARCHAR(255), 
	"cfsuite1__Unique_Property_Customer_Id2__c" VARCHAR(255), 
	"cfsuite1__Unique_Property_Customer_Id__c" VARCHAR(255), 
	"cfsuite1__Valuation_Number__c" VARCHAR(255), 
	"cfsuite1__Customer__c" VARCHAR(255), 
	"cfsuite1__Property__c" VARCHAR(255), 
	PRIMARY KEY (id)
);
INSERT INTO "cfsuite1__Property_Customer__c" VALUES('cfsuite1__Property_Customer__c-1','Hammy Hampster','','','','','','','','302300','','','','','345','Active','Primary','','False','','','a0cO5000005vjQbIAI-001O500002bsOFkIAM','','','Account-3','cfsuite1__Property__c-5');
INSERT INTO "cfsuite1__Property_Customer__c" VALUES('cfsuite1__Property_Customer__c-2','Hammy Hampster','','','','','','','','302300','','','','','149412','Active','Secondary','','False','','','a0cO5000005vjQZIAY-001O500002bsOFkIAM','','','Account-3','cfsuite1__Property__c-3');
INSERT INTO "cfsuite1__Property_Customer__c" VALUES('cfsuite1__Property_Customer__c-3','Hammy Hampster','','','','','Change of Ownership','','','302300','','2025-06-09','','','171338','Active','Previous Primary','','False','','','a0cO5000005vjQaIAI-001O500002bsOFkIAM','','','Account-3','cfsuite1__Property__c-4');
INSERT INTO "cfsuite1__Property_Customer__c" VALUES('cfsuite1__Property_Customer__c-4','Hammy Hampster','','','','','','2025-06-05','','302300','','','','','113256','Active','Primary','','False','','','a0cO5000005vjQXIAY-001O500002bsOFkIAM','','','Account-3','cfsuite1__Property__c-1');
INSERT INTO "cfsuite1__Property_Customer__c" VALUES('cfsuite1__Property_Customer__c-5','Hammy Hampster','','','','','','2025-05-29','','302300','Hammy Hampster','','2024-05-07','','100025','Active','Primary','','False','','','a0cO5000005vjQYIAY-001O500002bsOFkIAM','','100025','Account-3','cfsuite1__Property__c-2');
CREATE TABLE "cfsuite1__Property__c" (
	id VARCHAR(255) NOT NULL, 
	"Name" VARCHAR(255), 
	"RecordTypeId" VARCHAR(255), 
	"cfsuite1__Active_Extension__c" VARCHAR(255), 
	"cfsuite1__Active_Payment_Plan__c" VARCHAR(255), 
	"cfsuite1__Alert_Code__c" VARCHAR(255), 
	"cfsuite1__Arrears_Amount__c" VARCHAR(255), 
	"cfsuite1__Assessment_Number__c" VARCHAR(255), 
	"cfsuite1__BPAY_Number__c" VARCHAR(255), 
	"cfsuite1__Council__c" VARCHAR(255), 
	"cfsuite1__Council_value__c" VARCHAR(255), 
	"cfsuite1__Country__c" VARCHAR(255), 
	"cfsuite1__Direct_Debit__c" VARCHAR(255), 
	"cfsuite1__Financial_Year__c" VARCHAR(255), 
	"cfsuite1__Formatted_Number__c" VARCHAR(255), 
	"cfsuite1__Full_year_balance__c" VARCHAR(255), 
	"cfsuite1__Has_Agent__c" VARCHAR(255), 
	"cfsuite1__Has_Pensioner__c" VARCHAR(255), 
	"cfsuite1__House_Number__c" VARCHAR(255), 
	"cfsuite1__Interest_Calculation_Date__c" VARCHAR(255), 
	"cfsuite1__Land_Size__c" VARCHAR(255), 
	"cfsuite1__Last_evaluated_date__c" VARCHAR(255), 
	"cfsuite1__Last_sync_date__c" VARCHAR(255), 
	"cfsuite1__Level__c" VARCHAR(255), 
	"cfsuite1__Lot_DP__c" VARCHAR(255), 
	"cfsuite1__Major_Agent_Code_Authority__c" VARCHAR(255), 
	"cfsuite1__Major_Agent_Code__c" VARCHAR(255), 
	"cfsuite1__Memo__c" VARCHAR(255), 
	"cfsuite1__Name_on_Rates_Notice__c" VARCHAR(255), 
	"cfsuite1__New_NAR__c" VARCHAR(255), 
	"cfsuite1__Ownership_End_Date__c" VARCHAR(255), 
	"cfsuite1__Ownership_Start_Date__c" VARCHAR(255), 
	"cfsuite1__Parcel_Flag__c" VARCHAR(255), 
	"cfsuite1__Postal_Code__c" VARCHAR(255), 
	"cfsuite1__Previous_Quarter_Due_Date__c" VARCHAR(255), 
	"cfsuite1__Property_Assesment_ID__c" VARCHAR(255), 
	"cfsuite1__Quarter_1_Balance__c" VARCHAR(255), 
	"cfsuite1__Quarter_1_Due_Date__c" VARCHAR(255), 
	"cfsuite1__Quarter_1_Issue_Date__c" VARCHAR(255), 
	"cfsuite1__Quarter_2_Balance__c" VARCHAR(255), 
	"cfsuite1__Quarter_2_Due_Date__c" VARCHAR(255), 
	"cfsuite1__Quarter_2_Issue_Date__c" VARCHAR(255), 
	"cfsuite1__Quarter_3_Balance__c" VARCHAR(255), 
	"cfsuite1__Quarter_3_Due_Date__c" VARCHAR(255), 
	"cfsuite1__Quarter_3_Issue_Date__c" VARCHAR(255), 
	"cfsuite1__Quarter_4_Balance__c" VARCHAR(255), 
	"cfsuite1__Quarter_4_Due_Date__c" VARCHAR(255), 
	"cfsuite1__Quarter_4_Issue_Date__c" VARCHAR(255), 
	"cfsuite1__Quarter_date_notice__c" VARCHAR(255), 
	"cfsuite1__Quarter_due_amount__c" VARCHAR(255), 
	"cfsuite1__Quarter_due_date__c" VARCHAR(255), 
	"cfsuite1__Rates_Address_1__c" VARCHAR(255), 
	"cfsuite1__Rates_Address_2__c" VARCHAR(255), 
	"cfsuite1__Rates_Address_3__c" VARCHAR(255), 
	"cfsuite1__Rates_Address__c" VARCHAR(255), 
	"cfsuite1__Rates_myCouncil__c" VARCHAR(255), 
	"cfsuite1__Resend_OBM__c" VARCHAR(255), 
	"cfsuite1__State__c" VARCHAR(255), 
	"cfsuite1__Street_Name__c" VARCHAR(255), 
	"cfsuite1__Street_Type__c" VARCHAR(255), 
	"cfsuite1__Suburb__c" VARCHAR(255), 
	"cfsuite1__Unit_Number__c" VARCHAR(255), 
	"cfsuite1__Unit_Type__c" VARCHAR(255), 
	"cfsuite1__Valuation_Number__c" VARCHAR(255), 
	"cfsuite1__Zoning__c" VARCHAR(255), 
	cfsuite1__amount_paid_pending_authority__c VARCHAR(255), 
	"cfsuite1__Assessment__c" VARCHAR(255), 
	PRIMARY KEY (id)
);
INSERT INTO "cfsuite1__Property__c" VALUES('cfsuite1__Property__c-1','37 Goldberry Street (A)','012O5000006qu83IAA','','','','300.0','113256','1132562','','1000000.0','','','','','300.0','','','','','','2024-12-01','','','','','','','Hammy Hampster','','','2026-06-28','','','','','0.0','2024-01-09','','0.0','2024-01-12','','100.0','2025-01-03','','100.0','2025-01-06','','','','','','','','37 Goldberry Street','','False','','','','','','','100006','','600.0','');
INSERT INTO "cfsuite1__Property__c" VALUES('cfsuite1__Property__c-2','1 Cadisfly Alley (A)','012O5000006qu83IAA','','','','','100025','','','','','','','','4000000000.0','','','','','','','','','','','','99 - Debt Collection','Hammy Hampster','','','2024-05-07','','','','','0.0','2025-09-01','','1000000.0','2025-12-01','','1000000.0','2026-03-01','','10000000.0','2026-06-01','','','','','','','','1 Cadisfly Alley','','False','','','','','','','100025','','0.0','');
INSERT INTO "cfsuite1__Property__c" VALUES('cfsuite1__Property__c-3','32 Courage Square (A)','012O5000006qu83IAA','','','','','149412','','','','','','','','100.0','','','','','','','','','','','','','Hammy Hampster','','','2019-05-01','','','','','100.0','2024-09-30','','100.0','2024-12-31','','100.5','2025-03-31','','100.0','2025-06-30','','','','','','','','32 Courage Square','','False','','','','','','','100007','','800.0','');
INSERT INTO "cfsuite1__Property__c" VALUES('cfsuite1__Property__c-4','1 Humbdinger avenue (A)','012O5000006qu83IAA','','','','','171338','','','1000000.0','','','','','-200.0','','','','','','2025-05-29','','','','','','','Hammy Hampster','1008','2025-06-13','2025-06-12','','','','','0.0','2024-06-01','','0.0','2024-12-31','','0.0','2025-03-31','','0.0','2025-06-30','','','','','','','','1 Humbdinger avenue','','False','','','','','','','12347788','','','');
INSERT INTO "cfsuite1__Property__c" VALUES('cfsuite1__Property__c-5','32 Develish Court (A)','012O5000006qu83IAA','','','','0.0','345','','','1000000.0','','','','','100.0','','','','','','2025-06-10','','','','','','8 - Section 184 Action','Hammy Hampster','','','2025-06-10','','','','','0.0','2024-09-30','','0.0','2024-12-31','','0.0','2025-03-30','','100.0','2025-06-30','','','','','','','','32 Develish Court','','False','','','','','','','345','','0.0','');
CREATE TABLE "cfsuite1__Property__c_rt_mapping" (
	record_type_id VARCHAR(18) NOT NULL, 
	developer_name VARCHAR(255), 
	is_person_type BOOLEAN, 
	PRIMARY KEY (record_type_id)
);
INSERT INTO "cfsuite1__Property__c_rt_mapping" VALUES('012O5000006qu83IAA','Assessment',0);
INSERT INTO "cfsuite1__Property__c_rt_mapping" VALUES('012O5000006qu84IAA','Parcel',0);
CREATE TABLE "cfsuite1__Resource__c" (
	id VARCHAR(255) NOT NULL, 
	"Name" VARCHAR(255), 
	"cfsuite1__Description__c" VARCHAR(255), 
	PRIMARY KEY (id)
);
COMMIT;
