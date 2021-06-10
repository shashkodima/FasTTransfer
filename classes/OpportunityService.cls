public class OpportunityService {
    
    public static void creatOpportunityFromShippingRequest (Account account, ShippingRequestWrapper requestData) {
        if (account == null || requestData == null) {
            return;
        }
        Opportunity newOpportunity = new Opportunity();
        newOpportunity.Name = requestData.shippingName;
        newOpportunity.AccountId = account.Id;
        newOpportunity.Amount = Constants.AMOUNT_ZERO;
        newOpportunity.StageName = Constants.STAGE_NEW;
        newOpportunity.OwnerId = account.OwnerId;
        newOpportunity.CloseDate = Date.today().toStartOfMonth().addMonths(1) - 1; //last day of the month
        newOpportunity.Probability = 10;
        newOpportunity.Shiping_Name__c = requestData.shippingName;
        newOpportunity.Cargo_weight__c = requestData.cargoWeight;
        newOpportunity.Cargo_type__c = requestData.cargoType;
        newOpportunity.To_City__c = requestData.toCity;
        newOpportunity.From_City__c = requestData.fromCity;
        insert newOpportunity;
    }
}