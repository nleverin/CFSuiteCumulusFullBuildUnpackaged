// CreateRatesTestData.apex
// Sets up test fixtures required for Rates robot tests.
// Customer Community user enablement now lives in EnableCustomerUsers.apex (run during post-install flow).
// This script only fills in property rates data (balances, due dates, financial year) for any property
// where Full_year_balance is null — defensive backup for test orgs missing dataset values.
// Run via: cci task run execute_anon_rates_test_data --org <org>

List<cfsuite1__Property__c> properties = [SELECT Id, Name, cfsuite1__Full_year_balance__c,
    cfsuite1__Financial_Year__c, cfsuite1__Quarter_1_Balance__c, cfsuite1__Quarter_1_Due_Date__c,
    cfsuite1__Quarter_2_Balance__c, cfsuite1__Quarter_2_Due_Date__c,
    cfsuite1__Quarter_3_Balance__c, cfsuite1__Quarter_3_Due_Date__c,
    cfsuite1__Quarter_4_Balance__c, cfsuite1__Quarter_4_Due_Date__c,
    cfsuite1__Name_on_Rates_Notice__c
    FROM cfsuite1__Property__c];

for (cfsuite1__Property__c p : properties) {
    if (p.cfsuite1__Full_year_balance__c == null) {
        p.cfsuite1__Full_year_balance__c = 2400.00;
        p.cfsuite1__Financial_Year__c = '2025';
        p.cfsuite1__Quarter_1_Balance__c = 600.00;
        p.cfsuite1__Quarter_1_Due_Date__c = Date.newInstance(2025, 9, 1);
        p.cfsuite1__Quarter_2_Balance__c = 600.00;
        p.cfsuite1__Quarter_2_Due_Date__c = Date.newInstance(2025, 12, 1);
        p.cfsuite1__Quarter_3_Balance__c = 600.00;
        p.cfsuite1__Quarter_3_Due_Date__c = Date.newInstance(2026, 3, 1);
        p.cfsuite1__Quarter_4_Balance__c = 600.00;
        p.cfsuite1__Quarter_4_Due_Date__c = Date.newInstance(2026, 6, 1);
        if (String.isBlank(p.cfsuite1__Name_on_Rates_Notice__c)) {
            p.cfsuite1__Name_on_Rates_Notice__c = 'Hammy Hampster';
        }
    }
}
update properties;
System.debug('Property fixture pass complete: ' + properties.size() + ' properties scanned');
