public class ContactService {
    
    @future(callout=true)
    public static void updateContactCountryByPhoneAsync(Set<Id> contactsIds) {
        List<Contact> contactsToUpdate = new List<Contact>();
        List<Contact> foundContacts = ContactManager.getContactsById(contactsIds);
        
        for (Contact contact :foundContacts) {
            if (!String.isBlank(contact.Phone)) {
                Contact contactToUpdate = new Contact();
                try {
                    String contactCountry = CalloutHelper.findCountryByPhone(contact.Phone);
                    contactToUpdate.Id = contact.Id;
                    contactToUpdate.Country_from_Phone__c = contactCountry;
                    contactsToUpdate.add(contactToUpdate);
                } catch(CalloutHelper.PhoneFormatException ex) {
                    System.debug(LoggingLevel.ERROR, ex.getMessage());
                }   
            }
        }
        update contactsToUpdate;
    }
    
    public static void createContactFromShippingRequest (Account relatedAccount, ShippingRequestWrapper requestData) {
        if (relatedAccount == null || requestData == null)  {
            return;
        }
        Contact newContact = new Contact();
        newContact.AccountId = relatedAccount.Id;
        newContact.Email = requestData.contactEmail;
        newContact.Language__c = Constants.ENGLISH_LANGUAGE;
        newContact.Phone = requestData.contactPhone;
        newContact.FirstName = requestData.contactFirstName;
        newContact.LastName = requestData.contactLastName; 
        insert newContact;
    }
    
    public static void createContactFromLead(Lead leadForConverting, String accountId) {
        if (leadForConverting == null || String.isBlank(accountId)) {
            return;
        }
        Contact newContact = new Contact();
        newContact.AccountId = accountId;
        newContact.Email = leadForConverting.Email;
        newContact.Phone = leadForConverting.Phone;
        newContact.FirstName = leadForConverting.FirstName;
        newContact.LastName = leadForConverting.LastName;
        insert newContact;
    }
}