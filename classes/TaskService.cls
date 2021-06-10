public class TaskService {
    
    public static void createTaskForContact(Contact contact, ShippingRequestWrapper dataFromCustomer) {
        Task newTask = new Task();
        newTask.RecordTypeId = SObjectType.Task.getRecordTypeInfosByDeveloperName().get(Constants.RECORDTYPE_NAME_OFFERS_CALL).getRecordTypeId();
        newTask.OwnerId = contact.OwnerId;
        newTask.Status = Constants.TASK_STATUS_NEW;
        newTask.Theme__c = dataFromCustomer.shippingName;
        newTask.Auto_Created__c = true;
        newTask.WhoId = contact.Id;
        newTask.ActivityDate = dataFromCustomer.orderDate;
        newTask.Priority = Constants.PRIORITY_STATUS_HIGH;
        newTask.Mobile_Phone__c = contact.Phone;
        insert newTask;
    }
}