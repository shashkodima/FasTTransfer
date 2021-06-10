@IsTest
private class TaskServiceTest {
    
    @IsTest
    private static void testCreateTaskForContact() {
        ShippingRequestWrapper testWrapper = new ShippingRequestWrapper();
        testWrapper.orderDate = Date.today();
        testWrapper.shippingName = 'test';
        
        Profile profileId = [SELECT Id 
                             FROM Profile 
                             WHERE Name = 'Standard User' 
                             LIMIT 1];
     	User newUser = new User(LastName = 'test121',
                           FirstName='test1212',
                           Alias = 'tes',
                           Email = 'test1212@asdf.com',
                           Username = 'test1212@asdf.com',
                           ProfileId = profileId.Id,
                           TimeZoneSidKey = 'GMT',
                           LanguageLocaleKey = 'en_US',
                           EmailEncodingKey = 'UTF-8',
                           LocaleSidKey = 'en_US'
                           );
        insert newUser;
        Contact testContact = new Contact(FirstName = 'Test1', LastName = 'Test1', Email = 'Test1@outlook.com', Phone = '11111', OwnerId = newUser.Id);
        insert testContact;
        TaskService.createTaskForContact(testContact, testWrapper);
        List<Task> createdTasks = [
            SELECT Id
            FROM Task
        ];
        System.assertEquals(true, createdTasks.size() > 0);
    }
}