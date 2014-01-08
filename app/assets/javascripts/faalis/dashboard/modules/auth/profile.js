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
