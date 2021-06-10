@IsTest
private class LeadTriggerTest {

    @IsTest
    private static void testLeadTriggerAfterInsert() {
        Test.setMock(HttpCalloutMock.class, new RestCountriesHTTPCalloutMock());
        List<Lead> newLeads = new List<Lead> {
                new Lead(LastName = 'Test1', Company = 'New', Phone = '+375-29-5302473', Email = 'Test1@outlook.com'),
                new Lead(LastName = 'Test2', Company = 'New', Phone = '+375-77-8888555', Email = 'Test2@outlook.com')
        };

        Test.startTest();
        insert newLeads;
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
    private static void testLeadTriggerAfterInsertInvalidNumber() {
        List<Lead> newLeads = new List<Lead> {
                new Lead(LastName = 'Test1', Company = 'New', Phone = '+375-2-5302473', Email = 'Test1@outlook.com'),
                new Lead(LastName = 'Test2', Company = 'New', Phone = '+375-7-8888555', Email = 'Test2@outlook.com')
        };

        Test.startTest();
        insert newLeads;
        Test.stopTest();

        List<Lead> LeadWithPhoneCountry = [
                SELECT Id,
                        Country_from_Phone__c
                FROM Lead
        ];
        System.assert(true, String.isBlank(LeadWithPhoneCountry[0].Country_from_Phone__c));
        System.assert(true, String.isBlank(LeadWithPhoneCountry[1].Country_from_Phone__c));
    }
}