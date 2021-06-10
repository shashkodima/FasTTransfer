@IsTest
private class CalloutHelperTest {
    
    @IsTest
    private static void testFindCountryByPhone() {
        Test.setMock(HttpCalloutMock.class, new RestCountriesHTTPCalloutMock());
        String testPhone = '+375-29-5332273';

        Test.startTest();
        String country = CalloutHelper.findCountryByPhone(testPhone);
        Test.stopTest();

        System.assert(true, country.length() > 0);
    }
}