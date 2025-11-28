/**
 * @description       : 
 * @author            : hugh Wheeler
 * @group             : 
 * @last modified on  : 05-15-2025
 * @last modified by  : hugh Wheeler
**/
public with sharing class PaymentPlanPDF
{
    public Id pcId{get;set;}
    public List<PaymentPlanPDF.PaymentPlanWrapper> ppDetails {get;set;}
    public String startDate {get;set;}
    public String frequency {get;set;}
    public Decimal gTotal {get;set;}
    public String CustomLogoBlack {get;set;}
    public String CustomLogoWhite {get;set;}
    
    public PaymentPlanPDF(){
        gTotal = 0.0;
        if(Apexpages.currentPage().getParameters().get('Id') != null){
            pcId = Apexpages.currentPage().getParameters().get('Id');
        }
        cfsuite1__CFSuiteRatesSettings__c defaultSettings = cfsuite1__CFSuiteRatesSettings__c.getInstance(userinfo.getProfileId());
        CustomLogoBlack = defaultSettings.cfsuite1__Custom_Logo_Black__c;
        CustomLogoWhite = defaultSettings.cfsuite1__Custom_Logo_White__c;
        
        cfsuite1__Property_Customer__c pc = [select Id, cfsuite1__Property__c, cfsuite1__Customer__c from cfsuite1__Property_Customer__c where Id=:pcId];
        
        List<Case> payPlans = [Select Id, Status from case where cfsuite1__cfReq_Category__c =: defaultSettings.cfsuite1__Payment_Plan__c and accountId = : pc.cfsuite1__Customer__c and cfsuite1__Transfer_From__c =: pc.cfsuite1__Property__c order by CreatedDate desc Limit 1];
        
        List<cfsuite1__Installment_Plan__c> iplan = [Select Id, cfsuite1__Start_Date__c, cfsuite1__End_Date__c, cfsuite1__Amount__c, cfsuite1__Frequency__c from cfsuite1__Installment_Plan__c where cfsuite1__Case__c =: payPlans[0].Id limit 1]; 
        
        if(iplan.size() > 0)
        {
            startDate = iplan[0].cfsuite1__Start_Date__c.day() + '/' + iplan[0].cfsuite1__Start_Date__c.month() + '/' + iplan[0].cfsuite1__Start_Date__c.year();
            frequency = iplan[0].cfsuite1__Frequency__c;
            ppDetails = buildPlan(iplan[0].cfsuite1__Start_Date__c, iplan[0].cfsuite1__End_Date__c, iplan[0].cfsuite1__Amount__c,iplan[0].cfsuite1__Frequency__c );

            for(PaymentPlanWrapper ppw : ppDetails)
            {
                gTotal = gTotal + ppw.amount;
            }
        }
        
        
    }
    
    public static List<PaymentPlanWrapper> buildPlan(Date startDate, Date endDate, Decimal amount, String frequency)
    {
        List<PaymentPlanWrapper> plan = new List<PaymentPlanWrapper>();
        Date currentDate = startDate;
        Integer incrementDays;

        switch on frequency.toLowerCase() {
            when 'weekly' {
                incrementDays = 7;
            }
            when 'fortnightly' {
                incrementDays = 14;
            }
            when 'monthly' {
                // We'll handle this differently
                incrementDays = null;
            }
            when else {
                return plan; // Invalid frequency
            }
        }

        while (currentDate <= endDate) {
            PaymentPlanWrapper planEntry = new PaymentPlanWrapper();
            planEntry.dueDate = currentDate.day() + '/' + currentDate.month() + '/' + currentDate.year();
            planEntry.amount= amount;
            if (frequency.toLowerCase() == 'monthly') 
            {
                currentDate = currentDate.addMonths(1);
            } 
            else 
            {
                currentDate = currentDate.addDays(incrementDays);
            }
            plan.add(planEntry);
        }

        return plan;
    } 
    
    
    public class PaymentPlanWrapper{
        public String dueDate{get;set;}
        public Decimal amount{get;set;}
    }
    
    

}