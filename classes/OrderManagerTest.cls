@IsTest
private class OrderManagerTest {
    
    @TestSetup
    private static void setup() {
        TestDataFactory.createOrdersWithAccountsContacts();    
    }
    
    @IsTest
    private static void testGetOrdersByContactId() {
        List<Order> testOrders = getTestOrders();
        String contactId = testOrders[0].ShipToContactId;
        List<Order> foundOrders = OrderManager.getOrdersByContactId(contactId);
        System.assertEquals(testOrders[0].Id, foundOrders[0].Id);
    }
    
    @IsTest
    private static void testGetOrdersByContactIdNullParam() {
        String contactId;
        List<Order> foundOrders = OrderManager.getOrdersByContactId(contactId);
        System.assertEquals(0, foundOrders.size());
    }
    
    @IsTest
    private static void testGetOrdersByAccountId() {
        List<Order> testOrders = getTestOrders();
        String testAccountId = testOrders[0].AccountId;
        List<Order> foundOrders = OrderManager.getOrdersByAccountId(testAccountId);
        System.assertEquals(testOrders[0].Id, foundOrders[0].Id);
    }
    
    @IsTest
    private static void testGetOrdersByAccountIdNullParam() {
        String testAccountId;
        List<Order> foundOrders = OrderManager.getOrdersByAccountId(testAccountId);
        System.assertEquals(0, foundOrders.size());
    }
    
    @IsTest
    private static void testGetOrdersById() {
        List<Order> testOrders = getTestOrders();
        String testId = testOrders[0].Id;
        Order foundOrder = OrderManager.getOrderById(testId);
        System.assertEquals(testOrders[0].Id, foundOrder.Id);
    }
    
    @IsTest
    private static void testGetOrdersByIdNullParam() {
        String testId;
        Order foundOrder = OrderManager.getOrderById(testId);
        System.assertEquals(new Order(), foundOrder);
    }
    
    private static List<Order> getTestOrders() {
        List<Order> testOrders = [
            SELECT Id,
            AccountId,
            ShipToContactId
            FROM Order
        ];
        return testOrders;
    }
}