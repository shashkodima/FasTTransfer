public class CreateConractTableWrapper {
    @AuraEnabled
    public Id id{get;set;}
    @AuraEnabled
    public String name{get;set;}
    @AuraEnabled
    public Decimal maxPrice{get;set;}
    @AuraEnabled
    public Decimal minPrice{get;set;}
    @AuraEnabled
    public Datetime closeDate{get;set;}
    @AuraEnabled
    public String companyName{get;set;}
}