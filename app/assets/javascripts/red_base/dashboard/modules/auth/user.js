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
var User = angular.module("User", ["ListView", "restangular"]);

User.config(["$routeProvider", function($routeProvider){
    $routeProvider.
        when("/auth/users", {
            templateUrl: template("auth/users/index"),
            controller: "UsersController",
            controllerAs: "controller"
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


User.controller("UsersController", ["$scope", "Restangular", function($scope, Restangular){

    $scope.allUsers = Restangular.all('users').getList().then(function(users){
        $scope.allUsers = users;
        console.log(users);

    });

    $scope.users = [
        {
            id: 2,
            email: "lasdasdxsameer@gnu.org"
        },
        {
            id: 2,
            email: "lxsameesdfsdfgr@gnu.org"
        },
        {
            id: 2,
            email: "r23erglxsameer@gnu.org"
        },
        {
            id: 2,
            email: "lxsamvafvadfvadfvdfveer@gnu.org"
        },
        {
            id: 2,
            email: "@gnu.org"
        },
        {
            id: 2,
            email: "lasdassss!!!xsameer@gnu.org"
        },

        {
            id: 3,
            email: "lasdxsameer@gnu.org"
        }


    ];

    $scope.details_template = template("auth/users/details");

    $scope.buttons = [
        {
            title: "New",
            icon: "fa fa-plus",
            classes: "btn small green",
            route: "#/auth/users/new"
        },
        {
            title: "Someshiasdast",
            icon: "fa fa-times",
            classes: "btn small red",
            action: "alert"
        }

    ];
}]);

User.controller("AddUsersController", [function(Restangular){
}]);

User.controller("EditUsersController", [function($scope, $routeParams, Restangular){

}]);
