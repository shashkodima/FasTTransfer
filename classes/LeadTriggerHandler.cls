public class LeadTriggerHandler {
    
    public static void onAfterInsert(Map<Id, Lead> newLeads) {
        Set<Id> leadsIds = newLeads.keySet();
        LeadService.updateLeadCountryByPhoneAsync(leadsIds);
    }
}