@IsTest
private class OrderRequestValidationTest {

    @IsTest
    private static void testCheckClientNotFound() {
        List<String> errorsList = new List<String>();
        try{
            OrderRequestValidation.checkClientNotFound(null);
        } catch (OrderRequestValidation.OrderRequestException exc)  {
            errorsList.add(exc.getMessage());
        }
        System.assertEquals(true, errorsList.size() > 0);
    }

    @IsTest
    private static void testCheckClientIdIsBlank() {
        List<String> errorsList = new List<String>();
        try{
            OrderRequestValidation.checkClientIdIsBlank(null);
        } catch (OrderRequestValidation.OrderRequestException exc)  {
            errorsList.add(exc.getMessage());
        }
        System.assertEquals(true, errorsList.size() > 0);
    }
}