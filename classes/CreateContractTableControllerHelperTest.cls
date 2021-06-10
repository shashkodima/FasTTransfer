@IsTest
private class CreateContractTableControllerHelperTest {

    @IsTest
    private static void testCreatWrappers() {
        List<Offer__c> newOffers = new List<Offer__c> {
                new Offer__c(Name = 'Test1', Status__c = 'New'),
                new Offer__c(Name = 'Test2', Status__c = 'New'),
                new Offer__c(Name = 'Test3', Status__c = 'New')
        };

        List<CreateConractTableWrapper> createdWrappers = CreateContractTableControllerHelper.creatWrappers(newOffers);
        System.assertEquals(3, createdWrappers.size());
    }

    @IsTest
    private static void testCreateNewContract() {
        Account testAccount = new Account(Name = 'Test1');
        insert testAccount;
        Contact testContact = new Contact(FirstName = 'Test1', LastName = 'Test1', Email = 'Test1@outlook.com', Phone = '11111', AccountId = testAccount.Id);
        insert testContact;
        Opportunity testOpportunity = new Opportunity(Name = 'Test1', StageName = 'New', CloseDate = Date.today());
        insert testOpportunity;
        Order testOrder = new Order(AccountId = testAccount.Id, EffectiveDate = Date.today(), Status = 'New', ShipToContactId = testContact.Id, OpportunityId = testOpportunity.Id);
        insert testOrder;
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
        Offer__c testOffer = new Offer__c(Name = 'Test1', Order__c = testOrder.Id, Status__c = 'New', Max_Price__c = 100, Min_Price__c = 50);
        insert testOffer;

        CreateContractTableControllerHelper.createNewContract(testOrder, testOffer);
    }
}