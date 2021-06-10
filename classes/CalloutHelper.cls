public class CalloutHelper {
    public class PhoneFormatException extends Exception {}
    
    public static String findCountryByPhone(String phone) {
        String country;
        if (String.isBlank(phone)) {
            return country;
        }
        if(Pattern.matches(Constants.PHONE_PATTERN_POLAND_BELARUS_RUSSIA, phone)) {
            List<String> splitedPhone = phone.splitByCharacterType();            
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            request.setEndpoint(Constants.REST_COUNTRIES_CALLING_CODE_ENDPOINT + splitedPhone[1]);
            request.setMethod(Constants.REQUEST_METHOD_GET);
            HttpResponse response = http.send(request);
            
            if (response.getStatusCode() == Constants.STATUS_CODE_200) {
                List<Object> notProcessedBody = ( List<Object>) JSON.deserializeUntyped(response.getBody());
                String bodyJSON = JSON.serializePretty(notProcessedBody[0]);
                Map<String, Object> responseBody = (Map<String, Object>) JSON.deserializeUntyped(bodyJSON);
                country = String.valueOf(responseBody.get(Constants.RESTCOUNTRIES_JSON_RESPONSE_BODY_FORECAST_NAME_KEY));
            } 
        } else {
            throw new PhoneFormatException(Constants.MESSAGE_CALLOUT_ERROR);
        }
        return country;
    }
}