@IsTest
private class ShippingRequestControllerHelperTest {

    @IsTest
    private static void testFindAccountRelatedToUser() {
        Account testAccount = new Account(Name = 'Test1');
        insert testAccount;
        Contact testContact = new Contact(FirstName = 'Test1', LastName = 'Test1', Email = 'Test1@outlook.com', Phone = '11111', AccountId = testAccount.Id);
        insert testContact;
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
                ContactId = testContact.Id
        );
        insert newUser;
        Account foundAccount = ShippingRequestControllerHelper.findAccountRelatedToUser(newUser.Id);
        System.assertEquals(testAccount.Id, foundAccount.Id);
    }

    @IsTest
    private static void testCheckEmailPhoneExistInDatabaseByContactEmail() {
        TestDataFactory.createAccountsContactsLeads();
        ShippingRequestWrapper testWrapper = new ShippingRequestWrapper();
        testWrapper.contactEmail = 'Test2@outlook.com';
        Account foundAccount = ShippingRequestControllerHelper.checkEmailPhoneExistInDatabase(testWrapper);
        System.assertEquals(true, foundAccount != null);
    }

    @IsTest
    private static void testCheckEmailPhoneExistInDatabaseByLeadEmail() {
        TestDataFactory.createAccountsContactsLeads();
        ShippingRequestWrapper testWrapper = new ShippingRequestWrapper();
        testWrapper.contactEmail = 'Test3@outlook.com';
        Account foundAccount = ShippingRequestControllerHelper.checkEmailPhoneExistInDatabase(testWrapper);
        System.assertEquals(true, foundAccount != null);
    }

    @IsTest
    private static void testCheckEmailPhoneExistInDatabaseByCompanyEmail() {
        TestDataFactory.createAccountsContactsLeads();
        ShippingRequestWrapper testWrapper = new ShippingRequestWrapper();
        testWrapper.companyEmail = 'Test1@outlook.com';
        testWrapper.contactLastName = 'Test';
        Account foundAccount = ShippingRequestControllerHelper.checkEmailPhoneExistInDatabase(testWrapper);
        System.assertEquals(true, foundAccount != null);
    }
}