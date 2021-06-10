@IsTest
private class LeadManagerTest {
    
    @TestSetup
    private static void setup() {
        TestDataFactory.createLeads();    
    }
    
    @IsTest
    private static void testGetLeadsById() {
        List<Lead> testLeads = getTestLeads();
        Id testId = testLeads[0].Id;
        Set<Id> testIds = new Set<Id>();
        testIds.add(testId);
        List<Lead> foundLeads = LeadManager.getLeadsById(testIds);
        System.assertEquals(testLeads[0].Id, foundLeads[0].Id);
    }
    
    @IsTest
    private static void testGetLeadsByIdNullParam() {
        Set<Id> testIds = new Set<Id>();
        List<Lead> foundLeads = LeadManager.getLeadsById(testIds);
        System.assertEquals(0, foundLeads.size());
    }
    
    @IsTest
    private static void testGetLeadsByPhone() {
        List<Lead> testLeads = getTestLeads();
        String email;
        String phone = testLeads[0].Phone;
        List<Lead> foundLeads = LeadManager.getLeadsByEmailOrPhone(email, phone);
        System.assertEquals(testLeads[0].Id, foundLeads[0].Id);
    }
    
    @IsTest
    private static void testGetLeadsByEmail() {
        List<Lead> testLeads = getTestLeads();
        String email = testLeads[0].Email;
        String phone;
        List<Lead> foundLeads = LeadManager.getLeadsByEmailOrPhone(email, phone);
        System.assertEquals(testLeads[0].Id, foundLeads[0].Id);
    }
    
    @IsTest
    private static void testGetLeadsByEmailOrPhoneNullParam() {
        String email;
        String phone;
        List<Lead> foundLeads = LeadManager.getLeadsByEmailOrPhone(email, phone);
        System.assertEquals(0, foundLeads.size());
    }
    
    private static List<Lead> getTestLeads() {
        List<Lead> testLeads = [
            SELECT Id,
            Phone,
            Email
            FROM Lead
        ];
        return testLeads;
    }
    
}