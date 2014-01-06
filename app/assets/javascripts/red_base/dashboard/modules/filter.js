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

var Filter = angular.module("Filter", ["Errors"]);

/*
 * <filter></filter> directive defination
 */
Filter.directive('filter', ["catch_error", "gettext", function(catch_error, gettext) {

    function link(scope, element, attrs){
        var config = scope.config;
        config.list.getList().then(function(data){
            scope.result = data;
        }, catch_error);
    }
    // Actual object of <filter> directive
    return {
        templateUrl: template("filter/index"),
        restrict: "E",
        transclude: true,
        scope: {
            result: "=",
            config: "="
        },
        link: link
    };
}]);
