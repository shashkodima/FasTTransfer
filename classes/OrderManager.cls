public class OrderManager {
    
    public static List<Order> getOrdersByContactId(String contactId) {
        if(String.isBlank(contactId)) {
            return new List<Order>();
        }
        List<Order> foundOrders = [
            SELECT Id,
            EffectiveDate,
            EndDate,
            Status,
            SLA_Offers_Date__c,
            Cargo_weight__c,
            Cargo_type__c,
            To_City__c,
            From_City__c
            FROM Order
            WHERE ShipToContactId = :contactId
            AND Status != :Constants.ORDER_STATUS_FINISHED
            AND Status != :Constants.ORDER_STATUS_CANCELLED
        ];
        return foundOrders;
    }
    
    public static List<Order> getOrdersByAccountId(String accountId) {
        if(String.isBlank(accountId)) {
            return new List<Order>();
        }
        List<Order> foundOrders = [
            SELECT Id,
            EffectiveDate,
            EndDate,
            Status,
            SLA_Offers_Date__c,
            Cargo_weight__c,
            Cargo_type__c,
            To_City__c,
            From_City__c
            FROM Order
            WHERE	AccountId = :accountId
            AND Status != :Constants.ORDER_STATUS_FINISHED
            AND Status != :Constants.ORDER_STATUS_CANCELLED
        ];
        return foundOrders;
    }
    
    public static Order getOrderById(String orderId) {
        if(String.isBlank(orderId)) {
            return new Order();
        }
        Order foundOrder = [
            SELECT Id,
            AccountId,
            ShipToContactId,
            OpportunityId
            FROM Order
            WHERE Id = :orderId         
        ];
        return foundOrder;
    }
}