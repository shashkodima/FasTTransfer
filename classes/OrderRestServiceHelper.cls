public class OrderRestServiceHelper {
    
    public static OrdersByClientResponseWrapper createResponseBody(String clientId, List<Order> foundOrders) {
        if (String.isBlank(clientId) || foundOrders.isEmpty() || foundOrders == null) {
            return new OrdersByClientResponseWrapper();
        }
        OrdersByClientResponseWrapper responseBody = new OrdersByClientResponseWrapper();
        List<OrdersByClientResponseWrapper.OrderWrapper> orders = new List<OrdersByClientResponseWrapper.OrderWrapper>();
        
        for (Order order :foundOrders) {
            OrdersByClientResponseWrapper.OrderWrapper processedOrder = new OrdersByClientResponseWrapper.OrderWrapper();
            processedOrder.id = order.Id;
            processedOrder.startDate = order.EffectiveDate;
            processedOrder.endDate = order.EndDate;
            processedOrder.status = order.Status;
            processedOrder.offerDate = order.SLA_Offers_Date__c;
            processedOrder.cargoWeight = order.Cargo_weight__c;
            processedOrder.cargoType = order.Cargo_type__c;
            processedOrder.toCity = order.To_City__c;
            processedOrder.fromCity = order.From_City__c;
            orders.add(processedOrder);
        }
        responseBody.clientId = clientId;
        responseBody.status = Constants.VALUE_SUCCESS;
        responseBody.error = null;
        responseBody.orders = orders;           
        return responseBody;
    }
}