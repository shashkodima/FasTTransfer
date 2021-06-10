public class ExpiredTaskNotificationSchedule implements Schedulable {
    
    public void execute(SchedulableContext ctx) {
        Database.executeBatch(new ExpiredTaskNotificationBatch());
    }    
}