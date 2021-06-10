/**
 * Created by LEGION on 10.06.2021.
 */

@IsTest
private class ExpiredTaskNotificationScheduleTest {

    @IsTest
    private static void testExpiredTaskNotificationSchedule() {

        Test.startTest();
        ExpiredTaskNotificationSchedule newJob = new ExpiredTaskNotificationSchedule();
        String cron = '0 0 22 * * ?';
        String jobId = System.schedule('Expired task notification process', cron, newJob);
        Test.stopTest();

        CronTrigger currentCronTrigger = [
                SELECT Id,
                        CronExpression,
                        TimesTriggered,
                        NextFireTime
                FROM CronTrigger
                WHERE Id = :jobId];
        System.assertEquals(cron, currentCronTrigger.CronExpression);
    }
}