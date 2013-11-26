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

var Group = angular.module("Group", ["ListView"]);

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
        when("/auth/groups/:id/edit",{
            templateUrl: template("auth/groups/new"),
            controller: "EditGroupsController"
        });

}]);

Group.controller("GroupsController", ["$scope", "gettext", "Restangular",
                                      function($scope, gettext, API){
    $scope.details_template = template("auth/groups/details");

    $scope.buttons = [
        {
            title: gettext("new"),
            icon: "fa fa-plus",
            classes: "btn tiny green",
            route: "#/auth/groups/new"

        }
    ];

    $scope.on_delete = function(groups){

        var query = [];
        groups.forEach(function(group){
            query.push(group.id);
        });

        API.several("groups", 2, 4).remove().then(function() {//.customDELETE("", {id: query.join(",")})

            query.forEach(function(x){
                $scope.groups = _.without($scope.groups, x);
            });

        });
    };

    API.all("groups").getList().then(function(data){
        $scope.groups = data;
    });

}]);

Group.controller("AddGroupController", ["Restangular", "$scope", "$location", function(API, $scope, $location){

    var permissions = API.all('permissions').getList()
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
        API.all("groups").post(group).then(function(){
            $location.path("/auth/groups");
        });

    };
}]);

Group.controller("EditGroupController",[function($scope, $routeParams){

}]);
