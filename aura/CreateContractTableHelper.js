({
    getData : function(component, actionName, parameters) {
        let action = component.get(actionName);
        action.setParams({orderId : parameters});
        action.setCallback(this, $A.getCallback(function (response) {
            let state = response.getState();
            if (state == "SUCCESS") {
                component.set("v.mydata", response.getReturnValue());
            } else if (state == "ERROR") {
                let errors = response.getError();
                console.error(errors);
            }
        }));
        $A.enqueueAction(action);
    },
    
    sendData : function(component, actionName, offerDataJSON) {
        let action = component.get(actionName);
        action.setParams({offerDataJSON : offerDataJSON});
        $A.enqueueAction(action);
    },
    
    showToast : function(title, msh, type) {
        let toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title" :title,
            "message" :msh,
            "type" :type
        });
        toastEvent.fire();
    }
})