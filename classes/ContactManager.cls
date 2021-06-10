public class ContactManager {
    
    public static List<Contact> getContactsById(Set<Id> contactsIds) {
        if (contactsIds.isEmpty() || contactsIds == null) {
            return new List<Contact>();
        }
        List<Contact> foundContacts = [
            SELECT Id,
            Phone
            FROM Contact
            WHERE Id IN :contactsIds
        ];
        return foundContacts;
    }
    
    public static List<Contact> getContactById(String contactId) {
        if (String.isBlank(contactId)) {
            return new List<Contact>(); 
        }
        List<Contact> foundContact = [
            SELECT Id
            FROM Contact
            WHERE Id = :contactId
        ];
        return foundContact;
    }
    
    public static Contact getContact(String contactId) {
        if (String.isBlank(contactId)) {
            return new Contact(); 
        }
        Contact foundContact = [
            SELECT Id,
            AccountId
            FROM Contact
            WHERE Id = :contactId
        ];
        return foundContact;
    }
    
    public static List<Contact> getContactsByEmailOrPhone(String email, String phone) {
        if (String.isBlank(email) && String.isBlank(phone)) {
            return new List<Contact>();
        }
        List<Contact> foundContacts = [
            SELECT Id,
            OwnerId,
            Phone,
            AccountId
            FROM Contact
            WHERE Phone = :phone
            OR Email = :email
            LIMIT 1
        ];
        return foundContacts;
    }
}