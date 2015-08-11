var User = angular.module("User", ["ListView", "Errors", "ui.router"]);

User.config(["$stateProvider", function($stateProvider){

    $stateProvider.
        state("users", {
            url: "/auth/users",
            templateUrl: template("auth/users/index"),
            controller: "UsersController"
        });
}]);
