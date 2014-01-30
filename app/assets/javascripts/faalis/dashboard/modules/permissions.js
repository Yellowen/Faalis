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

var Perm = angular.module("Permissions", []);

Perm.factory('UserPermissions', ["$rootScope", function ($rootScope) {
    var permissionList;
    return {
        set_permissions: function(permissions) {
            PERMISSIONS = permissions;
            $rootScope.$broadcast('permissions_changed');
        },

        /*
         * Check if user has specific permission on an object
         */
        can: function(action, model) {
            if (model in PERMISSIONS) {
                if (_.indexOf(PERMISSIONS[model], action) !== -1) {
                    //console.log("User can " + action + " " + model);
                    return true;
                }
            }
            //console.log("User can't " + action + " " + model);
            return false;

        },
        /*
         * Check if user has specific permission on an object
         */
        can_not: function(action, model) {
            return ! this.can(action,model);
        }

   };
}]);

Perm.directive('ifUser', ["UserPermissions", function(User) {

    function link(scope, element, attrs) {
        if (scope.value === true) {
            element.show();
        }
        else {
            element.hide();
        }
    }
  return {
      restrict: "A",
      scope: {
          value: "=ifUser"
      },
      link: link
  };
}]);
