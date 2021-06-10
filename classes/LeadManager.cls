public class LeadManager {
    
    public static List<Lead> getLeadsById(Set<Id> leadsIds) {
        if (leadsIds.isEmpty() || leadsIds == null) {
            return new List<Lead>();
        }
        List<Lead> foundLeads = [
            SELECT Id,
            Phone
            FROM Lead
            WHERE Id IN :leadsIds
        ];
        return foundLeads;
    }
    
    public static List<Lead> getLeadsByEmailOrPhone(String email, String phone) {
        if(String.isBlank(email) && String.isBlank(phone)) {
            return new List<Lead>();
        }
        List<Lead> foundLeads = [
            SELECT Id,
            FirstName,
            LastName,
            OwnerId,
            Status,
            Company,
            Email,
            Phone
            FROM Lead
            WHERE Phone = :phone
            OR Email = :email
        ];
        return foundLeads;
    }
}