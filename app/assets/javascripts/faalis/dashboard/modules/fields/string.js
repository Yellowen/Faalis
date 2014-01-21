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

var String_ = angular.module("StringField", []);

/*
 * <string-field></string-field> directive defination
 */
String_.directive('stringField', ["$filter", "gettext", function($filter, gettext) {

    function link(scope, element, attrs){
        var ltr = is_ltr();
        scope.element_id = "id_" + scope.field;
        scope.msg_element_id = "id_" + scope.field + "_msg";
    }
    // Actual object of <string-field> directive
    return {
        templateUrl: template("fields/string/string"),
        replace: true,
        restrict: "E",
        scope: {
            cssClasses: '=cssClass',

            // fieldname
            field: "=fieldName",
            // Does this field is required
            required: "=",
            // Actual Angularjs ng-model
            model: '='
        },
        link: link
    };
}]);
