public class ContractTriggerHandler {
    
    public static void onAfterInsert(List<Contract> newContracts) {
        Map<Id, Id> relatedAccountsAndShippingCompanyUsers = new Map<Id, Id>();
        
        for (Contract contract :newContracts) {
            Id accountId = contract.AccountId;
            Id shippingCompanyUserId = contract.Shipping_CompanyUser__c;
            relatedAccountsAndShippingCompanyUsers.put(accountId, shippingCompanyUserId);
        }
        AccountSharing.manualShareEdit(relatedAccountsAndShippingCompanyUsers);
    }
}