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

User.config(["$routeProvider", function($routeProvider, APIProvider){

    $routeProvider.
        when("/auth/users", {
            templateUrl: template("auth/users/index"),
            controller: "UsersController"
        }).
        when("/auth/users/new",{
            templateUrl: template("auth/users/new"),
            controller: "AddUsersController"
        }).
        when("/auth/users/edit/:id",{
            templateUrl: template("auth/users/new"),
            controller: "EditUsersController"
        });
}]);

User.controller("UsersController", ["$scope", "Restangular","gettext",
                                    function($scope, API, gettext){

    $scope.details_template = template("auth/users/details");

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

        API.all("users").customDELETE("", {id: query.join(",")}).then(function() {

            query.forEach(function(x){
                $scope.users = _.without($scope.users, x);
            });

        });
    };

}]);


User.controller("AddUsersController", ["$scope","Restangular","$location",function($scope, API){

    API.all("groups").getList().then(
        function(data){
            $scope.groups = data;
        });

    $scope.save = function() {
        API.all("users").post($scope.user);
    };

    $scope.cansel = function(){
        $(".form input").val("");
    };
}]);

User.controller("EditUsersController", [function($scope, API){

}]);
