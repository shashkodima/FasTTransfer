@IsTest
private class AccountServiceTest {
    
    @IsTest
    private static void testCreateAccountFromShippingRequest() {
        ShippingRequestWrapper newWrapper = createShippingRequestWrapper();
        Account newAccount = AccountService.createAccountFromShippingRequest(newWrapper);
        System.assertEquals(true, newAccount != null);
    }
    
    @IsTest
    private static void testCreateAccountFromLead() {
        TestDataFactory.createLeads();
        List<Lead> testLeads = [
            SELECT Id,
            OwnerId,
            Company
            FROM Lead
        ];
        Account newAccount = AccountService.createAccountFromLead(testLeads[0]);
        System.assertEquals(true, newAccount != null);
    }
    
    private static ShippingRequestWrapper createShippingRequestWrapper() {
        ShippingRequestWrapper newWrapper = new ShippingRequestWrapper();
        newWrapper.companyName = 'test';
        newWrapper.companyEmail = 'test@mail.ru';
        newWrapper.companyPhone = '+3333333';
        newWrapper.companyType = 'Individual';
        newWrapper.contactFirstName = 'test'; 
        newWrapper.contactLastName = 'test';
        newWrapper.contactEmail = 'test@mail.ru';
        newWrapper.contactPhone = '+3333333';
        newWrapper.shippingName = 'test';
        newWrapper.cargoWeight = 1;
        newWrapper.cargoType = 'Animals';
        newWrapper.fromCity = 'test';
        newWrapper.toCity = 'test';
        newWrapper.orderDate = Date.today();
        newWrapper.comments = 'test';
        return newWrapper;
    }
}