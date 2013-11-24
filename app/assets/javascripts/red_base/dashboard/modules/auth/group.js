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

var Group = angular.module("Group", ["API"]);

Group.config(["$routeProvider", "APIProvider", function($routeProvider, APIProvider){
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

    APIProvider.resource("groups");

}]);

Group.controller("GroupsController", ["$scope", "API", "gettext",
                                      function($scope, API, gettext){
    $scope.details_template = template("auth/groups/details");

    $scope.buttons = [
        {
            title: gettext("new"),
            icon: "fa fa-plus",
            classes: "btn tiny green",
            route: "#/auth/groups/new"

        }
    ];
    API.getList().then(function(data){
        $scope.groups = data;
    });

}]);

Group.controller("AddGroupController", ["Restangular", "$scope", "API", function(Restangular, $scope, API){

    var permissions = Restangular.all('permissions').getList()
            .then(function(data){
                $scope.permissions = data;
                console.dir($scope.permissions);
            });

    $scope.select_permission = function(perm){
        if( "is_selected" in perm ){
            perm.is_selected = ! perm.is_selected;
            return;
        }
        perm.is_selected = true;
    };

    $scope.is_selected = function(perm){
        if( "is_selected" in perm ){
            return perm.is_selected;
        }
        return false;
    };

    $scope.cancel = function(){
        $(".form input").val("");
        for(var i = 0; i < $scope.permissions.length;i++) {
            $scope.permissions[i].is_selected = false;
        }
    };

    $scope.save = function(){
        var permissions = [];

        for(var i = 0; i < $scope.permissions.length;i++) {
            if ($scope.permissions[i].is_selected){
                permissions.push($scope.permissions[i].name);
            }
        }

        var group = {name: $scope.new_name,
                     permissions: permissions};
        API.post(group);
        console.log(_);
    };
}]);

Group.controller("EditGroupController",[function($scope, $routeParams){

}]);
