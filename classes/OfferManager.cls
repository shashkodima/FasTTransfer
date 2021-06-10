public class OfferManager {
    
    public static List<Offer__c> getOffersStatusNewByOrder(String orderId) {
        if (String.isBlank(orderId)) {
            return new List<Offer__c>();
        }
        List<Offer__c> foundOffers = new List<Offer__c>();
        foundOffers = [
            SELECT Id,
            Name,
            Max_Price__c,
            Min_Price__c,
            Closed_Date__c,
            Shipping_Company_Owner__c
            FROM Offer__c
            WHERE Order__c = :orderId
            AND Status__c = :Constants.STAGE_NEW            
        ];
        return foundOffers;
    }
    
    public static Offer__c getOfferById(String offerId) {
        if (String.isBlank(offerId)) {
            return new Offer__c();
        }
        Offer__c foundOffer = [
            SELECT Id,
            Name,
            Order__c,
            Max_Price__c,
            Min_Price__c,
            Closed_Date__c,
            Shipping_Company_Owner__c,
            Special_Terms__c,
            Status__c
            FROM Offer__c
            WHERE Id = :offerId    
        ];
        return foundOffer;
    }
}