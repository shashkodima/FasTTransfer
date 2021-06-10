@RestResource(urlMapping='/Orders')
global class OrderRestService {
    
    @HttpGet
    global static void getOrders() {
        List<Order> foundOrders = new List<Order>();
        OrdersByClientResponseWrapper responseBody = new OrdersByClientResponseWrapper();
        RestRequest request = RestContext.request;
        RestResponse response = RestContext.response;
        String clientId = request.params.get(Constants.URI_PARAMETER_CLIENT_ID);
        try {
            OrderRequestValidation.checkClientIdIsBlank(clientId);
            OrderRequestValidation.checkClientNotFound(clientId);
            
            if(clientId.startsWith(Constants.ACCOUNT_ID_FIRST_SYMBOLS)) {
                foundOrders = OrderManager.getOrdersByAccountId(clientId);
            }
            if(clientId.startsWith(Constants.CONTACT_ID_FIRST_SYMBOLS)) {
                foundOrders = OrderManager.getOrdersByContactId(clientId);
            }
            responseBody = OrderRestServiceHelper.createResponseBody(clientId, foundOrders);
            String responseBodyJSON = JSON.serializePretty(responseBody);
            response.responseBody = Blob.valueOf(responseBodyJSON);
        } catch(OrderRequestValidation.OrderRequestException ex) {
            response.responseBody = Blob.valueOf(ex.getMessage());
        }
    }
}