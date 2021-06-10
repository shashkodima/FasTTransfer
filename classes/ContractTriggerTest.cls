@IsTest
private class ContractTriggerTest {

    @IsTest
    private static void testAfterInsert() {
        String profileNameManager = Constants.NAME_SALES_MANAGER_PROFILE;
        Profile salesManagerProfile = [
                SELECT Id
                FROM Profile
                WHERE Name = :profileNameManager
        ];
        List<User> usersManager = [
                SELECT Id
                FROM User
                WHERE IsActive = TRUE
                AND ProfileId = :salesManagerProfile.Id
                LIMIT 1
        ];

        String profileName = Constants.NAME_PARTNER_PROFILE;
        Profile profilePartner = [
                SELECT Id
                FROM Profile
                WHERE Name = :profileName
        ];
        List<User> usersPartner = [
                SELECT Id
                FROM User
                WHERE IsActive = TRUE
                AND ProfileId = :profilePartner.Id
                LIMIT 1
        ];
        Id userManagerId = usersManager[0].Id;
        Id userPartnerId = usersPartner[0].Id;
        Account testAccount = new Account(Name = 'Test', OwnerId = userManagerId);
        insert testAccount;
        Contract testContract = new Contract(AccountId = testAccount.Id, Shipping_CompanyUser__c = userPartnerId);

        insert testContract;

        List<AccountShare> accountShares = [
                SELECT Id,
                        UserOrGroupId,
                        AccountAccessLevel,
                        RowCause
                FROM AccountShare
                WHERE AccountId = :testAccount.Id
                AND UserOrGroupId = :userPartnerId
        ];
        System.assertEquals(accountShares.size(), 1);
        System.assertEquals(accountShares[0].AccountAccessLevel, 'Edit');
        System.assertEquals(accountShares[0].RowCause, 'Manual');
        System.assertEquals(accountShares[0].UserOrGroupId, userPartnerId);
    }
}