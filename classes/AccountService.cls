public class AccountService {
    
    public static Account createAccountFromShippingRequest(ShippingRequestWrapper requestData) {
        if (requestData == null) {
            return new Account();
        }
        Account newAccount = new Account();
        String profileName = Constants.NAME_SALES_MANAGER_PROFILE;
        Profile salesManagerProfile = [
            SELECT Id
            FROM Profile
            WHERE Name = :profileName
        ];
        List<User> salesManagers = UserManager.getUsersSalesManager(salesManagerProfile.Id);
        User salesManager = salesManagers[0];
        newAccount.Name = requestData.companyName;
        newAccount.OwnerId = salesManager.Id;
        newAccount.Email__c = requestData.companyEmail;
        newAccount.Phone = requestData.companyPhone;
        newAccount.Type = requestData.companyType;
        insert newAccount;
        return newAccount;
    }
    
    public static Account createAccountFromLead(Lead leadForConverting) {
        if (leadForConverting == null) {
            return new Account();
        }
        Account newAccount = new Account();
        newAccount.Name = leadForConverting.Company;
        newAccount.OwnerId = leadForConverting.OwnerId;
        insert newAccount;
        return newAccount;
    }
}