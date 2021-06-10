@IsTest
private class ContacttriggerTest {

    @IsTest
    private static void testContactTriggerAfterInsertValidPhoneNumber() {
        Test.setMock(HttpCalloutMock.class, new RestCountriesHTTPCalloutMock());
        List<Contact> newContacts = new List<Contact> {
                new Contact(FirstName = 'Test1', LastName = 'Test1', Email = 'Test1@outlook.com', Phone = '+375-29-5302473'),
                new Contact(FirstName = 'Test2', LastName = 'Test2', Email = 'Test2@outlook.com', Phone = '+375-77-8888555')
        };

        Test.startTest();
        insert newContacts;
        Test.stopTest();

        List<Contact> contactsWithPhoneCountry = [
                SELECT Id,
                        Country_from_Phone__c
                FROM Contact
        ];
        System.assert(true, contactsWithPhoneCountry[0].Country_from_Phone__c.length() > 0);
        System.assert(true, contactsWithPhoneCountry[1].Country_from_Phone__c.length() > 0);
    }

    @IsTest
    private static void testContactTriggerAfterInsertInvalidPhoneNumber() {
        List<Contact> newContacts = new List<Contact> {
                new Contact(FirstName = 'Test1', LastName = 'Test1', Email = 'Test1@outlook.com', Phone = '+375-29-2473'),
                new Contact(FirstName = 'Test2', LastName = 'Test2', Email = 'Test2@outlook.com', Phone = '+375-77-8555')
        };

        Test.startTest();
        insert newContacts;
        Test.stopTest();

        List<Contact> contactsWithPhoneCountry = [
                SELECT Id,
                        Country_from_Phone__c
                FROM Contact
        ];
        System.assert(true, String.isBlank(contactsWithPhoneCountry[0].Country_from_Phone__c));
        System.assert(true, String.isBlank(contactsWithPhoneCountry[1].Country_from_Phone__c));
    }
}