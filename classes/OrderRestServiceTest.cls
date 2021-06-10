@IsTest
private class OrderRestServiceTest {
    
    @IsTest
    private static void testGetOrdersContactId() {
        Contact testContact = new Contact(FirstName = 'Test1', LastName = 'Test1');
        insert testContact;
        RestContext.request = new RestRequest();
        RestContext.response = new RestResponse();
        RestContext.request.requestUri = '/services/apexrest/Orders';
        RestContext.request.httpMethod = Constants.REQUEST_METHOD_GET;
        RestContext.request.addParameter('clientId', testContact.Id);
        
        Test.startTest();
        OrderRestService.getOrders();
        Test.stopTest();
        
        String stringJSON = RestContext.response.responseBody.toString();
        OrdersByClientResponseWrapper responseTest = (OrdersByClientResponseWrapper)JSON.deserialize(stringJSON , OrdersByClientResponseWrapper.class);
        System.assertEquals(null, responseTest.error);
    }
    
    @IsTest
    private static void testGetOrdersAccountId() {
        Account testAccount = new Account(Name = 'Test1', Email__c = 'Test1@outlook.com');
        insert testAccount;
        RestContext.request = new RestRequest();
        RestContext.response = new RestResponse();
        RestContext.request.requestUri = '/services/apexrest/Orders';
        RestContext.request.httpMethod = Constants.REQUEST_METHOD_GET;
        RestContext.request.addParameter('clientId', testAccount.Id);
        
        Test.startTest();
        OrderRestService.getOrders();
        Test.stopTest();
        
        String stringJSON = RestContext.response.responseBody.toString();
        OrdersByClientResponseWrapper responseTest = (OrdersByClientResponseWrapper)JSON.deserialize(stringJSON , OrdersByClientResponseWrapper.class);
        System.assertEquals(null, responseTest.error);
    }
    
    @IsTest
    private static void testGetOrdersNullId() {
        RestContext.request = new RestRequest();
        RestContext.response = new RestResponse();
        RestContext.request.requestUri = '/services/apexrest/Orders';
        RestContext.request.httpMethod = Constants.REQUEST_METHOD_GET;
        RestContext.request.addParameter('clientId', null);
        
        Test.startTest();
        OrderRestService.getOrders();
        Test.stopTest();
        
        String stringJSON = RestContext.response.responseBody.toString();
        OrdersByClientResponseWrapper responseTest = (OrdersByClientResponseWrapper)JSON.deserialize(stringJSON , OrdersByClientResponseWrapper.class);
        System.assertEquals(Constants.VALUE_ERROR, responseTest.status);
        System.assertEquals(Constants.VALUE_WRONG_PARAMETER, responseTest.error);
    }
    
    @IsTest
    private static void testGetOrdersInvalidId() {
        RestContext.request = new RestRequest();
        RestContext.response = new RestResponse();
        RestContext.request.requestUri = '/services/apexrest/Orders';
        RestContext.request.httpMethod = Constants.REQUEST_METHOD_GET;
        RestContext.request.addParameter('clientId', '54654');
        
        Test.startTest();
        OrderRestService.getOrders();
        Test.stopTest();
        
        String stringJSON = RestContext.response.responseBody.toString();
        OrdersByClientResponseWrapper responseTest = (OrdersByClientResponseWrapper)JSON.deserialize(stringJSON , OrdersByClientResponseWrapper.class);
        System.assertEquals(Constants.VALUE_ERROR, responseTest.status);
        System.assertEquals(Constants.VALUE_CLIENT_NOT_FOUND, responseTest.error);
    }
}