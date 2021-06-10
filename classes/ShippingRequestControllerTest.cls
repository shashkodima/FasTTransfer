@IsTest
private class ShippingRequestControllerTest {

    @TestSetup
    private static void setup() {
        TestDataFactory.createAccountsContactsLeads();
    }

    @IsTest
    private static void testProcessDataAuthorizedUser() {
        List<Contact> testContacts = [
                SELECT Id
                FROM Contact
        ];
        Profile profileId = [SELECT Id
        FROM Profile
        WHERE Name = 'FasTTransfer Partner'
        LIMIT 1];
        User newUser = new User(LastName = 'test121',
                FirstName='test1212',
                Alias = 'tes',
                Email = 'test1212@asdf.com',
                Username = 'test1212@asdf.com',
                ProfileId = profileId.Id,
                TimeZoneSidKey = 'GMT',
                LanguageLocaleKey = 'en_US',
                EmailEncodingKey = 'UTF-8',
                LocaleSidKey = 'en_US',
                ContactId = testContacts[0].Id
        );
        insert newUser;
        ShippingRequestWrapper testWrapper = new ShippingRequestWrapper();
        testWrapper.shippingName = 'Test';
        testWrapper.cargoType = 'Animals';
        testWrapper.cargoWeight = 777;
        testWrapper.fromCity = 'Grodno';
        testWrapper.toCity = 'Lida';
        testWrapper.userId = newUser.Id;

        ShippingRequestController.proccessData(testWrapper);

        List<Opportunity> createdOpportunity = [
                SELECT Id
                FROM Opportunity
        ];
        System.assertEquals(true, createdOpportunity.size() > 0);
    }

    @IsTest
    private static void testProcessDataUnauthorizedUser() {
        ShippingRequestWrapper testWrapper = new ShippingRequestWrapper();
        testWrapper.contactEmail = 'Test3@outlook.com';
        testWrapper.shippingName = 'Test';

        ShippingRequestController.proccessData(testWrapper);

        List<Opportunity> createdOpportunity = [
                SELECT Id
                FROM Opportunity
        ];
        System.assertEquals(true, createdOpportunity.size() > 0);
    }

    @IsTest
    private static void testProcessDataNotFound() {
        Test.setMock(HttpCalloutMock.class, new RestCountriesHTTPCalloutMock());
        ShippingRequestWrapper testWrapper = new ShippingRequestWrapper();
        testWrapper.shippingName = 'Test';
        testWrapper.cargoType = 'Animals';
        testWrapper.cargoWeight = 777;
        testWrapper.fromCity = 'Grodno';
        testWrapper.toCity = 'Lida';
        testWrapper.companyName = 'Test';
        testWrapper.companyEmail = '122@wwe.com';
        testWrapper.companyPhone = '+375-44-4445556';
        testWrapper.companyType = 'Individual';
        testWrapper.contactLastName = 'Test';
        testWrapper.contactFirstName = 'Test';
        testWrapper.contactEmail = 'qweqew@c.com';
        testWrapper.contactPhone = '+375-44-4445556';

        Test.startTest();
        ShippingRequestController.proccessData(testWrapper);
        Test.stopTest();

        List<Opportunity> createdOpportunity = [
                SELECT Id
                FROM Opportunity
        ];
        System.assertEquals(true, createdOpportunity.size() > 0);
    }
}