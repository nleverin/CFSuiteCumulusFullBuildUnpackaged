List<Entitlement> entUpdateList = new List<Entitlement>();
List<Account> accounts = new List<Account>();
List<BusinessHours> busHours = new List<BusinessHours>();
Id accountId;
busHours = [SELECT Id FROM BusinessHours WHERE IsDefault=true];
Set<String> entList = new Set<String>();
Map<String, Id> entProc = new Map<String, Id>();
for(slaProcess sl : [Select Id, Name from SlaProcess where Name IN ('community compliance', 'finance_rates') ])
{
    if(!entProc.keyset().contains(sl.Name))
    {
        entProc.put(sl.Name, sl.Id);
    }
}
Id recordTypeId;
for(RecordType rt : [SELECT Name, DeveloperName FROM RecordType WHERE sObjectType = 'Account' and IsActive = true ])
{
    if(rt.Name.contains('Business'))
    {
        recordTypeId = rt.Id;
        break;
    }
}
Account ac = new Account();
ac.recordTypeId = recordTypeId;
ac.Name = 'Entitlement_Owner';
insert ac;
accountId = ac.Id;
for(String en : entProc.keyset())
{
    Entitlement ent = new Entitlement();
    ent.AccountId = accountId;
    if(busHours.size() > 0)
    {
        ent.BusinessHoursId = busHours[0].Id;
    }
    ent.StartDate = System.today();
    ent.EndDate = System.Now().addYears(1).date();
    if(en == 'community compliance')
    {
        ent.Name = 'Community Compliance';
    }
    if(en == 'finance_rates')
    {
        ent.Name = 'Finance Rates';
    }
    else
    {
        ent.Name = en;
    }
    

    ent.Type = 'Phone Support';
    ent.SlaProcessId = entProc.get(en);
    entUpdateList.add(ent);
    
}
if(entUpdateList.size() > 0 )
{
    insert entUpdateList;
}