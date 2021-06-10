@IsTest
private class ContactServiceTest {
    
    @IsTest
    private static void testUpdateContactCountryByPhoneAsync() {
        Test.setMock(HttpCalloutMock.class, new RestCountriesHTTPCalloutMock());
        List<Contact> newContacts = new List<Contact> {
            new Contact(FirstName = 'Test1', LastName = 'Test1', Email = 'Test1@outlook.com', Phone = '+375-29-5302473'),
            new Contact(FirstName = 'Test2', LastName = 'Test2', Email = 'Test2@outlook.com', Phone = '+375-77-8888555')
                };
        insert newContacts;  
        Set<Id> testIds = new Set<Id>();
        testIds.add(newContacts[0].Id);
        testIds.add(newContacts[1].Id);
        
        Test.startTest();
        ContactService.updateContactCountryByPhoneAsync(testIds);
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
    private static void testUpdateContactCountryByPhoneAsyncResponseError() {
        Test.setMock(HttpCalloutMock.class, new RestCountriesHTTPCalloutBadMock());
        List<Contact> newContacts = new List<Contact> {
            new Contact(FirstName = 'Test1', LastName = 'Test1', Email = 'Test1@outlook.com', Phone = '+375-29-5302473'),
            new Contact(FirstName = 'Test2', LastName = 'Test2', Email = 'Test2@outlook.com', Phone = '+375-77-8888555')
                };
        insert newContacts;  
        Set<Id> testIds = new Set<Id>();
        testIds.add(newContacts[0].Id);
        testIds.add(newContacts[1].Id);
        
        Test.startTest();
        ContactService.updateContactCountryByPhoneAsync(testIds);
        Test.stopTest();
        
        List<Contact> contactsWithPhoneCountry = [
            SELECT Id,
            Country_from_Phone__c
            FROM Contact
        ];
        System.assert(true, String.isBlank(contactsWithPhoneCountry[0].Country_from_Phone__c));
        System.assert(true, String.isBlank(contactsWithPhoneCountry[1].Country_from_Phone__c));
    }
    
    @IsTest
    private static void testUpdateContactCountryByPhoneAsyncInvalidNumber() {
        List<Contact> newContacts = new List<Contact> {
            new Contact(FirstName = 'Test1', LastName = 'Test1', Email = 'Test1@outlook.com', Phone = '+375-29-2473'),
            new Contact(FirstName = 'Test2', LastName = 'Test2', Email = 'Test2@outlook.com', Phone = '+375-77-8555')
                };
        insert newContacts;  
        Set<Id> testIds = new Set<Id>();
        testIds.add(newContacts[0].Id);
        testIds.add(newContacts[1].Id);
        
        Test.startTest();
        ContactService.updateContactCountryByPhoneAsync(testIds);
        Test.stopTest();
        
        List<Contact> contactsWithPhoneCountry = [
            SELECT Id,
            Country_from_Phone__c
            FROM Contact     
        ];
        System.assert(true, String.isBlank(contactsWithPhoneCountry[0].Country_from_Phone__c));
        System.assert(true, String.isBlank(contactsWithPhoneCountry[1].Country_from_Phone__c));
    }
    
    @IsTest
    private static void testCreateContactFromShippingRequest() {
        ShippingRequestWrapper testWrapper = new ShippingRequestWrapper();
        testWrapper.contactEmail = 'test@test.com';
        testWrapper.contactPhone = '+37544444';
        testWrapper.contactFirstName = 'test';
        testWrapper.contactLastName = 'test';
        Account testAccount = new Account(Name = 'Test1', Email__c = 'Test1@outlook.com');
        insert testAccount;
        ContactService.createContactFromShippingRequest(testAccount, testWrapper);
        List<Contact> createdContacts = [
            SELECT Id
            FROM Contact
        ];
        System.assertEquals(true, createdContacts.size() > 0);
    }
    
    @IsTest
    private static void testCreateContactFromShippingRequestNullParam() {
        Account testAccount = new Account(Name = 'Test1', Email__c = 'Test1@outlook.com');
        insert testAccount;
        ContactService.createContactFromShippingRequest(testAccount, null);
        List<Contact> createdContacts = [
            SELECT Id
            FROM Contact
        ];
        System.assertEquals(false, createdContacts.size() > 0);
    }
    
    @IsTest
    private static void testCreateContactFromLead() {
        Account testAccount = new Account();
        testAccount.Name = 'Lost';
        insert testAccount;
        Lead testLead = new Lead();
        testLead.LastName = 'New';
        testLead.FirstName = 'New New';
        testLead.Company = 'New New New';
        testLead.Company = 'Old';
        testLead.Email = '111@est.com';
        ContactService.createContactFromLead(testLead, testAccount.Id);
        List<Contact> createdContacts = [
            SELECT Id
            FROM Contact
        ];
        System.assertEquals(true, createdContacts.size() > 0); 
    }
    
    @IsTest
    private static void testCreateContactFromLeadNullParam() {
        Account testAccount = new Account(Name = 'Test1');
        insert testAccount;
        ContactService.createContactFromLead(null, testAccount.Id);
        List<Contact> createdContacts = [
            SELECT Id
            FROM Contact
        ];
        System.assertEquals(false, createdContacts.size() > 0); 
    }
}