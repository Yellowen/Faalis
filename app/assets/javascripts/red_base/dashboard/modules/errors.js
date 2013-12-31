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
var Errors = angular.module("Errors", []);

Errors.factory('catch_error', ["gettext", function(gettext) {
    return function(error) {
        console.dir(error);
        console.dir(typeof(error.data));
        if ("data" in error) {
            if ((typeof(error.data) == "object") && ("fields" in error.data)) {
                _.each(error.data.fields, function(value, key) {
                    $("#id_" + key).addClass("input-error");
                    _.each(value, function(x){
                        $("#id_" + key + "_msg").append(value);
                        $("#id_" + key + "_msg").addClass("error");

                    });
                });
                error_message(gettext("Validation error. Fixup errors first."));
                return;
            }
            if (error.data.error) {
                console.log(error.data.error);
                error_message(error.data.error);
                return;
            }
            return;
        }

        error_message(gettext("Unkown error: please try again or contact to administrator."));

    };
}]);
