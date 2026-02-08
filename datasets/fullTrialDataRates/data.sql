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
INSERT INTO "Account" VALUES('Account-1','Hammy','Hampster','','False','False','False','012Mn0000000hgcIAA','','','','','','399887','','','','','03','','','','','','','37 Courage Square','','','','03','No','','False','','','','','','','','','','','','','','','','','','','','','','','Email','','Email','False','No Notifications','','SA','','','','','','','','','False','','Active','','','','','','No','Yes','','','True','');
INSERT INTO "Account" VALUES('Account-2','Hilda','Hampster','','False','False','False','012Mn0000000hgcIAA','','','','','','','','','','','03','','','','','','','','','','','03','No','','False','','','','','','','','','','','','','','','','','','','','','','','Email','','','False','No Notifications','','SA','','','','','','','','','False','','Active','','','','','','No','No','','','True','');
INSERT INTO "Account" VALUES('Account-3','TEST','TEST','','False','False','False','012Mn0000000hgcIAA','','','','','','','','','','','03','','','','','','','','','','','03','No','','False','','','','','','','','','','','','','','','','','','','','','','','Email','','Email','False','No Notifications','','SA','','','','','','','','','False','','Active','','','','','','No','No','','','True','');
INSERT INTO "Account" VALUES('Account-4','TEST','TEST','','False','False','False','012Mn0000000hgcIAA','','','','','','','','','','','03','','','','','','','','','','','03','No','','False','','','','','','','','','','','','','','','','','','','','','','','Email','','Email','False','No Notifications','','SA','','','','','','','','','False','','Active','','','','','','No','No','','','True','');
INSERT INTO "Account" VALUES('Account-5','Rachael18','Harding','','False','False','False','012Mn0000000hgcIAA','','','','','','','','','','','03','','','','','','','','','','','03','No','','False','','','','','','','','','','','','','','','','','','','','','','','Email','','Email','False','No Notifications','','SA','','','','','','','','','False','','Active','','','','','','No','No','','','True','');
INSERT INTO "Account" VALUES('Account-6','Philip','Marlowe','','False','False','False','012Mn0000000hgcIAA','','','','','','376845','','','','','03','','','','','','','37 Big Street Adelaide SA 5000','','','','03','No','','False','','','','','','','','','','','','','','','','','','','','','','','Email','','','False','No Notifications','','SA','','','','','','','','','False','','Active','','','','','','No','Yes','','','True','');
INSERT INTO "Account" VALUES('Account-7','Rachael16','Harding','','False','False','False','012Mn0000000hgcIAA','','','','','','','','','','','03','','','','','','','','','','','03','No','','False','','','','','','','','','','','','','','','','','','','','','','','Email','','Email','False','No Notifications','','SA','','','','','','','','','False','','Active','','','','','','No','No','','','True','');
INSERT INTO "Account" VALUES('Account-8','Test','Nar','','False','False','False','012Mn0000000hgcIAA','','14405','18672','','','123456','','','','','03','','','','','','123 Beach Road TORQUAY  VIC  3228','1123 Horseshoe Bend Road TORQUAY  VIC  3228','','','','03','No','','False','','','','','','','','','','','','','','184953','3228','','Vic','Beach','Road','TORQUAY','','','Email','','','False','Email','3228','Vic','TORQUAY','','184817','','','Road','','','False','','Active','','','','Horseshoe Bend','','No','Yes','','','True','');
CREATE TABLE "Account_rt_mapping" (
	record_type_id VARCHAR(18) NOT NULL, 
	developer_name VARCHAR(255), 
	is_person_type BOOLEAN, 
	PRIMARY KEY (record_type_id)
);
INSERT INTO "Account_rt_mapping" VALUES('012Mn0000000hg5IAA','Business',0);
INSERT INTO "Account_rt_mapping" VALUES('012Mn0000000hg6IAA','Overseas_Business',0);
INSERT INTO "Account_rt_mapping" VALUES('012Mn0000000hgaIAA','Employee',1);
INSERT INTO "Account_rt_mapping" VALUES('012Mn0000000hgbIAA','Overseas_Customer',1);
INSERT INTO "Account_rt_mapping" VALUES('012Mn0000000hgcIAA','PersonAccount',1);
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
INSERT INTO "cfsuite1__CFSuiteRatesSettings__c" VALUES('cfsuite1__CFSuiteRatesSettings__c-1','a0WBm000001VyqX','Visa,Mastercard','','No','Yes','This amount includes any debts against the property, rates owing, or any approved transfers or refunds.','Under 5 days','5','xxxxx','','No','/s/case-details','/s/','https://my.councilname.sa.gov.au/CustomLoginPage','cfsuite','Surf Coast Shire Council','Surf Coast Shire Council','info@surfcoast.vic.gov.au','Courtesy_Reminder_Quarter_DD','Courtesy_Reminder_No_DD','Rates_Courtesy_Reminder_Quarter_DD','Rates_Courtesy_Reminder_No_DD','surfocastLogo','surfocastLogo','03 5261 0600','Customer Service','Change of Ownership;Cancelled by Staff','Debt Collectors','1300 xxx xxx','Setup Direct Debit','Surf Coast Shire Council','/s/direct-debit','No','','CFSuiteRatesDownloadNotice','No','Rates - Extension Request','/s/rates-faq','Surf Coast Shire Council','https://surfcoastshirevictoria--rates.sandbox.my.site.com/s/propertysummary?id=','No','','No','Lawyers Name','1300 xxxx xxxx','','','/s/manage-direct-debit','Surf Coast Shire Council','1500.0','500.0','100.0','','2.0','#EE2A29','60.0','Bank Transfer;Australia Post;Other;Front Counter;Cash','','CFSuitePaymentServerPayments','','short term arrangement','a','PaymentPlanPDF','Rates - Payment Plan','#0055a4','12.0','Payment_transfer_or_refund__c','','Surf Coast Shire Council','/s/mylinkedproperties','/s/paymentextension','/s/propertylink','/s/propertysummary','/s/property-payment','Ocp-Apim-Subscription-Key','https://my.councilname.sa.gov.au/rates','','CFSuiteRatesPayments','Rates Installment','Rates - Refund Credit Balance','/s/refund-credit','','Over 5 days','Finance-Restricted','Rates - Reverse Payment (Bank)','Rates - Reverse Payment (Source)','','21/07/2025','8 - Section 184 Action','MCLX77B7WKABHUHJQE5ZZVL3XQ7M','termsAndConditions','','','','Rates - Transfer Payment','Finance-Unrestricted','#008a5f','Yes','','https://www.valuergeneral.sa.gov.au/valuation/objecting-to-a-valuation');
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
INSERT INTO "cfsuite1__CFSuiteSettings__c" VALUES('cfsuite1__CFSuiteSettings__c-1','a04Mn00000196Qb','','','Additional Location Information','ParcelAddress_Full','','OBJECTID','Parcel_Num','Postcode','surfcoast.vic.gov.au;openforms.com;surfcoastevents.com.au','State','Street_Name','Street_Num','Street_Type','Suburb','Unit_Num','Street_Name','Please contact your Council to update your address, first name or last name..','Or if the matter requires immediate attention by the Council call 03 5261 0600','','htm,eml,msg,html,txt,doc,dot,docx,docm,dotx,dotm,docb,xls,xlt,xlm,xlsx,xlsm,xltx,xltm,xlsb,xlw,csv,pdf,gif,png,jpg,jpeg,heif,heic,msg,tr5,snote,PNG,mp4,3gp,hevc,mov,hevc,avi,mkv,wmv, eml,msg,html,7z,zip','HTM,eml,EML,HTML,TXT,msg,MSG,html,txt,doc,dot,docx,docm,dotx,dotm,docb,xls,xlt,xlm,xlsx,xlsm,xltx,xltm,xlsb,xlw,csv,pdf,gif,png,jpg,jpeg,heif,heic,msg,tr5,snote,PNG,7z,zip','','https://services-ap1.arcgis.com/gzhjuYmPupMv4d06/arcgis/rest/services/Surf_Coast_Shire_Boundary/FeatureServer','/s/article/','Enter the street address of the location of the request or landmark name or locate by moving the red pin on the map below.','assess and assign,assigned','Bldg_Addr','Description','*','{Description} {Bldg_Addr}','Description','Bldg_Addr','{Description} {Building_Address}','{Description} {Bldg_Addr}','Parcel_Num','Post_Code','','buildingsLayer','https://services-ap1.arcgis.com/gzhjuYmPupMv4d06/arcgis/rest/services/Surf_Coast_Shire_Buildings/FeatureServer','Street_Name','Suburb','20','busStopLayer','Stop_name','{Stop_name}','Stop_name','','{Stop_name}','{Stop_name}','','meters','Stop_name','postCode','','','','Dial 000 for Police, Fire, Ambulance in an Emergency','8.0','Yes','This Case Record Is Confidential And Has A Suppressed Customer Who Also Has An Alert.','This Case Record Is Confidential And Has A Suppressed Customer','Confidential','3-5 Business Days','1 business bay','','/s/case-details','8','This Case Record Is Not Confidential, Has a Suppressed Customer who also has an Alert.','This Case Record Is Not Confidential But Has a Suppressed Customer','No','Job Complete;Referred to External Party;Referred to Other Council;Work Not Undertaken;Justified;Not Justified;Unable to Substantiate;Approved;Not Approved; Closed on First Contact;Approved and Funded;Supported Subject to Future Funding;','https://surfcoastshirevictoria.my.site.com/s/CustomCommunityLogin','Confirm you want to unfollow this request','My Followed Request','My Request','005Mn000001508TIAQ','','CFSuite Customer Community Login User','2000','Community Portal','CFSuite Customer Community Login User','/s/','','10','approved,not approved,work not undertaken,job complete','','','Surf Coast Shire Council','','CFSuite Councillor Plus Login User','2021-12-21T12:00:00.000+0000','/s/councillor-requests','/createAccount','','Customer Alert','Mr.;Ms.;Mrs.;Dr.;Prof.;EST','Suppressed','Withheld Record','','','','15','15','No','No','No','No','No','No','Yes','Yes','Yes','Yes','Yes','','An active agent is already associated with this property','0.05','','','','Find other Council Services','/CustomCommunityForgotPasswordConfirm','/CustomCommunity/Forgot/Password','postCode','','','No','','','in progress,on hold','','c:categoryKnowledge','#004e5c','#006071','','/resource/PinImagesCustom','/resource/PinImagesCustom','Our system shows you already have an account, please Login','3','10','','100.0','','','/s/my-requests','/s/my-questions','','/s/my-requests','','Provide contact details of the community memeber to keep them informed on case progress','Assess and Assign;Assigned;In Progress;On Hold;Defect Raised;Defect Issued;Crew Complete;Team Leader Complete;','','Parcel_Address','Postcode','ParcelAddress_Full','5','{ParcelAddress_Full}','ParcelAddress_Full','Parcel_Address_NoExt','{ParcelAddress_Full}','{ParcelAddress_Full}','meters','Parcel_Num','House_Label','','','Suburb','','https://services-ap1.arcgis.com/gzhjuYmPupMv4d06/arcgis/rest/services/Surf_Coast_Shire_Parcel_Centroids/FeatureServer','','https://services-ap1.arcgis.com/gzhjuYmPupMv4d06/arcgis/rest/services/Surf_Coast_Shire_Parcels/FeatureServer','Success','Urgent Requests','','/s/redirect-to-profile','Property Alert','Withheld Customer','Assessment','~','1','','','','','What service are you looking for today?','','','0.0','','You are not authorised to view this record unless you are logged in.','Request Location','','/s/request-submit','/s/requests','No','Parcel_Address','20','*','{Reserve_Name} {Parcel_Address}','Reserve_Name','Parcel_Address','{Reserve_Name} {Parcel_Address}','{Reserve_Name} {Parcel_Address}','meters','Reserve_Name','','','https://services-ap1.arcgis.com/gzhjuYmPupMv4d06/arcgis/rest/services/Surf_Coast_Shire_Reserves/FeatureServer','Post_Code','Street_Name','Suburb','CommunityChangePasswordEmailTemplate','Password_Reset_Email','/s/resetpasswordlwc','noreply-requests@surfcoast.vic.gov.au','No','RevisedSLA','SLA','Message Media','https://apim-cfsuite-integrations.azure-api.net/prod/sms-mm-sfdc?subscription-key=b5e8c0b4d7e146428b9fb6ecccf6058e','','','','','Surf Coast Shire','20.0','Request Topics','My Surf Coast Portal','We apologies for the inconvenience and hope to have this fixed as soon as possible.','','- : -','-38.30683830074541','144.32144489549003','','Suppressed_Customer','System Administrator','ThankYou','','','https://surfcoastshirevictoria.my.site.com','','Yes','Finance - Update Personal Details','Finance_Rates','Update_Details','Business Name','No','CspLitePortal','vf.force','Job Complete,Not Council Owned,Referred to Other Council,Referred To External Party,Work Not Undertaken','This WorkOrder Record Is Confidential And Has A Suppressed Customer Who Also Has An Alert.','This WorkOrder Record Is Confidential And Has A Suppressed Customer','This WorkOrder Record is Confidential','Save updates (do not close WO),None,Create Adhoc WO,None - Close Case or leave On Hold','This WorkOrder Record Is Not Confidential, Has a Suppressed Customer who also has an Alert.','This WorkOrder Is Not Confidential But Has a Suppressed Customer','0WO','Rates - Request for Extension: Process Request;Rates - Request for Payment Plan: Process Request');
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
INSERT INTO "cfsuite1__CFSuite_Bill_Type_Settings__c" VALUES('cfsuite1__CFSuite_Bill_Type_Settings__c-1','Application','Application','False','On Hold Due to','cfsuite1__Additional_Location_Info__c','Additional Location Info','Case','True','False','On Hold Due to');
INSERT INTO "cfsuite1__CFSuite_Bill_Type_Settings__c" VALUES('cfsuite1__CFSuite_Bill_Type_Settings__c-2','Service','Service','False','On Hold Due to','cfsuite1__Additional_Location_Info__c','Additional Location Info','Case','True','False','On Hold Due to');
INSERT INTO "cfsuite1__CFSuite_Bill_Type_Settings__c" VALUES('cfsuite1__CFSuite_Bill_Type_Settings__c-3','Single','Single','False','On hold','','','Case','True','False','On hold');
INSERT INTO "cfsuite1__CFSuite_Bill_Type_Settings__c" VALUES('cfsuite1__CFSuite_Bill_Type_Settings__c-4','Rates Installment','Rates Installment','False','','','','','False','False','');
INSERT INTO "cfsuite1__CFSuite_Bill_Type_Settings__c" VALUES('cfsuite1__CFSuite_Bill_Type_Settings__c-5','Pet renewal fee','Pet renewal fee','False','On Hold Due to','cfsuite1__Additional_Location_Info__c','Additional Location Info','Case','True','False','On Hold Due to');
CREATE TABLE "cfsuite1__CFSuite_MLG_Community_Link__c" (
	id VARCHAR(255) NOT NULL, 
	"Name" VARCHAR(255), 
	"cfsuite1__Back_Label__c" VARCHAR(255), 
	"cfsuite1__Back_URL__c" VARCHAR(255), 
	"cfsuite1__Title__c" VARCHAR(255), 
	PRIMARY KEY (id)
);
INSERT INTO "cfsuite1__CFSuite_MLG_Community_Link__c" VALUES('cfsuite1__CFSuite_MLG_Community_Link__c-1','mylinkedproperties','Back to dashboard','/s/','Manage Properties');
INSERT INTO "cfsuite1__CFSuite_MLG_Community_Link__c" VALUES('cfsuite1__CFSuite_MLG_Community_Link__c-2','propertysummary','Back to properties','/s/mylinkedproperties','Manage property');
INSERT INTO "cfsuite1__CFSuite_MLG_Community_Link__c" VALUES('cfsuite1__CFSuite_MLG_Community_Link__c-3','propertylink','Back to dashboard','/s/','Add a property');
INSERT INTO "cfsuite1__CFSuite_MLG_Community_Link__c" VALUES('cfsuite1__CFSuite_MLG_Community_Link__c-4','property-payment','Back to properties','/s/','Make a payment');
INSERT INTO "cfsuite1__CFSuite_MLG_Community_Link__c" VALUES('cfsuite1__CFSuite_MLG_Community_Link__c-5','paymentextension','Back to dashboard','/s/','Request a payment arrangement');
INSERT INTO "cfsuite1__CFSuite_MLG_Community_Link__c" VALUES('cfsuite1__CFSuite_MLG_Community_Link__c-6','refund-credit','Back to My Property','/s/mylinkedproperties','Refund a credit balance');
INSERT INTO "cfsuite1__CFSuite_MLG_Community_Link__c" VALUES('cfsuite1__CFSuite_MLG_Community_Link__c-7','direct-debit','Back to properties','/s/mylinkedproperties','Setup a direct debit');
INSERT INTO "cfsuite1__CFSuite_MLG_Community_Link__c" VALUES('cfsuite1__CFSuite_MLG_Community_Link__c-8','guest-user-payment','Back','/s/','Make a payment');
INSERT INTO "cfsuite1__CFSuite_MLG_Community_Link__c" VALUES('cfsuite1__CFSuite_MLG_Community_Link__c-9','bills-and-payments','Back to dashboard','/s/','Bills and payments');
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
CREATE TABLE "cfsuite1__CFSuite_Map_Management__c" (
	id VARCHAR(255) NOT NULL, 
	"Name" VARCHAR(255), 
	"cfsuite1__Status_Group__c" VARCHAR(255), 
	"cfsuite1__Status_Values__c" VARCHAR(255), 
	"cfsuite1__Used_For__c" VARCHAR(255), 
	PRIMARY KEY (id)
);
INSERT INTO "cfsuite1__CFSuite_Map_Management__c" VALUES('cfsuite1__CFSuite_Map_Management__c-1','In Progress','In Progress','In Progress','Filter-AO-Map');
INSERT INTO "cfsuite1__CFSuite_Map_Management__c" VALUES('cfsuite1__CFSuite_Map_Management__c-2','Assess and Assign','Assess and Assign','Assess and Assign','Filter-AO-Map');
INSERT INTO "cfsuite1__CFSuite_Map_Management__c" VALUES('cfsuite1__CFSuite_Map_Management__c-3','Job Complete','Job Complete','Job Complete','Filter-AO-Map');
INSERT INTO "cfsuite1__CFSuite_Map_Management__c" VALUES('cfsuite1__CFSuite_Map_Management__c-4','On Hold','On Hold','On Hold','Filter-AO-Map');
INSERT INTO "cfsuite1__CFSuite_Map_Management__c" VALUES('cfsuite1__CFSuite_Map_Management__c-5','Assigned','Assigned','Assigned','Filter-AO-Map');
INSERT INTO "cfsuite1__CFSuite_Map_Management__c" VALUES('cfsuite1__CFSuite_Map_Management__c-6','Closed','Closed','Closed','Filter-AO-Map');
INSERT INTO "cfsuite1__CFSuite_Map_Management__c" VALUES('cfsuite1__CFSuite_Map_Management__c-7','Work In Progress','Work In Progress','Work In Progress','Filter-AO-Map');
INSERT INTO "cfsuite1__CFSuite_Map_Management__c" VALUES('cfsuite1__CFSuite_Map_Management__c-8','Open','Open','Open','Filter-AO-Map');
INSERT INTO "cfsuite1__CFSuite_Map_Management__c" VALUES('cfsuite1__CFSuite_Map_Management__c-9','Work Issued','Work Issued','Work Issued','Filter-AO-Map');
INSERT INTO "cfsuite1__CFSuite_Map_Management__c" VALUES('cfsuite1__CFSuite_Map_Management__c-10','Defect Raised','Defect Raised','Defect Raised','Filter-AO-Map');
INSERT INTO "cfsuite1__CFSuite_Map_Management__c" VALUES('cfsuite1__CFSuite_Map_Management__c-11','Work Raised','Work Raised','Work Raised','Filter-AO-Map');
INSERT INTO "cfsuite1__CFSuite_Map_Management__c" VALUES('cfsuite1__CFSuite_Map_Management__c-12','Work Not Undertaken','Work Not Undertaken','Work Not Undertaken','Filter-AO-Map');
INSERT INTO "cfsuite1__CFSuite_Map_Management__c" VALUES('cfsuite1__CFSuite_Map_Management__c-13','Not Inspected - Cancelled','Not Inspected - Cancelled','Not Inspected - Cancelled','Filter-AO-Map');
INSERT INTO "cfsuite1__CFSuite_Map_Management__c" VALUES('cfsuite1__CFSuite_Map_Management__c-14','Unable to Substantiate','Unable to Substantiate','Unable to Substantiate','Filter-AO-Map');
INSERT INTO "cfsuite1__CFSuite_Map_Management__c" VALUES('cfsuite1__CFSuite_Map_Management__c-15','Inspected - Defect(s) Raised','Inspected - Defect(s) Raised','Inspected - Defect(s) Raised','Filter-AO-Map');
INSERT INTO "cfsuite1__CFSuite_Map_Management__c" VALUES('cfsuite1__CFSuite_Map_Management__c-16','Not Justified','Not Justified','Not Justified','Filter-AO-Map');
INSERT INTO "cfsuite1__CFSuite_Map_Management__c" VALUES('cfsuite1__CFSuite_Map_Management__c-17','Defect Issued','Defect Issued','Defect Issue','Filter-AO-Map');
INSERT INTO "cfsuite1__CFSuite_Map_Management__c" VALUES('cfsuite1__CFSuite_Map_Management__c-18','Inspected - No Defects','Inspected - No Defects','Inspected - No Defects','Filter-AO-Map');
INSERT INTO "cfsuite1__CFSuite_Map_Management__c" VALUES('cfsuite1__CFSuite_Map_Management__c-19','Crew Complete','Crew Complete','Crew Complete','Filter-AO-Map');
INSERT INTO "cfsuite1__CFSuite_Map_Management__c" VALUES('cfsuite1__CFSuite_Map_Management__c-20','Team Leader Complete','Team Leader Complete','Team Leader Complete','Filter-AO-Map');
INSERT INTO "cfsuite1__CFSuite_Map_Management__c" VALUES('cfsuite1__CFSuite_Map_Management__c-21','Justified','Justified','Justified','Filter-AO-Map');
INSERT INTO "cfsuite1__CFSuite_Map_Management__c" VALUES('cfsuite1__CFSuite_Map_Management__c-22','Approved','Approved','Approved','Filter-AO-Map');
INSERT INTO "cfsuite1__CFSuite_Map_Management__c" VALUES('cfsuite1__CFSuite_Map_Management__c-23','Not Approved','Not Approved','Not Approved','Filter-AO-Map');
INSERT INTO "cfsuite1__CFSuite_Map_Management__c" VALUES('cfsuite1__CFSuite_Map_Management__c-24','Referred to External Party','Referred to External Party','Referred to External Party','Filter-AO-Map');
CREATE TABLE "cfsuite1__CFSuite_Map__c" (
	id VARCHAR(255) NOT NULL, 
	"Name" VARCHAR(255), 
	"cfsuite1__Color_Code__c" VARCHAR(255), 
	"cfsuite1__Sort_Order__c" VARCHAR(255), 
	"cfsuite1__Status__c" VARCHAR(255), 
	PRIMARY KEY (id)
);
INSERT INTO "cfsuite1__CFSuite_Map__c" VALUES('cfsuite1__CFSuite_Map__c-1','MapPin6','Jordy-Blue.png','6','');
INSERT INTO "cfsuite1__CFSuite_Map__c" VALUES('cfsuite1__CFSuite_Map__c-2','MapPin8','North_Sea','8','');
INSERT INTO "cfsuite1__CFSuite_Map__c" VALUES('cfsuite1__CFSuite_Map__c-3','First Inspection','green.png','1','First Inspection');
INSERT INTO "cfsuite1__CFSuite_Map__c" VALUES('cfsuite1__CFSuite_Map__c-4','MapPin3','water.png','3','');
INSERT INTO "cfsuite1__CFSuite_Map__c" VALUES('cfsuite1__CFSuite_Map__c-5','MapPin2','green.png','2','job complete');
INSERT INTO "cfsuite1__CFSuite_Map__c" VALUES('cfsuite1__CFSuite_Map__c-6','MapPin1','duplicate.png','1','');
INSERT INTO "cfsuite1__CFSuite_Map__c" VALUES('cfsuite1__CFSuite_Map__c-7','MapPin4','inprogress.png','4','');
INSERT INTO "cfsuite1__CFSuite_Map__c" VALUES('cfsuite1__CFSuite_Map__c-8','MapPin5','purple.png','5','');
INSERT INTO "cfsuite1__CFSuite_Map__c" VALUES('cfsuite1__CFSuite_Map__c-9','MapPin7','Iguana-Green.png','7','');
INSERT INTO "cfsuite1__CFSuite_Map__c" VALUES('cfsuite1__CFSuite_Map__c-10','MapPin9','Royal-Orange.png','9','');
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
INSERT INTO "cfsuite1__CFSuite_Preferred_Comms_Config__c" VALUES('cfsuite1__CFSuite_Preferred_Comms_Config__c-1','Case - Adhoc Payment','012Mn0000000hgFIAQ','True','','','','','','Adhoc_Payment','Update','','0D2Mn0000000LPR','','','','','','','cfsuite1__CFSuite_Bill__c','Adhoc','Adhoc','','False','False','Open','');
CREATE TABLE "cfsuite1__CFSuite_Preferred_Comms_Config__c_rt_mapping" (
	record_type_id VARCHAR(18) NOT NULL, 
	developer_name VARCHAR(255), 
	is_person_type BOOLEAN, 
	PRIMARY KEY (record_type_id)
);
INSERT INTO "cfsuite1__CFSuite_Preferred_Comms_Config__c_rt_mapping" VALUES('012Mn0000000hgFIAQ','Customer_Notification',0);
INSERT INTO "cfsuite1__CFSuite_Preferred_Comms_Config__c_rt_mapping" VALUES('012Mn0000000hgGIAQ','Emergency_Notification',0);
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
INSERT INTO "cfsuite1__CFSuite_Product__c" VALUES('cfsuite1__CFSuite_Product__c-1','Service Fee','True','0.0','','','','','ddd111','GSTExclusive','10.0','100.0','','2025-11-14','');
INSERT INTO "cfsuite1__CFSuite_Product__c" VALUES('cfsuite1__CFSuite_Product__c-2','Application Fee','True','0.0','','','','','SSSEEE','GSTExclusive','10.0','120.0','','2025-11-14','');
INSERT INTO "cfsuite1__CFSuite_Product__c" VALUES('cfsuite1__CFSuite_Product__c-3','Product 1','False','0.0','','','','','','','0.0','0.0','','','');
INSERT INTO "cfsuite1__CFSuite_Product__c" VALUES('cfsuite1__CFSuite_Product__c-4','Business applications and permits - Permits - Footpath Trading Permit - Display','True','0.0','','Business applications and permits','Permits: Footpath Trading - Display of goods','','12201.33100.61001','ExemptGST','0.0','56.0','Permits','','Footpath Trading Permit - Display of goods');
INSERT INTO "cfsuite1__CFSuite_Product__c" VALUES('cfsuite1__CFSuite_Product__c-5','Dog registration renewal','False','0.0','','','Pet registration renewal fee','','','ExemptGST','0.0','69.0','','','');
INSERT INTO "cfsuite1__CFSuite_Product__c" VALUES('cfsuite1__CFSuite_Product__c-6','Rates Installment','True','0.0','Rates Installment','','Rates Installment','','','IncofGST','10.0','0.0','','2025-12-05','');
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
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-1','Rates - Reverse Payment (Bank)','012Mn0000000hgKIAQ','','','False','','','','','','','Rates - Reverse Payment (Bank)','','','','','','','','','False','False','','False','','','False','','','No','No','True','True','','','False','','Deflection','','','','False','False','False','False','True','','','','','','','other.png','','False','','','','False','False','False','','','','False','','','False','False','False','','','','Update','','','','','','','False','','');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-2','Rates - Extension Request','012Mn0000000hgKIAQ','','','False','','','','','','','Rates - Extension Request','','','','','','','','','False','False','','False','','','False','','','No','No','True','True','','','False','','Deflection','','','Customer wants to extend payment of their current outstanding balance (current charges plus any arrears) to a later date. Dept: Finance/Rates','False','False','True','True','True','','','','','','','other.png','','False','','','','False','False','False','','','rates, extend due date, extend payment, extend','False','','','False','False','False','','','','Update','','','','','','','True','','');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-3','Rates - Missing Payment','012Mn0000000hgKIAQ','','','False','','','','','','','Rates - Missing Payment','','','','','','','','','False','False','','False','','','False','','','No','No','True','True','','','False','','Deflection','','','Customer reports they made a payment for rates but that payment it is not showing as received by Council. Proof of payment must be attached to the case. Dept: Finance/Rates','False','False','True','True','True','','','','','','','other.png','','False','','','','False','False','False','','','missing rates, missing rates payment, rates, missing payment Restricted page access','False','','','False','False','False','','','','Update','','','','','','','True','','');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-4','Rates - Payment Plan','012Mn0000000hgKIAQ','','','False','','','','','','','Rates - Payment Plan','','','','','','','','','False','False','','False','','','False','','','No','No','True','True','','','False','','Deflection','','','Customer wants to establish a payment plan to pay outstanding rates (including arrears) in full via equal weekly, fortnightly or monthly instalments. Is automatically approved if paid in full by June 30 of current rates year. Dept: Finance/Rates','False','False','True','True','True','','','','','','','other.png','','False','','','','False','False','False','','','rates plan, payment plan','False','','','False','False','False','','','','Update','','','','','','','True','','');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-5','Rates - Refund Credit Balance','012Mn0000000hgKIAQ','','','False','','','','','','','Rates - Refund Credit Balance','','','','','','','','','False','False','','False','','','False','','','No','No','True','True','','','False','','Deflection','','','Customer has over-paid their full year assessment and wants a full or part refund of their credit balance in the current rating year (following rating year has not yet commenced). Dept: Finance/Rates','False','False','True','True','True','','','','','','','other.png','','False','','','','False','False','False','','','rates, overpaid, over-paid, credit','False','','','False','False','False','','','','Update','','','','','','','True','','');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-6','Rates - Reverse Payment (Bank)','012Mn0000000hgKIAQ','','','False','','','','','','','Rates - Reverse Payment (Bank)','','','','','','','','','False','False','','False','','','False','','','No','No','True','True','','','False','','Deflection','','','Customer wants a recent rates payment reversed (refunded) and the Payment Method is either Front Counter, Direct Transfer, Australia Post or Other (these payments can only be reversed via EFT - BSB & A/C No required). Dept: Finance/Rates','False','False','True','True','True','','','','','','','other.png','','False','','','','False','False','False','','','reverse payment, rates, refund payment','False','','','False','False','False','','','','Update','','','','','','','True','','');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-7','Rates - Reverse Payment (Source)','012Mn0000000hgKIAQ','','','False','','','','','','','Rates - Reverse Payment (Source)','','','','','','','','','False','False','','False','','','False','','','No','No','True','True','','','False','','Deflection','','','Customer wants a recent rates payment reversed (refunded) and the Payment Method is not Front Counter, Direct Transfer, Australia Post or Other. Payment will be refunded to the sourced account/credit card. Dept: Finance/Rates','False','False','True','True','True','','','','','','','other.png','','False','','','','False','False','False','','','reverse payment, rates, refund payment','False','','','False','False','False','','','','Update','','','','','','','True','','');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-8','Rates - Transfer Payment','012Mn0000000hgKIAQ','','','False','','','','','','','Rates - Transfer Payment','','','','','','','','','False','False','','False','','','False','','','No','No','True','True','','','False','','Deflection','','','Customer linked to multiple properties wants to transfer a payment from one property they own to another property they own (mistakenly paid rates to their wrong property). Dept: Finance/Rates','False','False','True','True','True','','','','','','','other.png','','False','','','','False','False','False','','','paid wrong property, paid incorrect property, paid wrong assessment, paid incorrect assessment','False','','','False','False','False','','','','Update','','','','','','','True','','');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-9','CJ-Rates - Extension Request-Financial Hardship----','012Mn0000000hgJIAQ','','','False','','','','','','','Rates - Extension Request','','Finance','Create_Case_Finance_Unrestricted','','','','','Rates','False','False','','False','','Finance','False','Corporate Services','','No','No','True','True','Finance Rates','','False','','Map','','5','','False','True','False','False','True','','','Finance_Unrestricted','','','','other.png','','False','','Financial Hardship','','False','False','False','5','','','False','','Property and Rating','True','True','False','','','','Update','','','','','','Finance - Update Personal Details - Business Name','False','','cfsuite1__CFSuite_Request_Flow__c-2');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-10','CJ-Rates - Extension Request-Non-receipt of Rates Notice----','012Mn0000000hgJIAQ','','','False','','','','','','','Rates - Extension Request','','Finance','Create_Case_Finance_Unrestricted','','','','','Rates','False','False','','False','','Finance','False','Corporate Services','','No','No','True','True','Finance Rates','','False','','Map','','5','','False','True','False','False','True','','','Finance_Unrestricted','','','','other.png','','False','','Non-receipt of Rates Notice','','False','False','False','5','','','False','','Property and Rating','True','True','False','','','','Update','','','','','','Finance - Update Personal Details - Business Name','False','','cfsuite1__CFSuite_Request_Flow__c-2');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-11','CJ-Rates - Extension Request-Previous Good Payment History----','012Mn0000000hgJIAQ','','','False','','','','','','','Rates - Extension Request','','Finance','Create_Case_Finance_Unrestricted','','','','','Rates','False','False','','False','','Finance','False','Corporate Services','','No','No','True','True','Finance Rates','','False','','Map','','5','','False','True','False','False','True','','','Finance_Unrestricted','','','','other.png','','False','','Previous Good Payment History','','False','False','False','5','','','False','','Property and Rating','True','True','False','','','','Update','','','','','','Finance - Update Personal Details - Business Name','False','','cfsuite1__CFSuite_Request_Flow__c-2');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-12','CJ-Rates - Extension Request-Sickness, Accident or Hospitalisation----','012Mn0000000hgJIAQ','','','False','','','','','','','Rates - Extension Request','','Finance','Create_Case_Finance_Unrestricted','','','','','Rates','False','False','','False','','Finance','False','Corporate Services','','No','No','True','True','Finance Rates','','False','','Map','','5','','False','True','False','False','True','','','Finance_Unrestricted','','','','other.png','','False','','Sickness, Accident or Hospitalisation','','False','False','False','5','','','False','','Property and Rating','True','True','False','','','','Update','','','','','','Finance - Update Personal Details - Business Name','False','','cfsuite1__CFSuite_Request_Flow__c-2');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-13','CJ-Rates - Extension Request-Other----','012Mn0000000hgJIAQ','','','False','','','','','','','Rates - Extension Request','','Finance','Create_Case_Finance_Unrestricted','','','','','Rates','False','False','','False','','Finance','False','Corporate Services','','No','No','True','True','Finance Rates','','False','','Map','','5','','False','True','False','False','True','','','Finance_Unrestricted','','','','other.png','','False','','Other','','False','False','False','5','','','False','','Property and Rating','True','True','False','','','','Update','','','','','','Finance - Update Personal Details - Business Name','False','','cfsuite1__CFSuite_Request_Flow__c-2');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-14','CJ-Rates - Missing Payment-----','012Mn0000000hgJIAQ','','','False','','','','','','','Rates - Missing Payment','','Finance','Create_Case_Finance_Unrestricted','','','','','Rates','False','False','','False','','Finance','False','Corporate Services','','No','No','True','True','Finance Rates','','False','','Map','','5','','False','True','False','False','True','','','Finance_Unrestricted','','','','other.png','','False','','','','False','False','False','5','','','False','','Property and Rating','True','True','False','','','','Update','','','','','','Finance - Update Personal Details - Business Name','False','','cfsuite1__CFSuite_Request_Flow__c-3');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-15','CJ-Rates - Payment Plan-----','012Mn0000000hgJIAQ','','','False','','','','','','','Rates - Payment Plan','','Finance','Finance_Unrestricted','','','','','','False','False','','False','','Finance','False','Corporate Services','','No','No','True','True','Finance Rates','','False','','Map','','5','','False','True','False','False','True','','','Finance_Unrestricted','','','','other.png','','False','','','','False','False','False','5','','','False','','Property and Rating','True','True','False','','','','Update','','','','','','Finance - Update Personal Details - Business Name','False','','cfsuite1__CFSuite_Request_Flow__c-4');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-16','CJ-Rates - Refund Credit Balance-----','012Mn0000000hgJIAQ','','','False','','','','','','','Rates - Refund Credit Balance','','Finance','Create_Case_Finance_Restricted','Assess and Assign','','','','Rates','False','False','','False','','Finance','False','Corporate Services','','No','No','True','True','Finance Rates','','False','','Map','','5','','False','True','False','False','True','','','Finance_Restricted','Assess and Assign','','','other.png','','False','','','','False','False','False','5','','','False','','Property and Rating','True','True','False','','','','Update','','','','','','Finance - Update Personal Details - Business Name','False','','cfsuite1__CFSuite_Request_Flow__c-5');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-17','CJ-Rates - Reverse Payment (Bank)-----','012Mn0000000hgJIAQ','','','False','','','','','','','Rates - Reverse Payment (Bank)','','Finance','Finance_Restricted','','','','','','False','False','','False','','Finance','False','Corporate Services','','No','No','True','True','Finance Rates','','False','','Map','','5','','False','True','False','False','True','','','Finance_Restricted','','','','other.png','','False','','','','False','False','False','5','','','False','','Property and Rating','True','True','False','','','','Update','','','','','','Finance - Update Personal Details - Business Name','False','','cfsuite1__CFSuite_Request_Flow__c-6');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-18','CJ-Rates - Reverse Payment (Source)-----','012Mn0000000hgJIAQ','','','False','','','','','','','Rates - Reverse Payment (Source)','','Finance','Create_Case_Finance_Unrestricted','','','','','Rates','False','False','','False','','Finance','False','Corporate Services','','No','No','True','True','Finance Rates','','False','','Map','','5','','False','True','False','False','True','','','Finance_Unrestricted','','','','other.png','','False','','','','False','False','False','5','','','False','','Property and Rating','True','True','False','','','','Update','','','','','','Finance - Update Personal Details - Business Name','False','','cfsuite1__CFSuite_Request_Flow__c-7');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-19','CJ-Rates - Transfer Payment-----','012Mn0000000hgJIAQ','','','False','','','','','','','Rates - Transfer Payment','','Finance','Create_Case_Finance_Unrestricted','','','','','Rates','False','False','','False','','Finance','False','Corporate Services','','No','No','True','True','Finance Rates','','False','','Map','','5','','False','True','False','False','True','','','Finance_Unrestricted','','','','other.png','','False','','','','False','False','False','5','','','False','','Property and Rating','True','True','False','','','','Update','','','','','','Finance - Update Personal Details - Business Name','False','','cfsuite1__CFSuite_Request_Flow__c-8');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-20','CA-Rates - Extension Request-Financial Hardship----','012Mn0000000hgHIAQ','','','False','','','','','','','Rates - Extension Request','','','Finance_Unrestricted','Assess and Assign','','','','Rates','False','False','','False','','Finance','False','Corporate Services','','No','No','True','True','Finance Rates','','False','','Deflection','','5','','False','False','False','False','True','','','Finance_Unrestricted','In Progress','','','other.png','','False','','Financial Hardship','','False','False','False','5','','','False','','Property and Rating','False','False','False','','','','Update','','','','','','Finance - Update Personal Details - Business Name','False','cfsuite1__CFSuite_Request_Flow__c-9','');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-21','CA-Rates - Extension Request-Non-receipt of Rates Notice----','012Mn0000000hgHIAQ','','','False','','','','','','','Rates - Extension Request','','','Finance_Unrestricted','Assess and Assign','','','','Rates','False','False','','False','','Finance','False','Corporate Services','','No','No','True','True','Finance Rates','','False','','Deflection','','5','','False','False','False','False','True','','','Finance_Unrestricted','In Progress','','','other.png','','False','','Non-receipt of Rates Notice','','False','False','False','5','','','False','','Property and Rating','False','False','False','','','','Update','','','','','','Finance - Update Personal Details - Business Name','False','cfsuite1__CFSuite_Request_Flow__c-10','');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-22','CA-Rates - Extension Request-Previous Good Payment History----','012Mn0000000hgHIAQ','','','False','','','','','','','Rates - Extension Request','','','Finance_Unrestricted','Assess and Assign','','','','Rates','False','False','','False','','Finance','False','Corporate Services','','No','No','True','True','Finance Rates','','False','','Deflection','','5','','False','False','False','False','True','','','Finance_Unrestricted','In Progress','','','other.png','','False','','Previous Good Payment History','','False','False','False','5','','','False','','Property and Rating','False','False','False','','','','Update','','','','','','Finance - Update Personal Details - Business Name','False','cfsuite1__CFSuite_Request_Flow__c-11','');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-23','CA-Rates - Extension Request-Sickness, Accident or Hospitalisation----','012Mn0000000hgHIAQ','','','False','','','','','','','Rates - Extension Request','','','Finance_Unrestricted','Assess and Assign','','','','Rates','False','False','','False','','Finance','False','Corporate Services','','No','No','True','True','Finance Rates','','False','','Deflection','','5','','False','False','False','False','True','','','Finance_Unrestricted','In Progress','','','other.png','','False','','Sickness, Accident or Hospitalisation','','False','False','False','5','','','False','','Property and Rating','False','False','False','','','','Update','','','','','','Finance - Update Personal Details - Business Name','False','cfsuite1__CFSuite_Request_Flow__c-12','');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-24','CA-Rates - Extension Request-Other----','012Mn0000000hgHIAQ','','','False','','','','','','','Rates - Extension Request','','','Finance_Unrestricted','Assess and Assign','','','','Rates','False','False','','False','','Finance','False','Corporate Services','','No','No','True','True','Finance Rates','','False','','Deflection','','5','','False','False','False','False','True','','','Finance_Unrestricted','In Progress','','','other.png','','False','','Other','','False','False','False','5','','','False','','Property and Rating','False','False','False','','','','Update','','','','','','Finance - Update Personal Details - Business Name','False','cfsuite1__CFSuite_Request_Flow__c-13','');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-25','CA-Rates - Missing Payment-----','012Mn0000000hgHIAQ','','','False','','','','','','','Rates - Missing Payment','','','Finance_Unrestricted','Assess and Assign','','','','Rates','False','False','','False','','Finance','False','Corporate Services','','No','No','True','True','Finance Rates','','False','','Deflection','','5','','False','False','False','False','True','','','Finance_Unrestricted','In Progress','','','other.png','','False','','','','False','False','False','5','','','False','','Property and Rating','False','False','False','','','','Update','','','','','','Finance - Update Personal Details - Business Name','False','cfsuite1__CFSuite_Request_Flow__c-14','');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-26','CA-Rates - Payment Plan-----','012Mn0000000hgHIAQ','','','False','','','','','','','Rates - Payment Plan','','','Finance_Unrestricted','Assess and Assign','','','','Rates','False','False','','False','','Finance','False','Corporate Services','','No','No','True','True','Finance Rates','','False','','Deflection','','5','','False','False','False','False','True','','','Finance_Unrestricted','In Progress','','','other.png','','False','','','','False','False','False','5','','','False','','Property and Rating','False','False','False','','','','Update','','','','','','Finance - Update Personal Details - Business Name','False','cfsuite1__CFSuite_Request_Flow__c-15','');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-27','CA-Rates - Refund Credit Balance-----','012Mn0000000hgHIAQ','','','False','','','','','','','Rates - Refund Credit Balance','','','Finance_Restricted','Assess and Assign','','','','Rates','False','False','','False','','Finance','False','Corporate Services','','No','No','True','True','Finance Rates','','False','','Deflection','','5','','False','False','False','False','True','','','Finance_Restricted','In Progress','','','other.png','','False','','','','False','False','False','5','','','False','','Property and Rating','False','False','False','','','','Update','','','','','','Finance - Update Personal Details - Business Name','False','cfsuite1__CFSuite_Request_Flow__c-16','');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-28','CA-Rates - Reverse Payment (Bank)-----','012Mn0000000hgHIAQ','','','False','','','','','','','Rates - Reverse Payment (Bank)','','','Finance_Restricted','Assess and Assign','','','','Rates','False','False','','False','','Finance','False','Corporate Services','','No','No','True','True','Finance Rates','','False','','Deflection','','5','','False','False','False','False','True','','','Finance_Restricted','In Progress','','','other.png','','False','','','','False','False','False','5','','','False','','Property and Rating','False','False','False','','','','Update','','','','','','Finance - Update Personal Details - Business Name','False','cfsuite1__CFSuite_Request_Flow__c-17','');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-29','CA-Rates - Reverse Payment (Source)-----','012Mn0000000hgHIAQ','','','False','','','','','','','Rates - Reverse Payment (Source)','','','Finance_Unrestricted','Assess and Assign','','','','Rates','False','False','','False','','Finance','False','Corporate Services','','No','No','True','True','Finance Rates','','False','','Deflection','','5','','False','False','False','False','True','','','Finance_Unrestricted','In Progress','','','other.png','','False','','','','False','False','False','5','','','False','','Property and Rating','False','False','False','','','','Update','','','','','','Finance - Update Personal Details - Business Name','False','cfsuite1__CFSuite_Request_Flow__c-18','');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-30','CA-Rates - Transfer Payment-----','012Mn0000000hgHIAQ','','','False','','','','','','','Rates - Transfer Payment','','','Finance_Unrestricted','Assess and Assign','','','','Rates','False','False','','False','','Finance','False','Corporate Services','','No','No','True','True','Finance Rates','','False','','Deflection','','5','','False','False','False','False','True','','','Finance_Unrestricted','In Progress','','','other.png','','False','','','','False','False','False','5','','','False','','Property and Rating','False','False','False','','','','Update','','','','','','Finance - Update Personal Details - Business Name','False','cfsuite1__CFSuite_Request_Flow__c-19','');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-31','CJ-Rates - Extension Request- Previous Good Payment History - Over 5 days','012Mn0000000hgJIAQ','','','False','','','','','','','Rates - Extension Request','','Finance','Finance_Unrestricted','Assess and Assign','','','','','False','False','','False','','Finance','False','Corporate Services','','No','No','True','True','','','False','','Map','','','','False','False','False','False','True','','','Finance_Unrestricted','','','','other.png','','False','','Previous Good Payment History','Over 5 days','False','False','False','10','','','False','','Property and Rating','False','False','False','','','','Update','','','','','','Finance - Update Personal Details - Business Name','False','','cfsuite1__CFSuite_Request_Flow__c-2');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-32','CJ-Rates - Extension Request- Other - Over 5 days','012Mn0000000hgJIAQ','','','False','','','','','','','Rates - Extension Request','','Finance','Finance_Unrestricted','Assess and Assign','','','','','False','True','','False','','Finance','False','Corporate Services','','No','No','True','True','','','False','','Map','','','','False','True','False','False','True','','','Finance_Unrestricted','','','','other.png','','False','','Other','Over 5 days','True','False','False','10','','','False','','Property and Rating','False','False','False','','','','Update','','','','','','Finance - Update Personal Details - Business Name','False','','cfsuite1__CFSuite_Request_Flow__c-2');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-33','CJ-Rates - Extension Request - Sickness - Over 5 days','012Mn0000000hgJIAQ','','','False','','','','','','','Rates - Extension Request','','Finance','Finance_Unrestricted','Assess and Assign','','','','','False','True','','False','','Finance','False','Corporate Services','','No','No','True','True','','','False','','Map','','','','False','True','False','False','True','','','Finance_Unrestricted','','','','other.png','','False','','Sickness, Accident or Hospitalisation','Over 5 days','True','False','False','10','','','False','','Property and Rating','False','False','False','','','','Update','','','','','','Finance - Update Personal Details - Business Name','False','','cfsuite1__CFSuite_Request_Flow__c-2');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-34','CJ-Rates - Extension Request - Financial Hardship - Over 5 days','012Mn0000000hgJIAQ','','','False','','','','','','','Rates - Extension Request','','Finance','Finance_Unrestricted','Assess and Assign','','','','','False','True','','False','','Finance','False','Corporate Services','','No','No','True','True','','','False','','Map','','','','False','True','False','False','True','','','Finance_Unrestricted','','','','other.png','','False','','Financial Hardship','Over 5 days','True','False','False','10','','','False','','Property and Rating','False','False','False','','','','Update','','','','','','Finance - Update Personal Details - Business Name','False','','cfsuite1__CFSuite_Request_Flow__c-2');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-35','CJ-Rates - Extension Request - Non-receipt of Rates Notice - Over 5 days','012Mn0000000hgJIAQ','','','False','','','','','','','Rates - Extension Request','','Finance','Finance_Unrestricted','‘Assess and Assign','','','','','False','True','','False','','Finance','False','Corporate Services','','No','No','True','True','','','False','','Map','','','','False','True','False','False','True','','','Finance_Unrestricted','','','','other.png','','False','','Non-receipt of Rates Notice','Over 5 days','True','False','False','10','','','False','','Property and Rating','False','False','False','','','','Update','','','','','','Finance - Update Personal Details - Business Name','False','','cfsuite1__CFSuite_Request_Flow__c-2');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-36','CJ- Business applications and permitsPermitsFootpath Trading Permit - Display of','012Mn0000000hgJIAQ','','','False','','','','','','','Business applications and permits','','Finance','Payment_upfront','Assess and Assign','','','','','False','False','','False','','','False','','','No','No','True','True','Finance Rates','','False','eService_Master_flow','Flow','','','','False','False','False','False','True','','','Payment_upfront','Assess and Assign','','','other.png','','False','','Permits','Footpath Trading Permit - Display of goods','False','False','False','5','','','False','','','False','False','False','','','','Update','','','','','','Business applications and permits','False','','cfsuite1__CFSuite_Request_Flow__c-37');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-37','Business applications and permits','012Mn0000000hgKIAQ','','','False','','','','','','','Business applications and permits','','','','','','','','','False','False','','False','','','False','','','No','No','True','True','','','False','','','','','Business applications and permits','False','False','False','False','True','','','','','','','other.png','','False','','','','False','False','False','','','permit, roadside, trading, food, truck, stall, market, coffee, van, mobile, business','False','','','False','False','False','','','','Update','','','','','','','False','','');
CREATE TABLE "cfsuite1__CFSuite_Request_Flow__c_rt_mapping" (
	record_type_id VARCHAR(18) NOT NULL, 
	developer_name VARCHAR(255), 
	is_person_type BOOLEAN, 
	PRIMARY KEY (record_type_id)
);
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c_rt_mapping" VALUES('012Mn0000000hgHIAQ','Case_Assignment',0);
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c_rt_mapping" VALUES('012Mn0000000hgIIAQ','Case_Mapping',0);
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c_rt_mapping" VALUES('012Mn0000000hgJIAQ','Category_Journey',0);
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c_rt_mapping" VALUES('012Mn0000000hgKIAQ','Display_Category',0);
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c_rt_mapping" VALUES('012Mn0000000hgLIAQ','Work_Order_Mapping',0);
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
INSERT INTO "cfsuite1__Data_Settings__c" VALUES('cfsuite1__Data_Settings__c-1','012Mn0000000hgXIAQ','True','','','','Allow anonymous with no contact details','','','','','Default','','','','','','Other','','trading','trading','','','False','','');
INSERT INTO "cfsuite1__Data_Settings__c" VALUES('cfsuite1__Data_Settings__c-2','012Mn0000000hgYIAQ','True','','','','Allow anonymous with no contact details','','','','','Default','','','','','','I want to...','','','','','','False','','cfsuite1__Data_Settings__c-1');
INSERT INTO "cfsuite1__Data_Settings__c" VALUES('cfsuite1__Data_Settings__c-3','012Mn0000000hgZIAQ','True','Request a permit to display goods for sale','','','Allow anonymous with no contact details','','','','','Default','eService_Master_flow','','','Request;Details;Complete','Flow','Footpath Trading Permit - Display of Goods','','Advertising, goods, footpath, business, stock, display, item, items, advertise','Display goods for sale on Council land','','','False','cfsuite1__CFSuite_Request_Flow__c-36','cfsuite1__Data_Settings__c-1');
CREATE TABLE "cfsuite1__Data_Settings__c_rt_mapping" (
	record_type_id VARCHAR(18) NOT NULL, 
	developer_name VARCHAR(255), 
	is_person_type BOOLEAN, 
	PRIMARY KEY (record_type_id)
);
INSERT INTO "cfsuite1__Data_Settings__c_rt_mapping" VALUES('012Mn0000000hgXIAQ','Guided_Request_Process',0);
INSERT INTO "cfsuite1__Data_Settings__c_rt_mapping" VALUES('012Mn0000000hgYIAQ','Question',0);
INSERT INTO "cfsuite1__Data_Settings__c_rt_mapping" VALUES('012Mn0000000hgZIAQ','Response',0);
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
INSERT INTO "cfsuite1__Property_Customer__c" VALUES('cfsuite1__Property_Customer__c-1','Hammy Hampster','','','','2025-11-18','Self Unlink','2025-11-18','','','','','2025-06-10','','345','Inactive','Secondary-Unlink','','False','','','a0P9200000Llhn1EAB-0019200000xRGjXAAW','','','Account-1','cfsuite1__Property__c-1');
INSERT INTO "cfsuite1__Property_Customer__c" VALUES('cfsuite1__Property_Customer__c-2','Hammy Hampster','','','','','','','','399887','','','','','149412','Active','Primary','','False','','','a0P9200000LlkwDEAR-0019200000xRGjXAAW','','','Account-1','cfsuite1__Property__c-4');
INSERT INTO "cfsuite1__Property_Customer__c" VALUES('cfsuite1__Property_Customer__c-3','Hammy Hampster','','','','','','2025-06-05','','','','','','','113256','Active','Primary','','False','','','a0P9200000LlkwCEAR-0019200000xRGjXAAW','','','Account-1','cfsuite1__Property__c-3');
INSERT INTO "cfsuite1__Property_Customer__c" VALUES('cfsuite1__Property_Customer__c-4','Hammy Hampster','','','','','','2025-05-29','','','Hammy Hampster','','2024-05-07','','100025','Active','Primary','','False','','','a0P9200000LlkcsEAB-0019200000xRGjXAAW','','100025','Account-1','cfsuite1__Property__c-2');
INSERT INTO "cfsuite1__Property_Customer__c" VALUES('cfsuite1__Property_Customer__c-5','Hammy Hampster','','','','2025-12-04','Self Link','','','','','','2025-06-12','','','Active','Secondary','','False','','','a0P9200000LlkwEEAR-0019200000xRGjXAAW','','','Account-1','cfsuite1__Property__c-5');
INSERT INTO "cfsuite1__Property_Customer__c" VALUES('cfsuite1__Property_Customer__c-6','Hilda Hampster','','','','2025-12-01','Account Established','','','','Hilda and Hammy Hampster','','2025-12-01','','345','Active','Primary','','False','','','a0P9200000Llhn1EAB-0019200000ye2NKAAY','','','Account-2','cfsuite1__Property__c-1');
INSERT INTO "cfsuite1__Property_Customer__c" VALUES('cfsuite1__Property_Customer__c-7','Philip Marlowe','','','','2025-12-01','Account Established','','','376845','Philip Marlowe','','2019-05-01','','149412','Active','Primary','','False','','','a0P9200000LlkwDEAR-0019200000yfXGvAAM','','','Account-6','cfsuite1__Property__c-4');
INSERT INTO "cfsuite1__Property_Customer__c" VALUES('cfsuite1__Property_Customer__c-8','Philip Marlowe','','','','2025-12-01','Account Established','','','376845','Philip Marlowe','','2019-05-01','','102225','Active','Primary','','False','','','a0P9200000Llhn1EAB-0019200000yfXGvAAM','','','Account-6','cfsuite1__Property__c-1');
INSERT INTO "cfsuite1__Property_Customer__c" VALUES('cfsuite1__Property_Customer__c-9','Philip Marlowe','','','','2025-12-01','Account Established','','','376845','Philip Marlowe','','2019-05-01','','113256','Active','Primary','','False','','','a0P9200000LlkwCEAR-0019200000yfXGvAAM','','','Account-6','cfsuite1__Property__c-3');
INSERT INTO "cfsuite1__Property_Customer__c" VALUES('cfsuite1__Property_Customer__c-10','Philip Marlowe','','','','2025-12-01','Account Established','','','376845','Philip Marlowe','','2019-05-01','','100025','Active','Primary','','False','','','a0P9200000LlkcsEAB-0019200000yfXGvAAM','','','Account-6','cfsuite1__Property__c-2');
INSERT INTO "cfsuite1__Property_Customer__c" VALUES('cfsuite1__Property_Customer__c-11','Philip Marlowe','','','','','Change of Ownership','','','376845','','','2025-02-04','','87444','Active','Primary','','False','','','a0P9200000MQoFrEAL-0019200000yfXGvAAM','','','Account-6','cfsuite1__Property__c-6');
INSERT INTO "cfsuite1__Property_Customer__c" VALUES('cfsuite1__Property_Customer__c-12','Philip Marlowe','','','','','Change of Ownership','','','376845','Philip Marlowe','','2025-04-10','','999999','Active','Primary','','False','','','a0P9200000MQr2PEAT-0019200000yfXGvAAM','','','Account-6','cfsuite1__Property__c-7');
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
INSERT INTO "cfsuite1__Property__c" VALUES('cfsuite1__Property__c-1','32 Devil Gate Drive TORQUAY 3228 (A)','012Mn0000000hgdIAA','','','','700.0','102225','102225','','1000000.0','','','','','2100.0','','','','','','2025-06-10','','','','','','','Hammy Hampster','','','2025-06-10','','','','','0.0','2025-09-01','','0.0','2025-12-01','','700.0','2026-03-02','','700.0','2026-06-01','','','','','','','','32 Develish Court','','False','','','','','','','345','','0.0','');
INSERT INTO "cfsuite1__Property__c" VALUES('cfsuite1__Property__c-2','1 Accidentally Kelly Street JAN JUC 3228 (A)','012Mn0000000hgdIAA','','','','0.0','100025','100025','','','','','','','0.0','','','','','','','','','','','','','Hammy Hampster','','','2024-05-07','','','','','0.0','2025-09-01','','0.0','2025-12-01','','0.0','2026-03-02','','0.0','2026-06-01','','','','','','','','1 Cadisfly Alley','','False','','','','','','','100025','','0.0','');
INSERT INTO "cfsuite1__Property__c" VALUES('cfsuite1__Property__c-3','37 Electric Avenue TORQUAY 3228 (A)','012Mn0000000hgdIAA','','','','0.0','113256','1132562','','1000000.0','','','','','800.0','','','','','','2024-12-01','','','','','','','Hammy Hampster','','','2026-06-28','','','','','0.0','2025-09-01','','0.0','2025-12-01','','0.0','2026-03-02','','800.0','2026-06-01','','','','','','','','37 Goldberry Street','','False','','','','','','','100006','','0.0','');
INSERT INTO "cfsuite1__Property__c" VALUES('cfsuite1__Property__c-4','21 Jump Street ANGLESEA 3230 (A)','012Mn0000000hgdIAA','','','','0.0','149412','149412','','2100000.0','','','','','2000.0','','','','','','2024-11-14','','','','','','','Hammy Hampster','','','2019-05-01','','','','149412','0.0','2025-09-01','','0.0','2025-12-01','','1000.0','2026-03-02','','1000.0','2026-06-01','','','','','','','','32 Courage Square','','False','','','','','','','100007','','0.0','');
INSERT INTO "cfsuite1__Property__c" VALUES('cfsuite1__Property__c-5','1 Humbdinger avenue (A)','012Mn0000000hgdIAA','','','','0.0','171338','171338','','1000000.0','','','','','-200.0','','','','','','2025-05-29','','','','','','','Hammy Hampster','1008','2025-06-13','2025-06-12','','','','','0.0','2024-06-01','','0.0','2024-12-31','','0.0','2025-03-31','','0.0','2025-06-30','','','','','','','','1 Humbdinger avenue','','False','','','','','','','12347788','','','');
INSERT INTO "cfsuite1__Property__c" VALUES('cfsuite1__Property__c-6','79 Copperhead Road WINCHELSEA 3241 (A)','012Mn0000000hgdIAA','','','','3456.23','87444','','','1850000.0','','','','','4956.23','','','','','','2025-08-06','','','','','','99 - Debt Collection','Mr A & Mrs H Targaryen','','','','','','','','0.0','2025-09-01','','0.0','2025-12-01','','750.0','2026-03-02','','750.0','2026-06-01','','','','','','','','79 Copperhead Road WINCHELSEA 3241','','False','','','','','','','2345123','','','');
INSERT INTO "cfsuite1__Property__c" VALUES('cfsuite1__Property__c-7','52 Penny Lane LORNE 3231 (A)','012Mn0000000hgdIAA','','','','0.0','999999','','','2600000.0','','','','','-260.0','','','','','','2025-07-22','','','','','','','Hammy Hampster','','','','','','','','0.0','2025-09-01','','0.0','2025-12-01','','0.0','2026-03-02','','0.0','2026-06-01','','','','','','','','52 Penny Lane LORNE 3231','','False','','','','','','','12345','','','');
CREATE TABLE "cfsuite1__Property__c_rt_mapping" (
	record_type_id VARCHAR(18) NOT NULL, 
	developer_name VARCHAR(255), 
	is_person_type BOOLEAN, 
	PRIMARY KEY (record_type_id)
);
INSERT INTO "cfsuite1__Property__c_rt_mapping" VALUES('012Mn0000000hgdIAA','Assessment',0);
INSERT INTO "cfsuite1__Property__c_rt_mapping" VALUES('012Mn0000000hgeIAA','Parcel',0);
CREATE TABLE "cfsuite1__Resource__c" (
	id VARCHAR(255) NOT NULL, 
	"Name" VARCHAR(255), 
	"cfsuite1__Description__c" VARCHAR(255), 
	PRIMARY KEY (id)
);
COMMIT;
