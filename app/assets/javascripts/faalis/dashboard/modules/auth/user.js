

var User = angular.module("User", ["ListView", "Errors"]);

User.config(["$routeProvider", function($routeProvider){

    $routeProvider.
        when("/auth/users", {
            templateUrl: template("auth/users/index"),
            controller: "UsersController"
        }).
        when("/auth/users/new",{
            templateUrl: template("auth/users/new"),
            controller: "AddUsersController"
        }).
        when("/auth/users/:id/edit",{
            templateUrl: template("auth/users/new"),
            controller: "AddUsersController"
        });
}]);

User.controller("UsersController", ["$scope", "Restangular","gettext", "catch_error",
                                    function($scope, API, gettext, catch_error){

    $scope.details_template = template("auth/users/details");

    API.all("users").getList().then(function(data){
        $scope.users = data;
    });

    $scope.buttons = [
        {
            title: gettext("New"),
            icon: "fa fa-plus",
            classes: "btn tiny green",
            route: "#/auth/users/new"
        }
    ];


    $scope.on_delete = function(users){
        var query = [];
        users.forEach(function(user){
            query.push(user.id);
        });

        API.all("users").customDELETE(query.join(","))
            .then(function(data) {

                $scope.users = _.filter($scope.users, function(x){
                    return !(query.indexOf(x.id) != -1);
                });
                success_message(data.msg);
            })
            .catch(catch_error);

    };


}]);


User.controller("AddUsersController", ["$scope","Restangular","$location" ,"$routeParams", "gettext", "catch_error", function($scope, API, $location , $routeParams, gettext, catch_error){

    API.all("groups").getList().then(
        function(data){
            $scope.groups = data;
        });

    $scope.obj_id = null;
    if("id" in $routeParams){
        $scope.obj_id = $routeParams.id;
        var obj = API.one("users", $scope.obj_id).get()
                .then(function(data){
                    $scope.first_name = data.first_name;
                    $scope.last_name = data.last_name;
                    $scope.email = data.email;
                    $scope.group = data.group;
                    $scope.password = data.password;
                });
    }
    $scope.save = function() {
        var user = {
            first_name: $scope.first_name,
            last_name: $scope.last_name,
            email: $scope.email,
            password: $scope.password,
            group: $scope.group
        };
        if ($scope.obj_id){
            API.one("users",$scope.obj_id).patch(user).then(function(){
                success_message(gettext("User updated successfully."));
                $location.path("/auth/users");
                });
        }else{
            API.all("users").post(user).then(function(){
                success_message(gettext("User created Successfully"));
                $location.path("/auth/users");
            }).catch(catch_error);
        }
    };

    $scope.cancel = function(){
        $(".form input").val("");
        $location.path("auth/users");
    };
}]);
