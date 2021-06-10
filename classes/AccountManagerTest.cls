@IsTest
private class AccountManagerTest {
    
    @TestSetup
    private static void setup() {
        TestDataFactory.createAccounts();    
    }
    
    @IsTest
    private static void testGetAccountById() {
        List<Account> testAccounts = getTestAccounts();
        String testId = testAccounts[0].Id;
        List<Account> foundAccounts = AccountManager.getAccountById(testId);
        System.assertEquals(testAccounts[0].Id, foundAccounts[0].Id);
    }
    
    @IsTest
    private static void testGetAccountByIdNullParam() {
        String testId;
        List<Account> foundAccounts = AccountManager.getAccountById(testId);
        System.assertEquals(0, foundAccounts.size());
    }
    
    @IsTest
    private static void testGetAccount() {
        List<Account> testAccounts = getTestAccounts();
        String testId = testAccounts[0].Id;
        Account foundAccount = AccountManager.getAccount(testId);
        System.assertEquals(testAccounts[0].Id, foundAccount.Id);
    }
    
    @IsTest
    private static void testGetAccountNullParam() {
        String testId;
        Account foundAccount = AccountManager.getAccount(testId);
        System.assertEquals(new Account(), foundAccount);
    }
    
    @IsTest
    private static void testGetAccountsByEmail() {
        List<Account> testAccounts = getTestAccounts();
        String testEmail = testAccounts[0].Email__c;
        List<Account> foundAccounts = AccountManager.getAccountsByEmail(testEmail);
        System.assertEquals(testAccounts[0].Id, foundAccounts[0].Id);
    }
    
    @IsTest
    private static void testGetAccountsByEmailNullParam() {
        String testEmail;
        List<Account> foundAccounts = AccountManager.getAccountsByEmail(testEmail);
        System.assertEquals(0, foundAccounts.size());
    }
    
    private static List<Account> getTestAccounts() {
        List<Account> testAccounts = [
            SELECT Id,
            Name,
            Email__c
            FROM Account
        ];
        return testAccounts;
    }
}