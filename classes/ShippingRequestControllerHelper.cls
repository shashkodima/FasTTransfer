public class ShippingRequestControllerHelper {
    
    public static Account findAccountRelatedToUser(String authorizedUserId) {
        User authorizedUser = UserManager.getUserById(authorizedUserId);
        String relatedContactId = authorizedUser.ContactId;
        Contact relatedContact = ContactManager.getContact(relatedContactId);
        String relatedAccountId = relatedContact.AccountId;
        Account relatedAccount = AccountManager.getAccount(relatedAccountId);
        return relatedAccount;
    }
    
    public static Account checkEmailPhoneExistInDatabase(ShippingRequestWrapper dataFromRequest) {
        Account relatedAccount;
        List<Contact> relatedContacts = ContactManager.getContactsByEmailOrPhone(dataFromRequest.contactEmail, dataFromRequest.contactPhone);
        List<Lead> relatedLeads = LeadManager.getLeadsByEmailOrPhone(dataFromRequest.contactEmail, dataFromRequest.contactPhone); 
        
        if (!(relatedContacts.isEmpty() || relatedContacts == null)) {
            TaskService.createTaskForContact(relatedContacts[0], dataFromRequest);
            String relatedAccountId = relatedContacts[0].AccountId;
            relatedAccount = AccountManager.getAccount(relatedAccountId);            
        } else if (!(relatedLeads.isEmpty() || relatedLeads == null)) {
            relatedAccount = LeadService.convertToAccountWithContact(relatedLeads[0]);
            relatedLeads[0].Status = Constants.STATUS_CLOSED_CONVERTED;
            update relatedLeads[0];
        } else {
            List<Account> relatedAccounts = AccountManager.getAccountsByEmail(dataFromRequest.companyEmail);
            if (!(relatedAccounts.isEmpty() || relatedAccounts == null)) {
                relatedAccount = relatedAccounts[0];
                ContactService.createContactFromShippingRequest(relatedAccount, dataFromRequest);
            }
        }        
        return relatedAccount;
    }
}