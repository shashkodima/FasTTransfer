public class UserManager {
    
    public static User getUserById(String userId) {
        if (String.isBlank(userId)) {
            return new User();
        }
        User foundUser = [
            SELECT Name,
            ContactId
            FROM User
            WHERE Id = :userId
        ];
        return foundUser;
    }
    
    public static List<User> getUsersSalesManager(String profileId) {
        if (String.isBlank(profileId)) {
            return new List<User>();
        }
        List<User> salesManagers = [
            SELECT Id
            FROM User
            WHERE ProfileId = :profileId
        ];
        return salesManagers; 
    }
    
    public static List<User> getUsersWithCompanyName() {
        List<User> usersWithCompanyName = [
            SELECT Id,
            CompanyName
            FROM User
        ];
        return usersWithCompanyName;
    }
    
    public static List<User> getUserByContactId(String contactId) {
        if (String.isBlank(contactId)) {
            return new List<User>();
        }
        List<User> foundUser = [
            SELECT Id
            FROM User
            WHERE ContactId = :contactId
        ];
        return foundUser;
    }
}