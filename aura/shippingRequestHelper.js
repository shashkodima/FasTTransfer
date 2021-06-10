({
    sendData : function(component, actionName, data) {
        let action = component.get(actionName);
        action.setParams({ requestData : data });
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