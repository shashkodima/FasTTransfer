public class OrdersByClientResponseWrapper {
    public String clientId;
    public String status;
    public String error;
    public List<OrderWrapper> orders;
    
    public class OrderWrapper {
        public String id;
        public Date startDate;
        public Date endDate;
        public String status;
        public Datetime offerDate;
        public Decimal cargoWeight;
        public String cargoType;
        public String toCity;
        public String fromCity;
    } 
}