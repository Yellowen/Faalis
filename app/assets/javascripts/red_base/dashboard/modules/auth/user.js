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
var User = angular.module("User", ["API", "ListView"]);

User.config(["$routeProvider","APIProvider", function($routeProvider, APIProvider){

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
    APIProvider.resource("users");
}]);

User.controller("UsersController", ["$scope", "API","gettext",
                                    function($scope, API, gettext){


    API.getList().then(function(data){
        $scope.users = data;
    });

    $scope.details_template = template("auth/users/details");

    $scope.buttons = [
        {
            title: gettext("New"),
            icon: "fa fa-plus",
            classes: "btn small green",
            route: "#/auth/users/new"
        }
    ];
}]);


User.controller("AddUsersController", ["$scope","API",function($scope, API){
    $scope.new_user = function() {
        API.all('users').post($scope.user);
    };
}]);

User.controller("EditUsersController", [function($scope, API){

}]);
