public class AccountManager {

    public static List<Account> getAccountById(String accountId) {
        if (String.isBlank(accountId)) {
            return new List<Account>();
        }
        List<Account> foundAccount = [
            SELECT Id
            FROM Account
            WHERE Id = :accountId
        ];
        return foundAccount;
    }
    
    public static Account getAccount(String accountId) {
        if (String.isBlank(accountId)) {
            return new Account();
        }
        Account foundAccount = [
            SELECT Id,
            OwnerId
            FROM Account
            WHERE Id = :accountId
        ];
        return foundAccount;
    }
    
    public static List<Account> getAccountsByEmail(String email) {
        if (String.isBlank(email)) {
            return new List<Account>();
        }
        List<Account> foundAccounts = [
            SELECT Id,
            OwnerId
            FROM Account
            WHERE Email__c = :email
        ];
        return foundAccounts;
    }
}