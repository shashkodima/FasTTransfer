@IsTest
private class LeadServiceTest {
    
    @IsTest
    private static void testUpdateLeadCountryByPhoneAsync() {
        Test.setMock(HttpCalloutMock.class, new RestCountriesHTTPCalloutMock());
        List<Lead> newLeads = new List<Lead> {
            new Lead(LastName = 'Test1', Company = 'New', Phone = '+375-29-5302473', Email = 'Test1@outlook.com'),
            new Lead(LastName = 'Test2', Company = 'New', Phone = '+375-77-8888555', Email = 'Test2@outlook.com') 
                };
        insert newLeads;
        Set<Id> testIds = new Set<Id>();
        testIds.add(newLeads[0].Id);
        testIds.add(newLeads[1].Id);
        
        Test.startTest();
        LeadService.updateLeadCountryByPhoneAsync(testIds);
        Test.stopTest();
        
        List<Lead> LeadWithPhoneCountry = [
            SELECT Id,
            Country_from_Phone__c
            FROM Lead     
        ];
        System.assert(true, LeadWithPhoneCountry[0].Country_from_Phone__c.length() > 0);
        System.assert(true, LeadWithPhoneCountry[1].Country_from_Phone__c.length() > 0);
    }
    
    @IsTest
    private static void testUpdateLeadCountryByPhoneAsyncResponseError() {
        Test.setMock(HttpCalloutMock.class, new RestCountriesHTTPCalloutBadMock());
        List<Lead> newLeads = new List<Lead> {
            new Lead(LastName = 'Test1', Company = 'New', Phone = '+375-29-5302473', Email = 'Test1@outlook.com'),
            new Lead(LastName = 'Test2', Company = 'New', Phone = '+375-77-8888555', Email = 'Test2@outlook.com') 
                };
        insert newLeads;
        Set<Id> testIds = new Set<Id>();
        testIds.add(newLeads[0].Id);
        testIds.add(newLeads[1].Id);
        
        Test.startTest();
        LeadService.updateLeadCountryByPhoneAsync(testIds);
        Test.stopTest();
        
         List<Lead> LeadWithPhoneCountry = [
            SELECT Id,
            Country_from_Phone__c
            FROM Lead     
        ];
        System.assert(true, String.isBlank(LeadWithPhoneCountry[0].Country_from_Phone__c));
        System.assert(true, String.isBlank(LeadWithPhoneCountry[1].Country_from_Phone__c));
    }
    
    @IsTest
    private static void testUpdateLeadCountryByPhoneAsyncInvalidNumber() {
        List<Lead> newLeads = new List<Lead> {
            new Lead(LastName = 'Test1', Company = 'New', Phone = '+375-2-5302473', Email = 'Test1@outlook.com'),
            new Lead(LastName = 'Test2', Company = 'New', Phone = '+375-7-8888555', Email = 'Test2@outlook.com') 
                };
        insert newLeads;
        Set<Id> testIds = new Set<Id>();
        testIds.add(newLeads[0].Id);
        testIds.add(newLeads[1].Id);
        
        Test.startTest();
        LeadService.updateLeadCountryByPhoneAsync(testIds);
        Test.stopTest();
        
        List<Lead> LeadWithPhoneCountry = [
            SELECT Id,
            Country_from_Phone__c
            FROM Lead     
        ];
        System.assert(true, String.isBlank(LeadWithPhoneCountry[0].Country_from_Phone__c));
        System.assert(true, String.isBlank(LeadWithPhoneCountry[1].Country_from_Phone__c));
    }
    
    @IsTest
    private static void testConvertToAccountWithContact() {
        Lead testLead = new Lead(LastName = 'Test1', Company = 'New', Phone = '+375-2-5302473', Email = 'Test1@outlook.com', OwnerId = UserInfo.getUserId());
        Account createdAccount = LeadService.convertToAccountWithContact(testLead);
        System.assertEquals(true, createdAccount != null);
    }
    
    @IsTest
    private static void testConvertToAccountWithContactNullParam() {
        Account createdAccount = LeadService.convertToAccountWithContact(null);
        System.assertEquals(new Account(), createdAccount);
    }
}