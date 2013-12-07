/* -----------------------------------------------------------------------------
    Red Base - Basic website skel engine
    Copyright (C) 2012-2013 Yellowen

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License along
    with this program; if not, write to the Free Software Foundation, Inc.,
    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
----------------------------------------------------------------------------- */
var User = angular.module("User", ["ListView"]);

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

User.controller("UsersController", ["$scope", "Restangular","gettext",
                                    function($scope, API, gettext){

    $scope.details_template = template("auth/users/details");

    API.all("users").getList().then(function(data){
        $scope.users = data;
    });

    $scope.buttons = [
        {
            title: gettext("New"),
            icon: "fa fa-plus",
            classes: "btn small green",
            route: "#/auth/users/new"
        }
    ];

    $scope.on_delete = function(users){
        var query = [];
        users.forEach(function(user){
            query.push(user.id);
        });

        API.several("users", 2, 4).remove().then(function() {//.customDELETE("", {id: query.join(",")})

            query.forEach(function(x){
                $scope.users = _.without($scope.users, x);
            });

        });
    };

}]);


User.controller("AddUsersController", ["$scope","Restangular","$location" ,"$routeParams", "gettext" ,function($scope, API, $location , $routeParams, gettext){

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

    $scope.cansel = function(){
        $(".form input").val("");
    };
}]);
