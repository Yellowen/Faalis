

var Profile = angular.module("Profile", []);

Profile.config(["$routeProvider", function($routeProvider){

    $routeProvider.
        when("/auth/profile/edit",{
            templateUrl: template("auth/profile/edit"),
            controller: "ProfileController"
        });
}]);



Profile.controller("ProfileController",  ["$scope","Restangular","$location" ,"$routeParams", "gettext", "catch_error", function($scope, API, $location , $routeParams, gettext, catch_error){
    var obj = API.one("profile").get()
            .then(function(data){
                $scope.first_name = data.first_name;
                $scope.last_name = data.last_name;
                $scope.email = data.email;

            });
    $scope.save = function() {
        var user = {
            first_name: $scope.first_name,
            last_name: $scope.last_name,
            email: $scope.email,
            password: $scope.password,
            password_confirmation: $scope.password_confirmation
        };
        API.one("profile").patch(user).then(function(){
            success_message(gettext("Profile updated successfully."));
        }).catch(catch_error);
    };

    $scope.cancel = function(){
        $(".form input").val("");
        $location.path("/");
    };

}]);
