@IsTest
private class AccountSharingTest {
    
    @IsTest
    private static void testManualShareEdit() {
        String profileNameManager = Constants.NAME_SALES_MANAGER_PROFILE;
        Profile salesManagerProfile = [
            SELECT Id
            FROM Profile
            WHERE Name = :profileNameManager
        ];
        List<User> usersManager = [SELECT Id
                                   FROM User
                                   WHERE IsActive = TRUE
                                   AND ProfileId = :salesManagerProfile.Id
                                   LIMIT 1];
        
        String profileName = Constants.NAME_PARTNER_PROFILE;
        Profile profilePartner = [
            SELECT Id
            FROM Profile
            WHERE Name = :profileName
        ];
        List<User> usersPartner = [SELECT Id
                                   FROM User
                                   WHERE IsActive = TRUE
                                   AND ProfileId = :profilePartner.Id
                                   LIMIT 1];
        
        Id firstTestUserId = usersManager[0].Id;
        Id secondTestUserId = usersPartner[0].Id;
        Account testAccount = new Account(Name = 'Test', OwnerId = firstTestUserId);
        insert testAccount;
        Map<Id,Id> testMap = new Map<Id,Id>();
        testMap.put(testAccount.Id, secondTestUserId);
        
        AccountSharing.manualShareEdit(testMap);
        
        List<AccountShare> accountShares = [
            SELECT Id,
            UserOrGroupId,
            AccountAccessLevel, 
            RowCause 
            FROM AccountShare 
            WHERE AccountId = :testAccount.Id
            AND UserOrGroupId = :secondTestUserId
        ];
        System.assertEquals(accountShares.size(), 1);
        System.assertEquals(accountShares[0].AccountAccessLevel, 'Edit');
        System.assertEquals(accountShares[0].RowCause, 'Manual');
        System.assertEquals(accountShares[0].UserOrGroupId, secondTestUserId);
    }
    
    @IsTest
    private static void testManualShareEditEmptyMap() {
        Map<Id, Id> emptyMap = new Map<Id,Id>();
        
        AccountSharing.manualShareEdit(emptyMap);
        
        List<AccountShare> accountShares = [
            SELECT Id,
            UserOrGroupId,
            AccountAccessLevel, 
            RowCause 
            FROM AccountShare 
        ];
        System.assertEquals(accountShares.size(), 0);
    }
}