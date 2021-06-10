({
    doInit : function(component, event, helper) {
        const userId = $A.get("$SObjectType.CurrentUser.Id");
        if(userId == null) {
            component.set("v.unidentifiedCustomer", "true");
        }    
    },
    
    request : function(component, event, helper) {
        const company = component.get("v.nameCompany");
        const companyEmail = component.get("v.companyEmail");
        const companyPhone = component.get("v.companyPhone");
        const companyType = component.get("v.companyType");  
        const contactFirstName = component.get("v.contactFirstName");
        const contactLastName = component.get("v.contactLastName");
        const contactEmail = component.get("v.contactEmail");
        const contactPhone = component.get("v.contactPhone");
        const shippingName = component.get("v.shippingName");
        const cargoWeight = component.get("v.cargoWeight");
        const cargoType = component.get("v.cargoType");
        const fromCity = component.get("v.fromCity");
        const toCity = component.get("v.toCity");
        const orderDate = component.get("v.orderDate");
        const comments = component.get("v.comments");
        const userId = $A.get("$SObjectType.CurrentUser.Id"); 
            
        let allValid = component.find("inputData").reduce(function (validSoFar, inputCmp) {
            inputCmp.reportValidity();
            return validSoFar && inputCmp.checkValidity();
        }, true);
        if(fromCity == toCity) {
            allValid = false;
            const title = $A.get("$Label.c.Error");
            const message = $A.get("$Label.c.FromToCityError");
            const type = "error";  
            helper.showToast(title, message, type);
        } 
        if (allValid) {
            helper.sendData(component, "c.proccessData", {
                companyName: company,
                companyEmail: companyEmail,
                companyPhone: companyPhone,
                companyType: companyType,
                contactFirstName: contactFirstName,
                contactLastName: contactLastName,
                contactEmail: contactEmail,
                contactPhone: contactPhone,
                shippingName: shippingName,
                cargoWeight: cargoWeight,
                cargoType: cargoType,
                fromCity: fromCity,
                toCity: toCity,
                orderDate: orderDate,
                comments: comments,
                userId : userId,
            });
            const title = $A.get("$Label.c.Success");
            const message = $A.get("$Label.c.SuccessRequestMessage");
            const type = "success";  
            helper.showToast(title, message, type);
        } else {
            const title = $A.get("$Label.c.Error");
            const message = $A.get("$Label.c.WrongFieldsMessage");
            const type = "error";  
            helper.showToast(title, message, type);
        } 
    }
});