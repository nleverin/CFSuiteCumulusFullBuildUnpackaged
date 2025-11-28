({
    getUserData : function(component) {
        var actionUserData = component.get("c.getUserData");
        actionUserData.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var data = response.getReturnValue();
                console.log(data);
                component.set("v.isUserGuest", data.isGuest);
                component.set("v.name", data.firstName);
                component.set("v.photoUrl", data.smallPhotoUrl);
                component.set("v.notificationCount", data.notificationCount);
                
                if (typeof(window.localStorage) !== "undefined") {
                    var guestStorageKey = component.get("v.guestStorageKey");
                    localStorage.setItem(guestStorageKey, data.isGuest);
                }
            }
            else {
                var errors = response.getError();
                console.log("getUserData failed: " + errors);
            }
        });
        $A.enqueueAction(actionUserData);
    }
})