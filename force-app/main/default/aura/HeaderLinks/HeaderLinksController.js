({
	onInit : function(component, event, helper) {
        
        var actionUserData = component.get("c.getUserData");
        actionUserData.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var data = response.getReturnValue();
              //  component.set("v.notificationCount", data.notificationCount);
                component.set("v.isGuest", data.isGuest);
            }
            else {
                var errors = response.getError();
                console.log("getUserData failed: " + JSON.stringify(errors));
            }
        });
        $A.enqueueAction(actionUserData);
    },
})