


var Auth = angular.module("Auth", ["User","Group"]);

Auth.config(["$routeProvider", function($routeProvider){
    $routeProvider.
        when("/auth", {
            templateUrl: template("auth/index")
        });
}]);

Auth.controller("AuthMenuController", ["$scope", "gettext", function($scope, gettext){
    this.menu_items = [
        {title: gettext("Users"), url: "/auth/users", permission: {action: "read", model: "Faalis::User"}},
        {title: gettext("Groups"), url: "/auth/groups", permission: {action: "read", model: "Faalis::Group"}}
        ];
}]);
