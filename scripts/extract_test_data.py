"""
Extract test data from a Salesforce org and generate CumulusCI dataset files.
Extracts only the data needed for automated rates testing:
- 3 Person Accounts (Hammy, Hilda, Horatio Hampster)
- 5 Properties
- 7 Property Customer relationships
- CFSuiteRatesSettings
- CFSuiteSettings
- CFSuiteIntegrationSettings
- CFSuite_Request_Flow records (rates-related)
- Data_Settings records

Usage:
    python scripts/extract_test_data.py --org dev_namespaced_1
"""

import argparse
import json
import subprocess
import sys
from pathlib import Path


def run_soql(org, query):
    """Run a SOQL query via CCI and return results as JSON."""
    cmd = [
        "cci", "task", "run", "execute_anon",
        "--org", org,
        "-o", "apex",
        f"""
        String jsonResult = JSON.serialize(Database.query('{query}'));
        // Truncate to fit in exception message
        if (jsonResult.length() > 10000) jsonResult = jsonResult.substring(0, 10000);
        throw new System.CalloutException('JSONDATA:' + jsonResult);
        """
    ]
    result = subprocess.run(cmd, capture_output=True, text=True, cwd=Path(__file__).parent.parent)
    output = result.stdout + result.stderr

    # Extract JSON from the exception message
    for line in output.split("\n"):
        if "JSONDATA:" in line:
            json_str = line.split("JSONDATA:", 1)[1].strip()
            # Clean up any trailing stacktrace text
            if "\n" in json_str:
                json_str = json_str.split("\n")[0]
            try:
                return json.loads(json_str)
            except json.JSONDecodeError:
                print(f"WARNING: Could not parse JSON for query: {query}")
                print(f"  Raw: {json_str[:200]}")
                return []
    return []


def escape_sql(value):
    """Escape a value for SQL insertion."""
    if value is None:
        return "NULL"
    if isinstance(value, bool):
        return "1" if value else "0"
    if isinstance(value, (int, float)):
        return str(value)
    # String - escape single quotes
    s = str(value).replace("'", "''")
    return f"'{s}'"


def main():
    parser = argparse.ArgumentParser(description="Extract test data for automated testing")
    parser.add_argument("--org", required=True, help="CumulusCI org alias")
    args = parser.parse_args()

    project_root = Path(__file__).parent.parent
    output_dir = project_root / "datasets" / "automatedTestingData"
    output_dir.mkdir(parents=True, exist_ok=True)

    print("Extracting test data from org:", args.org)
    print("Output directory:", output_dir)

    # Define what to extract
    extracts = {
        "Account": {
            "query": "SELECT Id,FirstName,LastName,Name,PersonEmail,PersonDoNotCall,PersonHasOptedOutOfEmail,PersonHasOptedOutOfFax,RecordTypeId,cfsuite1__Authority_ID__c,cfsuite1__Customer_Type__c,cfsuite1__Preferred_Communication_Method__c,cfsuite1__Rates_notice_notifications__c,cfsuite1__Preferred_Notification_Cases__c FROM Account WHERE IsPersonAccount=true AND Name IN ('Hammy Hampster','Hilda Hampster','Horatio Hampster')",
            "fields": ["FirstName", "LastName", "Name", "PersonEmail", "PersonDoNotCall", "PersonHasOptedOutOfEmail", "PersonHasOptedOutOfFax", "RecordTypeId", "cfsuite1__Authority_ID__c", "cfsuite1__Customer_Type__c", "cfsuite1__Preferred_Communication_Method__c", "cfsuite1__Rates_notice_notifications__c", "cfsuite1__Preferred_Notification_Cases__c"],
        },
        "cfsuite1__Property__c": {
            "query": "SELECT Id,Name,cfsuite1__Assessment_Number__c,cfsuite1__Valuation_Number__c,cfsuite1__Council_value__c,cfsuite1__Full_year_balance__c,cfsuite1__Financial_Year__c,cfsuite1__Quarter_1_Balance__c,cfsuite1__Quarter_1_Due_Date__c,cfsuite1__Quarter_2_Balance__c,cfsuite1__Quarter_2_Due_Date__c,cfsuite1__Quarter_3_Balance__c,cfsuite1__Quarter_3_Due_Date__c,cfsuite1__Quarter_4_Balance__c,cfsuite1__Quarter_4_Due_Date__c,cfsuite1__Name_on_Rates_Notice__c,cfsuite1__Last_evaluated_date__c,cfsuite1__Memo__c FROM cfsuite1__Property__c",
            "fields": ["Name", "cfsuite1__Assessment_Number__c", "cfsuite1__Valuation_Number__c", "cfsuite1__Council_value__c", "cfsuite1__Full_year_balance__c", "cfsuite1__Financial_Year__c", "cfsuite1__Quarter_1_Balance__c", "cfsuite1__Quarter_1_Due_Date__c", "cfsuite1__Quarter_2_Balance__c", "cfsuite1__Quarter_2_Due_Date__c", "cfsuite1__Quarter_3_Balance__c", "cfsuite1__Quarter_3_Due_Date__c", "cfsuite1__Quarter_4_Balance__c", "cfsuite1__Quarter_4_Due_Date__c", "cfsuite1__Name_on_Rates_Notice__c", "cfsuite1__Last_evaluated_date__c", "cfsuite1__Memo__c"],
        },
        "cfsuite1__Property_Customer__c": {
            "query": "SELECT Id,cfsuite1__Customer__c,cfsuite1__Property__c,cfsuite1__Relationship_Type__c,cfsuite1__Relationship_Status__c FROM cfsuite1__Property_Customer__c",
            "fields": ["cfsuite1__Relationship_Type__c", "cfsuite1__Relationship_Status__c"],
            "lookups": {"cfsuite1__Customer__c": "Account", "cfsuite1__Property__c": "cfsuite1__Property__c"},
        },
        "cfsuite1__CFSuiteRatesSettings__c": {
            "query": "SELECT Id,Name FROM cfsuite1__CFSuiteRatesSettings__c LIMIT 1",
            "fields": ["Name"],
            "note": "Full field list needed - using mapping from fullTrialData",
        },
    }

    # For now, generate a simplified approach: use CCI's built-in extract
    # Instead of complex SOQL, let's create the mapping.yml and use cci task run data_extract

    print("\nGenerating dataset files...")
    print("NOTE: This generates the mapping.yml structure.")
    print("To populate data.sql, run: cci task run extract_data --org", args.org)

    # Generate mapping.yml
    mapping_content = generate_mapping()
    mapping_path = output_dir / "mapping.yml"
    with open(mapping_path, "w") as f:
        f.write(mapping_content)
    print(f"Created: {mapping_path}")

    print("\nDone. Next steps:")
    print(f"  1. Run: cci task run extract_dataset -o mapping datasets/automatedTestingData/mapping.yml -o sql_path datasets/automatedTestingData/data.sql --org {args.org}")
    print(f"  2. Or use the CCI task defined in cumulusci.yml")


def generate_mapping():
    """Generate a CumulusCI mapping.yml for the test data."""
    return """# Automated Testing Data - Mapping
# Contains only the data needed for rates automated testing:
# - 3 Person Accounts (Hammy, Hilda, Horatio Hampster)
# - 5 Properties
# - 7 Property Customer relationships
# - CFSuiteRatesSettings
# - CFSuiteSettings
# - CFSuiteIntegrationSettings
# - Request Flow records
# - Data Settings records

Insert Account:
  sf_object: Account
  fields:
  - FirstName
  - LastName
  - Name
  - PersonEmail
  - PersonDoNotCall
  - PersonHasOptedOutOfEmail
  - PersonHasOptedOutOfFax
  - RecordTypeId
  - cfsuite1__Authority_ID__c
  - cfsuite1__Customer_Type__c
  - cfsuite1__Preferred_Communication_Method__c
  - cfsuite1__Rates_notice_notifications__c
  - cfsuite1__Preferred_Notification_Cases__c
  filters:
  - 'IsPersonAccount = true'
  - "Name IN ('Hammy Hampster', 'Hilda Hampster', 'Horatio Hampster')"
  lookups:
    ParentId:
      table:
      - Account
      after: Insert Account

Insert cfsuite1__CFSuiteIntegrationSettings__c:
  sf_object: cfsuite1__CFSuiteIntegrationSettings__c
  fields:
  - Name
  - cfsuite1__GoogleAPIkey__c
  - cfsuite1__RecaptchaSiteKey__c
  - cfsuite1__Recaptcha_Secret_Key__c
  - cfsuite1__Recaptcha_Site_Key__c
  - cfsuite1__Recaptcha_Threshold_Score__c
  - cfsuite1__Recaptcha_Verify_URL__c

Insert cfsuite1__CFSuiteRatesSettings__c:
  sf_object: cfsuite1__CFSuiteRatesSettings__c
  fields:
  - Name
  - cfsuite1__Accepted_Credit_Cards__c
  - cfsuite1__Allow_Agent_Property_Add__c
  - cfsuite1__Allow_Direct_Debit__c
  - cfsuite1__Annual_Balance_Help_Text__c
  - cfsuite1__Auto_Approval_Sub_Reason__c
  - cfsuite1__Auto_Approval_Threshold__c
  - cfsuite1__Biller_Code__c
  - cfsuite1__Business_Name__c
  - cfsuite1__Bypass_Payment_Page__c
  - cfsuite1__Community_Base_URL__c
  - cfsuite1__Community_Login_URL__c
  - cfsuite1__Community_Name__c
  - cfsuite1__Council_Legal_Name__c
  - cfsuite1__Council_Portal_Display_Name__c
  - cfsuite1__Council_Rates_Email_Address__c
  - cfsuite1__Customer_Service_Phone_Rates__c
  - cfsuite1__Customer_Service_Team_Rates__c
  - cfsuite1__DD_Cancellation_Reasons__c
  - cfsuite1__Debt_Collector_Name_Rates__c
  - cfsuite1__Debt_Collector_Phone_Rates__c
  - cfsuite1__Direct_Debit_URL__c
  - cfsuite1__Download_Notice_Named_Credential__c
  - cfsuite1__Extension_Display_Due_Date__c
  - cfsuite1__Extension_Request__c
  - cfsuite1__FAQ_URL__c
  - cfsuite1__Maximum_Payment_Limit__c
  - cfsuite1__Minimum_Arrears_Amount__c
  - cfsuite1__Minimum_Payment_Limit__c
  - cfsuite1__Number_Of_Years_Payments__c
  - cfsuite1__Overdue_Days_Calculation__c
  - cfsuite1__Pay_Trans_Named_Credential__c
  - cfsuite1__Payment_Plan__c
  - cfsuite1__Payment_Transfer_Months_Allowed__c
  - cfsuite1__Portal_Display_Name__c
  - cfsuite1__Rates_Notice_Named_Credential__c
  - cfsuite1__Refund_Credit_Balance__c
  - cfsuite1__Reverse_Payment_Bank__c
  - cfsuite1__Rollover_Date__c
  - cfsuite1__Transfer_Payment__c
  - cfsuite1__Valuation_Objection_URL__c

Insert cfsuite1__CFSuiteSettings__c:
  sf_object: cfsuite1__CFSuiteSettings__c
  fields:
  - Name
  - cfsuite1__Additional_Location_Information__c
  - cfsuite1__Bypass_Recaptcha__c
  - cfsuite1__Case_Details_URL__c
  - cfsuite1__Com_Guest_Usr_URL__c
  - cfsuite1__Community_Profile__c
  - cfsuite1__Community_URL__c
  - cfsuite1__Dashboard_URL__c
  - cfsuite1__Default_Account_Owner__c
  - cfsuite1__Map_Default_Lat__c
  - cfsuite1__Map_Default_Long__c
  - cfsuite1__Map_Default_Zoom__c
  - cfsuite1__My_Requests_URL__c
  - cfsuite1__Portal_Display_Name__c
  - cfsuite1__SLA_Display_Type__c

Insert cfsuite1__Property__c:
  sf_object: cfsuite1__Property__c
  fields:
  - Name
  - cfsuite1__Assessment_Number__c
  - cfsuite1__Valuation_Number__c
  - cfsuite1__Council_value__c
  - cfsuite1__Full_year_balance__c
  - cfsuite1__Financial_Year__c
  - cfsuite1__Quarter_1_Balance__c
  - cfsuite1__Quarter_1_Due_Date__c
  - cfsuite1__Quarter_2_Balance__c
  - cfsuite1__Quarter_2_Due_Date__c
  - cfsuite1__Quarter_3_Balance__c
  - cfsuite1__Quarter_3_Due_Date__c
  - cfsuite1__Quarter_4_Balance__c
  - cfsuite1__Quarter_4_Due_Date__c
  - cfsuite1__Name_on_Rates_Notice__c
  - cfsuite1__Last_evaluated_date__c

Insert cfsuite1__Property_Customer__c:
  sf_object: cfsuite1__Property_Customer__c
  fields:
  - cfsuite1__Relationship_Type__c
  - cfsuite1__Relationship_Status__c
  lookups:
    cfsuite1__Customer__c:
      table: Account
    cfsuite1__Property__c:
      table: cfsuite1__Property__c

Insert cfsuite1__Data_Settings__c:
  sf_object: cfsuite1__Data_Settings__c
  fields:
  - Name
  - RecordTypeId
  - cfsuite1__Active__c
  - cfsuite1__Description__c
  - cfsuite1__Display_Order__c
  - cfsuite1__Is_Start__c
  - cfsuite1__Next_Step__c
  - cfsuite1__Response_Value__c
  lookups:
    cfsuite1__GRP__c:
      table: cfsuite1__Data_Settings__c
    cfsuite1__Next_Data_Setting__c:
      table: cfsuite1__Data_Settings__c

Insert cfsuite1__CFSuite_Request_Flow__c:
  sf_object: cfsuite1__CFSuite_Request_Flow__c
  fields:
  - Name
  - RecordTypeId
  - cfsuite1__Active__c
  - cfsuite1__Case_Category__c
  - cfsuite1__Case_Origin__c
  - cfsuite1__Case_Record_Type__c
  - cfsuite1__Case_Record_Type_Transition__c
  - cfsuite1__Category_Type__c
  - cfsuite1__Community_Description__c
  - cfsuite1__Community_Image_Tag__c
  - cfsuite1__Department__c
  - cfsuite1__Determine_Work_Category__c
  - cfsuite1__Display_Order__c
  - cfsuite1__Division__c
  - cfsuite1__Entitlement_Process__c
  - cfsuite1__Form_Type__c
  - cfsuite1__Icon__c
  - cfsuite1__Notification_Method_Required__c
  - cfsuite1__Owner_Queue__c
  - cfsuite1__SLA__c
  - cfsuite1__Sub_Reason__c
  - cfsuite1__Team__c
  - cfsuite1__Work_Category__c
  lookups:
    cfsuite1__Category_Journey__c:
      table: cfsuite1__CFSuite_Request_Flow__c
    cfsuite1__Display_Category__c:
      table: cfsuite1__CFSuite_Request_Flow__c
"""


if __name__ == "__main__":
    main()
