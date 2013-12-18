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

var Modules = angular.module("Modules", ["ngRoute", "ngAnimate"]);

Modules.controller("ModulesController", ["$location", "$scope", "$controller", function($location, $scope, $controller){
    var that = this;
    this.modules = _.filter(DModules, function(module){
        if (module.sidemenu === true) {
            module.menu_items = $controller("AuthMenuController", {$scope: $scope}).menu_items;
            module.show_menu = false;
        }
        return module.sidemenu || false;
    });

    this.on_click = function(url){
        $location.path(url);
    };
    this.view_menu = function(module) {
        module.show_menu = !module.show_menu;
    };
}]);

Modules.animation(".slide", function(){
    return {
        leave: function(elem, done){
            $(elem).slideUp(700, done);
        },
        enter: function(elem, done){
            $(elem).slideDown(700, done);
            return function(cancelled){};
        }
    };
});
