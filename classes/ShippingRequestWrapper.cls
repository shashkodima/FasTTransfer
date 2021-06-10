public class ShippingRequestWrapper {
    @AuraEnabled
    public String companyName{get;set;}
    @AuraEnabled
    public String companyEmail{get;set;}
    @AuraEnabled
    public String companyPhone{get;set;}
    @AuraEnabled
    public String companyType{get;set;}
    @AuraEnabled
    public String contactFirstName{get;set;}
    @AuraEnabled
    public String contactLastName{get;set;}
    @AuraEnabled
    public String contactEmail{get;set;}
    @AuraEnabled
    public String contactPhone{get;set;}
    @AuraEnabled
    public String shippingName{get;set;}
    @AuraEnabled
    public Integer cargoWeight{get;set;}
    @AuraEnabled
    public String cargoType{get;set;}
    @AuraEnabled
    public String fromCity{get;set;}
    @AuraEnabled
    public String toCity{get;set;}
    @AuraEnabled
    public Date orderDate{get;set;}
    @AuraEnabled
    public String comments{get;set;}
    @AuraEnabled
    public String userId{get;set;}
}