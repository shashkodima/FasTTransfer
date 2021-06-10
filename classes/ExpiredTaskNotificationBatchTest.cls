@IsTest
private class ExpiredTaskNotificationBatchTest {

    @IsTest
    private static void testExpiredTaskNotificationBatch() {
        Date expiredDate = Date.today() - 1;
        Date relevantDate = Date.today();
        Integer numberExpiredTasks = 50;
        Integer numberActualTasks = 50;
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
        List<Task> expiredTasks = new List<Task>();
        List<Task> actualTasks = new List<Task>();
        List<String> errorMessages = new List<String>();

        for (Integer i = 0; i < numberExpiredTasks; i++){
            Task newTask = new Task();
            newTask.OwnerId = usersManager[0].Id;
            newTask.ActivityDate = expiredDate;
            newTask.Status = Constants.TASK_STATUS_NEW;
            expiredTasks.add(newTask);
        }

        for (Integer i = 0; i < numberActualTasks; i++){
            Task newTask = new Task();
            newTask.OwnerId = usersManager[0].Id;
            newTask.ActivityDate = relevantDate;
            newTask.Status = Constants.TASK_STATUS_NEW;
            actualTasks.add(newTask);
        }

        Test.startTest();
        try {
            ExpiredTaskNotificationBatch newBatch = new ExpiredTaskNotificationBatch();
            Id batchId = Database.executeBatch(newBatch);
        } catch (Exception exc) {
            errorMessages.add(exc.getMessage());
        }
        Test.stopTest();

        System.assertEquals(0, errorMessages.size());
    }
}