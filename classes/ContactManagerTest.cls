@IsTest
private class ContactManagerTest {
    
    @TestSetup
    private static void setup() {
        TestDataFactory.createContacts();    
    }
    
    @IsTest
    private static void testGetContactsById() {
        List<Contact> testContacts = getTestContacts();
        Id testId = testContacts[0].Id;
        Set<Id> testIds = new Set<Id>();
        testIds.add(testId);
        List<Contact> foundContact = ContactManager.getContactsById(testIds);
        System.assertEquals(testContacts[0].Id, foundContact[0].Id);
    }
    
    @IsTest
    private static void testGetContactsByIdNullParam() {
        Set<Id> testIds = new Set<Id>();
        List<Contact> foundContact = ContactManager.getContactsById(testIds);
        System.assertEquals(0, foundContact.size());
    }
    
    @IsTest
    private static void testGetContactById() {
        List<Contact> testContacts = getTestContacts();
        Id testId = testContacts[0].Id;
        List<Contact> foundContact = ContactManager.getContactById(testId);
        System.assertEquals(testContacts[0].Id, foundContact[0].Id);
    }
    
    @IsTest
    private static void testGetContactByIdNullPAram() {
        String testId;
        List<Contact> foundContact = ContactManager.getContactById(testId);
        System.assertEquals(0, foundContact.size());
    }
    
    @IsTest
    private static void testGetContact() {
        List<Contact> testContacts = getTestContacts();
        Id testId = testContacts[0].Id;
        Contact foundContact = ContactManager.getContact(testId);
        System.assertEquals(testContacts[0].Id, foundContact.Id);
    }
    
     @IsTest
    private static void testGetContactNullPAram() {
        String testId;
        Contact foundContact = ContactManager.getContact(testId);
        System.assertEquals(new Contact(), foundContact);
    }
    
    @IsTest
    private static void testGetContactsByEmail() {
        List<Contact> testContacts = getTestContacts();
        String email = testContacts[0].Email;
        String phone;
        List<Contact> foundContacts = ContactManager.getContactsByEmailOrPhone(email, phone);
        System.assertEquals(testContacts[0].Id, foundContacts[0].Id);
    }
    
    @IsTest
    private static void testGetContactsByPhone() {
        List<Contact> testContacts = getTestContacts();
        String email;
        String phone = testContacts[0].Phone;
        List<Contact> foundContacts = ContactManager.getContactsByEmailOrPhone(email, phone);
        System.assertEquals(testContacts[0].Id, foundContacts[0].Id);
    }
    
    @IsTest
    private static void testGetContactsByPhoneOrEmailNullParam() {
        List<Contact> testContacts = getTestContacts();
        String email;
        String phone;
        List<Contact> foundContacts = ContactManager.getContactsByEmailOrPhone(email, phone);
        System.assertEquals(0, foundContacts.size());
    }
     
     private static List<Contact> getTestContacts() {
        List<Contact> testContacts = [
            SELECT Id,
            Phone,
            Email
            FROM Contact
        ];
        return testContacts;
    }
}