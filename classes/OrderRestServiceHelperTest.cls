@IsTest
private class OrderRestServiceHelperTest {

    @IsTest
    private static void testCreateResponseBody() {
        List<Account> testAccounts = new List<Account>{
                new Account(Name = 'Test1'),
                new Account(Name = 'Test2')
        };
        insert testAccounts;
        Contact testContact = new Contact(FirstName = 'Test1', LastName = 'Test1');
        insert testContact;
        List<Order> newOrders = new List<Order> {
                new Order(AccountId = testAccounts[0].Id, ShipToContactId = testContact.Id, EffectiveDate = Date.today(), Status = 'New'),
                new Order(AccountId = testAccounts[1].Id, ShipToContactId = testContact.Id, EffectiveDate = Date.today(), Status = 'New')
        };
        insert newOrders;
        OrdersByClientResponseWrapper createdWrapper = OrderRestServiceHelper.createResponseBody(testContact.Id, newOrders);
        System.assertEquals(testContact.Id, createdWrapper.clientId);
        System.assertEquals(null, createdWrapper.error);
    }

    @IsTest
    private static void testCreateResponseBodyNullParam() {
        List<Account> testAccounts = new List<Account>{
                new Account(Name = 'Test1'),
                new Account(Name = 'Test2')
        };
        insert testAccounts;
        Contact testContact = new Contact(FirstName = 'Test1', LastName = 'Test1');
        insert testContact;
        List<Order> newOrders = new List<Order>{
                new Order(AccountId = testAccounts[0].Id, ShipToContactId = testContact.Id, EffectiveDate = Date.today(), Status = 'New'),
                new Order(AccountId = testAccounts[1].Id, ShipToContactId = testContact.Id, EffectiveDate = Date.today(), Status = 'New')
        };
        insert newOrders;
        OrdersByClientResponseWrapper createdWrapper = OrderRestServiceHelper.createResponseBody(null, newOrders);
        System.assertEquals(null, createdWrapper.clientId);
    }
}