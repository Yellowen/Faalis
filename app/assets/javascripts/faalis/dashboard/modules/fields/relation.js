/* -----------------------------------------------------------------------------
    Red Base - Basic website skel engine
    Copyright (C) 2012-2014 Yellowen

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

var ListView = angular.module("RelationField", ["ui.select2"]);

/*
 * <relation-field></relation-field> directive defination
 */
ListView.directive('relationField', ["$filter", "gettext", "Restangular", "catch_error", function($filter, gettext, API, catch_error) {

    function link(scope, element, attrs){
        var ltr = is_ltr();
        scope.element_id = "id_" + scope.field.name;
        scope.msg_element_id = "id_" + scope.field.name + "_msg";

        if( scope.field.type != "in" ){
            scope.have = function(obj_id) {
                var tmp = _.where(scope.model, { id: obj_id });
                if (tmp.length > 0) {
                    return true;
                }
                else {
                    return false;
                }
            };

            scope.update_collection = function(){
                API.all(scope.field.to).getList().then(function(data){
                    scope.all_options = data;
                }, function(data){
                    catch_error(data);
                });
            };

            scope.update_collection();
        }
    }
    // Actual object of <relation-field> directive
    return {
        templateUrl: template("fields/relation/relation"),
        replace: true,
        restrict: "E",
        transclude: true,
        scope: {
            // select2 options
            select2Options: '=',

            // Does this field is required
            required: "=",

            // Field to use as title of options
            titleField: '=',

            // relation field data
            field: '=fieldData',

            // Actual Angularjs ng-model
            model: '='
        },
        link: link
    };
}]);
