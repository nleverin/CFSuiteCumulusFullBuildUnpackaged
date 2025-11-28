({
	doInit : function(component, event, helper) {
		var isPhone = $A.get("$Browser.isPhone");
        var isTablet = $A.get("$Browser.isTablet");
        var isAndroid = $A.get("$Browser.isAndroid");
        component.set("v.isMobile", isPhone || isTablet || isAndroid);
	}
})