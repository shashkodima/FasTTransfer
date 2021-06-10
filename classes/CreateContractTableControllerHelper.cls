public class CreateContractTableControllerHelper {
    
    public static List<CreateConractTableWrapper> creatWrappers(List<Offer__c> offers) {
        if (offers.isEmpty() || offers == null) {
            return new List<CreateConractTableWrapper>();
        }
        List<CreateConractTableWrapper> createdWrappers = new List<CreateConractTableWrapper>();
        Map<Id, String> userIdWithCompanyName = new Map<Id, String>();
        List<User> usersWithCompanyName = UserManager.getUsersWithCompanyName();
        
        for(User user :usersWithCompanyName) {
            userIdWithCompanyName.put(user.Id, user.CompanyName);
        }
        
        for (Offer__c offer : offers) {
            CreateConractTableWrapper newWrapper = new CreateConractTableWrapper();
            newWrapper.id = offer.Id;
            newWrapper.name = offer.Name;
            newWrapper.maxPrice = offer.Max_Price__c;
            newWrapper.minPrice = offer.Min_Price__c;
            newWrapper.closeDate = offer.Closed_Date__c;
            newWrapper.companyName = userIdWithCompanyName.get(offer.Shipping_Company_Owner__c);
            createdWrappers.add(newWrapper);
        }
        return createdWrappers;
    }
    
    public static void createNewContract (Order order, Offer__c offer) {
        if (order == null || offer == null) {
            return;
        }
        List<User> customerUser = UserManager.getUserByContactId(order.ShipToContactId);
        Contract newContract = new Contract();
        newContract.AccountId = order.AccountId;
        newContract.OwnerId = UserInfo.getUserId();
        newContract.Status = Constants.STATUS_DRAFT;
        newContract.SpecialTerms = offer.Special_Terms__c;
        newContract.CustomerSignedDate = Date.valueOf(offer.Closed_Date__c);
        newContract.Price__c = (offer.Max_Price__c + offer.Min_Price__c)/2;
        newContract.ClientUser__c = customerUser[0].Id;
        newContract.Order__c = order.Id;
        newContract.Shipping_CompanyUser__c = offer.Shipping_Company_Owner__c;
        newContract.StartDate = Date.today();
        insert newContract;
        
        offer.Status__c = Constants.STATUS_WINNER;
        update offer;
        List<Offer__c> offersToUpdate = new List<Offer__c>();
        List<Offer__c> loserOffers = OfferManager.getOffersStatusNewByOrder(order.Id);
        
        for (Offer__c loserOffer :loserOffers) {
            loserOffer.Status__c = Constants.STATUS_LOSER;
            offersToUpdate.add(loserOffer);
        }
        update offersToUpdate;
        
        Opportunity relatedOpportunity = OpportunityManager.getById(order.OpportunityId);
        relatedOpportunity.StageName = Constants.STAGE_PRICE_QUOTE;
        update relatedOpportunity;
    }
}