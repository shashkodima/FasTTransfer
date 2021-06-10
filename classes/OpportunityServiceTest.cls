@IsTest
private class OpportunityServiceTest {
    
    @IsTest
    private static void creatOpportunityFromShippingRequest() {
        ShippingRequestWrapper testWrapper = new ShippingRequestWrapper();
        testWrapper.shippingName = 'Test';
        testWrapper.cargoType = 'Animals';
        testWrapper.cargoWeight = 777;
        testWrapper.fromCity = 'Grodno';
        testWrapper.toCity = 'Lida';
        Account testAccount = new Account(Name = 'Test1', Email__c = 'Test1@outlook.com', OwnerId = UserInfo.getUserId());
        insert testAccount;
        OpportunityService.creatOpportunityFromShippingRequest(testAccount, testWrapper);
        List<Opportunity> createdOpportunity = [
            SELECT Id
            FROM Opportunity
        ];
        System.assertEquals(true, createdOpportunity.size() > 0);
    }
    
    @IsTest
    private static void creatOpportunityFromShippingRequestNullParam() {
        Account testAccount = new Account(Name = 'Test1', Email__c = 'Test1@outlook.com', OwnerId = UserInfo.getUserId());
        insert testAccount;
        OpportunityService.creatOpportunityFromShippingRequest(testAccount, null);
        List<Opportunity> createdOpportunity = [
            SELECT Id
            FROM Opportunity
        ];
        System.assertEquals(true, createdOpportunity.size() == 0);
    }        
}