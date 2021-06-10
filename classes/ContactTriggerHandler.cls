public class ContactTriggerHandler {
    
    public static void onAfterInsert(Map<Id, Contact> newContacts) {
        Set<Id> contactsIds = newContacts.keySet();
        ContactService.updateContactCountryByPhoneAsync(contactsIds);
    }
}