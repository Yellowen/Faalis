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

var Group = angular.module("Group", []);

Group.config(["$routeProvider", function($routeProvider){
    $routeProvider.
        when("/auth/groups",{
            templateUrl: template("auth/groups/index"),
            controller: "GroupsController"
        }).
        when("/auth/groups/new",{
            templateUrl: template("auth/groups/new"),
            controller: "AddGroupController"
        }).
        when("/auth/groups/edit/:id",{
            templateUrl: template("auth/groups/new"),
            controller: "EditGroupsController"
        });
}]);


Group.controller("GroupsController", [function(){
}]);

Group.controller("AddGroupController", [function(){

}]);

Group.controller("EditGroupController",[function($scope, $routeParams){

}]);
