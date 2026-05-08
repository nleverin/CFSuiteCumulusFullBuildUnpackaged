BEGIN TRANSACTION;
CREATE TABLE "Account" (
	id VARCHAR(255) NOT NULL, 
	"FirstName" VARCHAR(255), 
	"LastName" VARCHAR(255), 
	"Name" VARCHAR(255), 
	"PersonEmail" VARCHAR(255), 
	"PersonDoNotCall" VARCHAR(255), 
	"PersonHasOptedOutOfEmail" VARCHAR(255), 
	"PersonHasOptedOutOfFax" VARCHAR(255), 
	"RecordTypeId" VARCHAR(255), 
	"cfsuite1__Authority_ID__c" VARCHAR(255), 
	"cfsuite1__Customer_Type__c" VARCHAR(255), 
	"cfsuite1__Preferred_Communication_Method__c" VARCHAR(255), 
	"cfsuite1__Rates_notice_notifications__c" VARCHAR(255), 
	"cfsuite1__Preferred_Notification_Cases__c" VARCHAR(255), 
	"IsPersonAccount" VARCHAR(255), 
	"ParentId" VARCHAR(255), 
	PRIMARY KEY (id)
);
INSERT INTO "Account" VALUES('Account-1','','','Sample Account for Entitlements','','False','False','False','','','','','','','False','');
INSERT INTO "Account" VALUES('Account-2','','','Entitlement_Owner','','False','False','False','012Ru00000ErcWvIAJ','','','Mail','No Notifications','','False','');
INSERT INTO "Account" VALUES('Account-3','Hammy','Hampster','','hammy.hampster@test.example.com','False','False','False','012Ru00000ErcWwIAJ','302300','','','No Notifications','','True','');
INSERT INTO "Account" VALUES('Account-4','Hilda','Hampster','','hugh@ennovative.com.au','False','False','False','012Ru00000ErcWwIAJ','','','','No Notifications','','True','');
INSERT INTO "Account" VALUES('Account-5','Horatio','Hampster','','hugh@ennovative.com.au','False','False','False','012Ru00000ErcWwIAJ','','','','No Notifications','','True','');
CREATE TABLE "Account_rt_mapping" (
	record_type_id VARCHAR(18) NOT NULL, 
	developer_name VARCHAR(255), 
	is_person_type BOOLEAN, 
	PRIMARY KEY (record_type_id)
);
INSERT INTO "Account_rt_mapping" VALUES('012Ru00000ErcWvIAJ','Business_Account',0);
INSERT INTO "Account_rt_mapping" VALUES('012Ru00000ErcWwIAJ','PersonAccount',1);
INSERT INTO "Account_rt_mapping" VALUES('012Ru00000ErcwjIAB','Business',0);
INSERT INTO "Account_rt_mapping" VALUES('012Ru00000ErcwkIAB','Overseas_Business',0);
INSERT INTO "Account_rt_mapping" VALUES('012Ru00000ErcxFIAR','Employee',1);
INSERT INTO "Account_rt_mapping" VALUES('012Ru00000ErcxGIAR','Overseas_Customer',1);
INSERT INTO "Account_rt_mapping" VALUES('012Ru00000ErdO9IAJ','Business_Account',0);
CREATE TABLE "cfsuite1__CFSuite_Request_Flow__c" (
	id VARCHAR(255) NOT NULL, 
	"Name" VARCHAR(255), 
	"RecordTypeId" VARCHAR(255), 
	"cfsuite1__Case_Category__c" VARCHAR(255), 
	"cfsuite1__Category_Type__c" VARCHAR(255), 
	"cfsuite1__Department__c" VARCHAR(255), 
	"cfsuite1__Form_Type__c" VARCHAR(255), 
	"cfsuite1__SLA__c" VARCHAR(255), 
	"cfsuite1__Team__c" VARCHAR(255), 
	"cfsuite1__Work_Category__c" VARCHAR(255), 
	"cfsuite1__Category_Journey__c" VARCHAR(255), 
	"cfsuite1__Display_Category__c" VARCHAR(255), 
	PRIMARY KEY (id)
);
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-1','CJ - Animals - Dog and Cat - Unauthorised Breeder','012Ru00000ErcwyIAB','Animals','','Environmental Health and Community Compliance','Map','1','Community Compliance','','','cfsuite1__CFSuite_Request_Flow__c-10');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-2','CA - Animals - Dog - Noise','012Ru00000ErcwwIAB','Animals','','Environmental Health and Community Compliance','Deflection','60','Community Compliance','','cfsuite1__CFSuite_Request_Flow__c-3','');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-3','CJ - Animals - Dog - Noise','012Ru00000ErcwyIAB','Animals','','Environmental Health and Community Compliance','Deflection','1','Community Compliance','','','cfsuite1__CFSuite_Request_Flow__c-10');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-4','CJ - Footpaths - Maintenance - Repair','012Ru00000ErcwyIAB','Footpaths','Request','Environmental Health and Community Compliance','Map','2','Community Compliance','','','');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-5','CA - Councillor Question','012Ru00000ErcwwIAB','Councillor Question','','','Deflection','10','','','cfsuite1__CFSuite_Request_Flow__c-18','');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-6','CJ - Animals - Dog - Wandering at Large','012Ru00000ErcwyIAB','Animals','','Environmental Health and Community Compliance','Map','1','Community Compliance','','','cfsuite1__CFSuite_Request_Flow__c-10');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-7','CA - Animals - Dog and Cat - Unauthorised Breeder','012Ru00000ErcwwIAB','Animals','Request','Environmental Health and Community Compliance','Map','10','Community Compliance','','cfsuite1__CFSuite_Request_Flow__c-1','');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-8','DC - Finance - Update Personal Details','012Ru00000ErcwzIAB','Finance - Update Personal Details','Request','','','','','','','');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-9','CA - Animals - Dog - Wandering at Large','012Ru00000ErcwwIAB','Animals','','Environmental Health and Community Compliance','Deflection','1','Community Compliance','','cfsuite1__CFSuite_Request_Flow__c-6','');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-10','DC - Animals','012Ru00000ErcwzIAB','Animals','Request','','','','','','','');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-11','DC - Bill Posting','012Ru00000ErcwzIAB','Bill Posting','Request','','','','','','','');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-12','CJ - Bills Posting - Unauthorised - South','012Ru00000ErcwyIAB','Bill Posting','Request','Environmental Health and Community Compliance','Map','2','Community Compliance','','','cfsuite1__CFSuite_Request_Flow__c-11');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-13','CA - Bills Posting - Unauthorised - South','012Ru00000ErcwwIAB','Bill Posting','Request','Environmental Health and Community Compliance','Map','90','Community Compliance','','cfsuite1__CFSuite_Request_Flow__c-12','cfsuite1__CFSuite_Request_Flow__c-11');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-14','CJ - Bills Posting - Unauthorised - North','012Ru00000ErcwyIAB','Bill Posting','Request','Environmental Health and Community Compliance','Map','2','Community Compliance','','','cfsuite1__CFSuite_Request_Flow__c-11');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-15','CA - Bills Posting - Unauthorised - North','012Ru00000ErcwwIAB','Bill Posting','Request','Environmental Health and Community Compliance','Map','40','Community Compliance','','cfsuite1__CFSuite_Request_Flow__c-14','cfsuite1__CFSuite_Request_Flow__c-11');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-16','CA - Finance - Update Personal Details - Business Name','012Ru00000ErcwwIAB','Finance - Update Personal Details','Request','Finance','Deflection','2','Property and Rating','','cfsuite1__CFSuite_Request_Flow__c-17','cfsuite1__CFSuite_Request_Flow__c-8');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-17','CJ - Finance - Update Personal Details - Business Name','012Ru00000ErcwyIAB','Finance - Update Personal Details','Request','Finance','Deflection','1','Property and Rating','','','cfsuite1__CFSuite_Request_Flow__c-8');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-18','CJ - Councillor Question','012Ru00000ErcwyIAB','Councillor Question','Request','','Deflection','2','','','','cfsuite1__CFSuite_Request_Flow__c-19');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-19','DC - Councillor Question','012Ru00000ErcwzIAB','Councillor Question','Request','','','','','','','');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-20','CA - Footpaths - Maintenance - Repair','012Ru00000ErcwwIAB','Footpaths','Request','Environmental Health and Community Compliance','Map','60','Community Compliance','','cfsuite1__CFSuite_Request_Flow__c-4','');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-21','DC - Footpaths','012Ru00000ErcwzIAB','Footpaths','Request','','','','','','','');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-22','CA - Animals - Dog - Keeping Excess Dogs','012Ru00000ErcwwIAB','Animals','Request','Environmental Health and Community Compliance','Map','5','Community Compliance','','cfsuite1__CFSuite_Request_Flow__c-23','cfsuite1__CFSuite_Request_Flow__c-10');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-23','CJ - Animals - Dog - Keeping Excess Dogs','012Ru00000ErcwyIAB','Animals','Request','Environmental Health and Community Compliance','Map','1','Community Compliance','','','cfsuite1__CFSuite_Request_Flow__c-10');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-24','Rates - Reverse Payment (Bank)','012Ru00000ErcwzIAB','Rates - Reverse Payment (Bank)','','','','','','','','');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-25','Rates - Extension Request','012Ru00000ErcwzIAB','Rates - Extension Request','','','','','','','','');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-26','Rates - Missing Payment','012Ru00000ErcwzIAB','Rates - Missing Payment','','','','','','','','');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-27','Rates - Payment Plan','012Ru00000ErcwzIAB','Rates - Payment Plan','','','','','','','','');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-28','Rates - Refund Credit Balance','012Ru00000ErcwzIAB','Rates - Refund Credit Balance','','','','','','','','');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-29','Rates - Reverse Payment (Bank)','012Ru00000ErcwzIAB','Rates - Reverse Payment (Bank)','','','','','','','','');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-30','Rates - Reverse Payment (Source)','012Ru00000ErcwzIAB','Rates - Reverse Payment (Source)','','','','','','','','');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-31','Rates - Transfer Payment','012Ru00000ErcwzIAB','Rates - Transfer Payment','','','','','','','','');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-32','CJ-Rates - Extension Request-Financial Hardship----','012Ru00000ErcwyIAB','Rates - Extension Request','','Finance','Map','5','Property and Rating','','','cfsuite1__CFSuite_Request_Flow__c-25');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-33','CJ-Rates - Extension Request-Non-receipt of Rates Notice----','012Ru00000ErcwyIAB','Rates - Extension Request','','Finance','Map','5','Property and Rating','','','cfsuite1__CFSuite_Request_Flow__c-25');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-34','CJ-Rates - Extension Request-Previous Good Payment History----','012Ru00000ErcwyIAB','Rates - Extension Request','','Finance','Map','5','Property and Rating','','','cfsuite1__CFSuite_Request_Flow__c-25');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-35','CJ-Rates - Extension Request-Sickness, Accident or Hospitalisation----','012Ru00000ErcwyIAB','Rates - Extension Request','','Finance','Map','5','Property and Rating','','','cfsuite1__CFSuite_Request_Flow__c-25');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-36','CJ-Rates - Extension Request-Other----','012Ru00000ErcwyIAB','Rates - Extension Request','','Finance','Map','5','Property and Rating','','','cfsuite1__CFSuite_Request_Flow__c-25');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-37','CJ-Rates - Missing Payment-----','012Ru00000ErcwyIAB','Rates - Missing Payment','','Finance','Map','5','Property and Rating','','','cfsuite1__CFSuite_Request_Flow__c-26');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-38','CJ-Rates - Payment Plan-----','012Ru00000ErcwyIAB','Rates - Payment Plan','','Finance','Map','5','Property and Rating','','','cfsuite1__CFSuite_Request_Flow__c-27');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-39','CJ-Rates - Refund Credit Balance-----','012Ru00000ErcwyIAB','Rates - Refund Credit Balance','','Finance','Map','5','Property and Rating','','','cfsuite1__CFSuite_Request_Flow__c-28');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-40','CJ-Rates - Reverse Payment (Bank)-----','012Ru00000ErcwyIAB','Rates - Reverse Payment (Bank)','','Finance','Map','5','Property and Rating','','','cfsuite1__CFSuite_Request_Flow__c-29');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-41','CJ-Rates - Reverse Payment (Source)-----','012Ru00000ErcwyIAB','Rates - Reverse Payment (Source)','','Finance','Map','5','Property and Rating','','','cfsuite1__CFSuite_Request_Flow__c-30');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-42','CJ-Rates - Transfer Payment-----','012Ru00000ErcwyIAB','Rates - Transfer Payment','','Finance','Map','5','Property and Rating','','','cfsuite1__CFSuite_Request_Flow__c-31');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-43','CA-Rates - Extension Request-Financial Hardship----','012Ru00000ErcwwIAB','Rates - Extension Request','','Finance','Deflection','5','Property and Rating','','cfsuite1__CFSuite_Request_Flow__c-32','');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-44','CA-Rates - Extension Request-Non-receipt of Rates Notice----','012Ru00000ErcwwIAB','Rates - Extension Request','','Finance','Deflection','5','Property and Rating','','cfsuite1__CFSuite_Request_Flow__c-33','');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-45','CA-Rates - Extension Request-Previous Good Payment History----','012Ru00000ErcwwIAB','Rates - Extension Request','','Finance','Deflection','5','Property and Rating','','cfsuite1__CFSuite_Request_Flow__c-34','');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-46','CA-Rates - Extension Request-Sickness, Accident or Hospitalisation----','012Ru00000ErcwwIAB','Rates - Extension Request','','Finance','Deflection','5','Property and Rating','','cfsuite1__CFSuite_Request_Flow__c-35','');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-47','CA-Rates - Extension Request-Other----','012Ru00000ErcwwIAB','Rates - Extension Request','','Finance','Deflection','5','Property and Rating','','cfsuite1__CFSuite_Request_Flow__c-36','');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-48','CA-Rates - Missing Payment-----','012Ru00000ErcwwIAB','Rates - Missing Payment','','Finance','Deflection','5','Property and Rating','','cfsuite1__CFSuite_Request_Flow__c-37','');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-49','CA-Rates - Payment Plan-----','012Ru00000ErcwwIAB','Rates - Payment Plan','','Finance','Deflection','5','Property and Rating','','cfsuite1__CFSuite_Request_Flow__c-38','');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-50','CA-Rates - Refund Credit Balance-----','012Ru00000ErcwwIAB','Rates - Refund Credit Balance','','Finance','Deflection','5','Property and Rating','','cfsuite1__CFSuite_Request_Flow__c-39','');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-51','CA-Rates - Reverse Payment (Bank)-----','012Ru00000ErcwwIAB','Rates - Reverse Payment (Bank)','','Finance','Deflection','5','Property and Rating','','cfsuite1__CFSuite_Request_Flow__c-40','');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-52','CA-Rates - Reverse Payment (Source)-----','012Ru00000ErcwwIAB','Rates - Reverse Payment (Source)','','Finance','Deflection','5','Property and Rating','','cfsuite1__CFSuite_Request_Flow__c-41','');
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c" VALUES('cfsuite1__CFSuite_Request_Flow__c-53','CA-Rates - Transfer Payment-----','012Ru00000ErcwwIAB','Rates - Transfer Payment','','Finance','Deflection','5','Property and Rating','','cfsuite1__CFSuite_Request_Flow__c-42','');
CREATE TABLE "cfsuite1__CFSuite_Request_Flow__c_rt_mapping" (
	record_type_id VARCHAR(18) NOT NULL, 
	developer_name VARCHAR(255), 
	is_person_type BOOLEAN, 
	PRIMARY KEY (record_type_id)
);
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c_rt_mapping" VALUES('012Ru00000ErcwwIAB','Case_Assignment',0);
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c_rt_mapping" VALUES('012Ru00000ErcwxIAB','Case_Mapping',0);
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c_rt_mapping" VALUES('012Ru00000ErcwyIAB','Category_Journey',0);
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c_rt_mapping" VALUES('012Ru00000ErcwzIAB','Display_Category',0);
INSERT INTO "cfsuite1__CFSuite_Request_Flow__c_rt_mapping" VALUES('012Ru00000Ercx0IAB','Work_Order_Mapping',0);
CREATE TABLE "cfsuite1__Property_Customer__c" (
	id VARCHAR(255) NOT NULL, 
	"cfsuite1__Relationship_Type__c" VARCHAR(255), 
	"cfsuite1__Relationship_Status__c" VARCHAR(255), 
	"cfsuite1__Customer__c" VARCHAR(255), 
	"cfsuite1__Property__c" VARCHAR(255), 
	PRIMARY KEY (id)
);
INSERT INTO "cfsuite1__Property_Customer__c" VALUES('cfsuite1__Property_Customer__c-1','Primary','Active','Account-3','cfsuite1__Property__c-1');
INSERT INTO "cfsuite1__Property_Customer__c" VALUES('cfsuite1__Property_Customer__c-2','Primary','Active','Account-3','cfsuite1__Property__c-2');
INSERT INTO "cfsuite1__Property_Customer__c" VALUES('cfsuite1__Property_Customer__c-3','Secondary','Active','Account-3','cfsuite1__Property__c-3');
INSERT INTO "cfsuite1__Property_Customer__c" VALUES('cfsuite1__Property_Customer__c-4','Previous Primary','Active','Account-3','cfsuite1__Property__c-4');
INSERT INTO "cfsuite1__Property_Customer__c" VALUES('cfsuite1__Property_Customer__c-5','Primary','Active','Account-3','cfsuite1__Property__c-5');
INSERT INTO "cfsuite1__Property_Customer__c" VALUES('cfsuite1__Property_Customer__c-6','Secondary','Active','Account-4','cfsuite1__Property__c-1');
INSERT INTO "cfsuite1__Property_Customer__c" VALUES('cfsuite1__Property_Customer__c-7','Agent','Active','Account-5','cfsuite1__Property__c-2');
CREATE TABLE "cfsuite1__Property__c" (
	id VARCHAR(255) NOT NULL, 
	"Name" VARCHAR(255), 
	"cfsuite1__Assessment_Number__c" VARCHAR(255), 
	"cfsuite1__Valuation_Number__c" VARCHAR(255), 
	"cfsuite1__Council_value__c" VARCHAR(255), 
	"cfsuite1__Full_year_balance__c" VARCHAR(255), 
	"cfsuite1__Financial_Year__c" VARCHAR(255), 
	"cfsuite1__Quarter_1_Balance__c" VARCHAR(255), 
	"cfsuite1__Quarter_1_Due_Date__c" VARCHAR(255), 
	"cfsuite1__Quarter_2_Balance__c" VARCHAR(255), 
	"cfsuite1__Quarter_2_Due_Date__c" VARCHAR(255), 
	"cfsuite1__Quarter_3_Balance__c" VARCHAR(255), 
	"cfsuite1__Quarter_3_Due_Date__c" VARCHAR(255), 
	"cfsuite1__Quarter_4_Balance__c" VARCHAR(255), 
	"cfsuite1__Quarter_4_Due_Date__c" VARCHAR(255), 
	"cfsuite1__Name_on_Rates_Notice__c" VARCHAR(255), 
	"cfsuite1__Last_evaluated_date__c" VARCHAR(255), 
	PRIMARY KEY (id)
);
INSERT INTO "cfsuite1__Property__c" VALUES('cfsuite1__Property__c-1','37 Goldberry Street (A)','113256','100006','1000000.0','300.0','','0.0','2024-01-09','0.0','2024-01-12','100.0','2025-01-03','100.0','2025-01-06','Hammy Hampster','2024-12-01');
INSERT INTO "cfsuite1__Property__c" VALUES('cfsuite1__Property__c-2','1 Cadisfly Alley (A)','100025','100025','','4000000000.0','','0.0','2025-09-01','1000000.0','2025-12-01','1000000.0','2026-03-01','10000000.0','2026-06-01','Hammy Hampster','');
INSERT INTO "cfsuite1__Property__c" VALUES('cfsuite1__Property__c-3','32 Courage Square (A)','149412','100007','','100.0','','100.0','2024-09-30','100.0','2024-12-31','100.5','2025-03-31','100.0','2025-06-30','Hammy Hampster','');
INSERT INTO "cfsuite1__Property__c" VALUES('cfsuite1__Property__c-4','1 Humbdinger avenue (A)','171338','12347788','1000000.0','-200.0','','0.0','2024-06-01','0.0','2024-12-31','0.0','2025-03-31','0.0','2025-06-30','Hammy Hampster','2025-05-29');
INSERT INTO "cfsuite1__Property__c" VALUES('cfsuite1__Property__c-5','32 Develish Court (A)','345','345','1000000.0','100.0','','0.0','2024-09-30','0.0','2024-12-31','0.0','2025-03-30','100.0','2025-06-30','Hammy Hampster','2025-06-10');
COMMIT;
