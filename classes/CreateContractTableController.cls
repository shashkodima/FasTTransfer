public with sharing class CreateContractTableController {
    
    @AuraEnabled
    public static List<CreateConractTableWrapper> getOffers(String orderId) {
        List<Offer__c> foundOffers = new List<Offer__c>();
        List<CreateConractTableWrapper> offersWithShippingCompany= new List<CreateConractTableWrapper>();
        foundOffers = OfferManager.getOffersStatusNewByOrder(orderId);
        offersWithShippingCompany = CreateContractTableControllerHelper.creatWrappers(foundOffers);
        return offersWithShippingCompany;
    }
    
    @AuraEnabled
    public static void createContract(String offerDataJSON) {
        List<CreateConractTableWrapper> offerData = (List<CreateConractTableWrapper>)JSON.deserialize(offerDataJSON, List<CreateConractTableWrapper>.class);
        Offer__c selectedOffer = OfferManager.getOfferById(offerData[0].id);
        Order order = OrderManager.getOrderById(selectedOffer.Order__c);
        CreateContractTableControllerHelper.createNewContract(order, selectedOffer);
    }
}