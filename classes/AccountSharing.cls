public class AccountSharing {
    
    public static void manualShareEdit(Map<Id, Id> relaitedAccountsAndShippingCompanyUsers) {
        if(relaitedAccountsAndShippingCompanyUsers.IsEmpty()) {
            return;
        }       
        List<AccountShare> newSharings = new List<AccountShare>();
        
        for (Id accountId : relaitedAccountsAndShippingCompanyUsers.keySet()) {
            AccountShare newSharing = new AccountShare();
            newSharing.AccountId = accountId;
            newSharing.UserOrGroupId = relaitedAccountsAndShippingCompanyUsers.get(accountId);
            newSharing.AccountAccessLevel = Constants.ACCESS_LEVEL_EDIT;
            newSharing.OpportunityAccessLevel = Constants.ACCESS_LEVEL_NONE;
            newSharings.add(newSharing);
        }
        Database.SaveResult[] results = Database.insert(newSharings, false);
    }
}