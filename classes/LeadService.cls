public class LeadService {
    
    @future(callout=true)
    public static void updateLeadCountryByPhoneAsync(Set<Id> leadsIds) {
        List<Lead> leadsToUpdate = new List<Lead>();
        List<Lead> foundLeads = LeadManager.getLeadsById(leadsIds);
        
        for (Lead lead :foundLeads) {
            if (!String.isBlank(lead.Phone)) {
                Lead leadToUpdate = new Lead();
                try {
                    String leadCountry = CalloutHelper.findCountryByPhone(lead.Phone);
                    leadToUpdate.Id = lead.Id;
                    leadToUpdate.Country_from_Phone__c = leadCountry;
                    leadsToUpdate.add(leadToUpdate);
                } catch(CalloutHelper.PhoneFormatException ex) {
                    System.debug(LoggingLevel.ERROR, ex.getMessage());
                }   
            }
        }
        update leadsToUpdate;
    }
    
    public static Account convertToAccountWithContact(Lead leadForConverting) {
        if (leadForConverting == null) {
            return new Account();
        }
        Account newAccount = new Account();
        Contact newContact = new Contact();
        newAccount = AccountService.createAccountFromLead(leadForConverting);
        ContactService.createContactFromLead(leadForConverting, newAccount.Id);
        return newAccount;
    }
}