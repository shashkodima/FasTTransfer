public without sharing class ShippingRequestController {
    
    @AuraEnabled
    public static void proccessData(ShippingRequestWrapper requestData){
        String userId = requestData.userId;
        if(userId == null) {
            Account relatedAccount = ShippingRequestControllerHelper.checkEmailPhoneExistInDatabase(requestData);  
            if(relatedAccount != null) {
                OpportunityService.creatOpportunityFromShippingRequest(relatedAccount, requestData);
            } else {
                Account newAccount = AccountService.createAccountFromShippingRequest(requestData);
                ContactService.createContactFromShippingRequest(newAccount, requestData);
                OpportunityService.creatOpportunityFromShippingRequest(newAccount, requestData);
            }
        } else { 
            Account relatedAccount = ShippingRequestControllerHelper.findAccountRelatedToUser(userId);
            OpportunityService.creatOpportunityFromShippingRequest(relatedAccount, requestData);
        }
    }
}