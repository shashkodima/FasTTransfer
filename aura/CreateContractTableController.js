({
    init: function (component, event, helper) {
        component.set("v.mycolumns", [
            { label: "Name", fieldName: 'name', type: 'text', hideDefaultActions: true},
            { label: "Max Price,$", fieldName: "maxPrice", type: "currency", hideDefaultActions: true},
            { label: "Min Price,$", fieldName: "minPrice", type: "currency", hideDefaultActions: true},
            { label: "Closed Date", fieldName: "closeDate", type: "date", hideDefaultActions: true},
            { label: "Shipping Company Name", fieldName: "companyName", type: "Text", hideDefaultActions: true}
        ]);
        const recordId = component.get("v.recordId")
        helper.getData(component, "c.getOffers", recordId);
    },
    
    chooseoffer: function (component, event, helper) {
        let selectLines = [];
        selectLines = component.find("table").getSelectedRows();
        if (selectLines.length == 0) {
            const title = $A.get("$Label.c.Error");
            const message =  $A.get("$Label.c.ChooseOneOffer");
            const type =  "error";  
            helper.showToast(title, message, type);
        } else {
            const selectLinesJSON = JSON.stringify(selectLines);
            helper.sendData(component, "c.createContract", selectLinesJSON);
            const title = $A.get("$Label.c.Success");
            const message =  $A.get("$Label.c.NewContractCreated");
            const type =  "success";  
            helper.showToast(title, message, type);
            
            let dismissActionPanel = $A.get("e.force:closeQuickAction");
            dismissActionPanel.fire();
        }   
    },
})