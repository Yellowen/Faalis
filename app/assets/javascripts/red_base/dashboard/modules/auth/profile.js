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
        when("/auth/profile",{
            templateUrl: template("auth/profile/index"),
            controller: "ProfileController"
        }).
        when("/auth/profle/edit",{
            templateUrl: template("auth/profile/edit"),
            controller: "EditProfileController"
        });
}]);



Profile.controller("ProfileController", ["$scope", "Restangular","gettext", "catch_error",
                                         function($scope, API, gettext, catch_error){
                                             API.one("profile").get().then(
                                                 function(data){
                                                     $scope.profle = data;
                                                 });

                                         }]);
