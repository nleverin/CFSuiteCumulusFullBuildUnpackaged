({
    doInit : function(component, event, helper) {
        // use localStorage for storing profile values, to avoid server calls on each page load
        var host = location.host;
        var isGuestKey = host + ".isGuest";
        
        component.set("v.guestStorageKey", isGuestKey);
        
        // check localstorage
        if (typeof(window.localStorage) !== "undefined") {
            var isGuest = localStorage.getItem(isGuestKey);
            
            if(name && typeof(isGuest) !== "undefined") {
                component.set("v.isUserGuest", isGuest === "true");
            }
        }
        // read data
        helper.getUserData(component);
        
        var actionLoginUrl = component.get("c.getLoginUrl");
        actionLoginUrl.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var data = response.getReturnValue();
                component.set("v.loginUrl", data);
            }
            else {
                var errors = response.getError();
                console.log("getLoginUrl failed: " + errors);
            }
        });
        
        $A.enqueueAction(actionLoginUrl);
    },
    
    menuToggle : function(component, event, helper) {
        var menu = component.find("profile-menu");
        $A.util.toggleClass(menu, "slds-is-open");
    },
    
    menuClose : function(component, event, helper) {
        var menu = component.find("profile-menu");
        $A.util.removeClass(menu, "slds-is-open");
    },
    
    handleLogout : function(component, event, helper) {
        // clear localStorage
        if (typeof(window.localStorage) !== "undefined") {
            var isGuestKey = component.get("v.guestStorageKey");
            
            localStorage.setItem(isGuestKey, true);
        }
        
        window.location.replace("/secur/logout.jsp");
    }
})