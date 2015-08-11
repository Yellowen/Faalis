var Auth = angular.module("Auth", ["User","Group", "ui.router"]);

/*Auth.config(["$stateProvider", function($stateProvider){
    $routeProvider.
        state("auth", {
            url: "/auth",
            templateUrl: template("auth/index")
        });
}]);
*/

Auth.controller("AuthMenuController", ["$scope", "gettext", function($scope, gettext){
    this.menu_items = [
        {title: gettext("Users"), url: "/auth/users", permission: {action: "read", model: "Faalis::User"}},
        {title: gettext("Groups"), url: "/auth/groups", permission: {action: "read", model: "Faalis::Group"}}
        ];
}]);
