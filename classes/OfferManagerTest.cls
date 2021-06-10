@IsTest
private class OfferManagerTest {
    
    @TestSetup
    private static void setup() {
        TestDataFactory.createOffers();    
    }
    
    @IsTest
    private static void testGetOffersStatusNewByOrder() {
        List<Offer__c> testOffers = getTestOffers();
        String orderId = testOffers[0].Order__c;
        List<Offer__c> foundOffers = OfferManager.getOffersStatusNewByOrder(orderId);
        System.assertEquals(testOffers[0].Id, foundOffers[0].Id);
    }
    
    @IsTest
    private static void testGetOffersStatusNewByOrderNullParam() {
        String orderId;
        List<Offer__c> foundOffers = OfferManager.getOffersStatusNewByOrder(orderId);
        System.assertEquals(0, foundOffers.size());
    }
    
    @IsTest
    private static void testGetOfferById() {
        List<Offer__c> testOffers = getTestOffers();
        String offerId = testOffers[0].Id;
        Offer__c foundOffer = OfferManager.getOfferById(offerId);
        System.assertEquals(testOffers[0].Id, foundOffer.Id);
    }
    
    @IsTest
    private static void testGetOfferByIdNullParam() {
        String offerId;
        Offer__c foundOffer = OfferManager.getOfferById(offerId);
        System.assertEquals(new Offer__c(), foundOffer);
    }
    
    private static List<Offer__c> getTestOffers() {
        List<Offer__c> testOffers = [
            SELECT Id,
            Order__c,
            Status__c
            FROM Offer__c
        ];
        return testOffers;
    }
}