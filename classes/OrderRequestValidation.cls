public class OrderRequestValidation {
    public class OrderRequestException extends Exception {}
    
    public static void checkClientNotFound(String recivedId) { 
        List<Account> foundAccount = AccountManager.getAccountById(recivedId);
        List<Contact> foundContact = ContactManager.getContactById(recivedId);
        
        if ((foundAccount.isEmpty() && foundContact.isEmpty()) || (foundAccount == null && foundContact == null)) {
            OrdersByClientResponseWrapper responseBody = new OrdersByClientResponseWrapper();
            responseBody.clientId = recivedId;     
            responseBody.status = Constants.VALUE_ERROR;
            responseBody.error = Constants.VALUE_CLIENT_NOT_FOUND;
            responseBody.orders = null;
            String responseBodyJSON = JSON.serializePretty(responseBody);
            throw new OrderRequestException(responseBodyJSON);
        }
    }
    
    public static void checkClientIdIsBlank(String recivedId) {
        if (String.isBlank(recivedId)) {
            OrdersByClientResponseWrapper responseBody = new OrdersByClientResponseWrapper();
            responseBody.clientId = recivedId;
            responseBody.status = Constants.VALUE_ERROR;
            responseBody.error = Constants.VALUE_WRONG_PARAMETER;
            responseBody.orders = null;           
            String responseBodyJSON = JSON.serializePretty(responseBody);
            throw new OrderRequestException(responseBodyJSON);
        }
    }
}