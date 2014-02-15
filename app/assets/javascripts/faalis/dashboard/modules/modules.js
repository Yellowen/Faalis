var Modules = angular.module("Modules", ["ngRoute", "ngAnimate"]);

Modules.controller("ModulesController", ["$location", "$scope", "$controller", "UserPermissions", function($location, $scope, $controller, User){
    var that = this;
    this.modules = _.filter(DModules, function(module){
        if (module.sidemenu === true) {
            var menu_items = $controller(camelCase(module.resource) + "MenuController", {$scope: $scope}).menu_items;
            module.menu_items = [];
            _.each(menu_items, function(menu) {
                if ("permission" in menu){
                    if ((!("action" in menu.permission)) || (!("model" in menu.permission))) {
                        console.log("Button permission should be an object and has 'action' and 'model' keys");
                        throw "Button permission should be an object and has 'name' and 'model' keys";
                    }
                    if (User.can(menu.permission.action, menu.permission.model)) {
                        module.menu_items.push(menu);
                    }
                }
                else {
                    module.menu_items.push(menu);
                }
            });
            module.show_menu = false;
        }
        return module.sidemenu || false;
    });

    this.on_click = function(url){
        $location.path(url);
    };
    this.view_menu = function(module) {
        _.each(this.modules, function(x){
            if (x !== module) {
                x.show_menu = false;
            }
        });
        module.show_menu = !module.show_menu;
    };
}]);

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
