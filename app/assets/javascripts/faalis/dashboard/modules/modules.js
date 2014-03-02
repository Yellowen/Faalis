// Module module :P
var Modules = angular.module("Modules", ["ngRoute", "ngAnimate"]);

// This controller is responsible to parse modules and load them
Modules.controller("ModulesController", ["$location", "$scope", "$controller", "UserPermissions", function($location, $scope, $controller, User){
    var that = this;
    this.modules = _.filter(DModules, function(module){

        // Check if current module should be appear in side bar
        if (module.sidemenu === true) {

            // If module is a sidebar module, it have to have a controller which
            // represent the submenu. Name of the controller should be like:
            // ```javascript
            ///    <modulename>MenuController
            ///```
            var menu_items = $controller(camelCase(module.resource) + "MenuController", {$scope: $scope}).menu_items;
            module.menu_items = [];

            // Iterate over submenu items
            _.each(menu_items, function(menu) {
                // If menu item provided a permission attribute we have to check user permission for that
                if ("permission" in menu){
                    if ((!("action" in menu.permission)) || (!("model" in menu.permission))) {
                        console.log("Button permission should be an object and has 'action' and 'model' keys");
                        throw "Button permission should be an object and has 'name' and 'model' keys";
                    }
                    // Check if user can pass the permission
                    if (User.can(menu.permission.action, menu.permission.model)) {
                        console.debug("You have " + menu.permission.action + " permission on " + menu.permission.model);
                        module.menu_items.push(menu);
                    }
                    else {
                        console.debug("User don't have " + menu.permission.action + " permission on " + menu.permission.model);
                    }
                }
                else {
                    // Add item to submenu item list
                    module.menu_items.push(menu);
                }
            });
            // Close the submenu section
            module.show_menu = false;
        }
        return module.sidemenu || false;
    });

    // Event handler on menu click
    this.on_click = function(url){
        $location.path(url);
    };

    // Event handler of click on menu itself
    this.view_menu = function(module) {
        _.each(this.modules, function(x){
            if (x !== module) {
                x.show_menu = false;
            }
        });
        module.show_menu = !module.show_menu;
    };
}]);

// Animations of slide effect
Modules.animation(".slide", function(){
    return {
        leave: function(elem, done){
            $(elem).slideUp(700, done);
        },
        enter: function(elem, done){
            $(elem).slideDown(700, done);
            return function(cancelled){};
        }
    };
});
