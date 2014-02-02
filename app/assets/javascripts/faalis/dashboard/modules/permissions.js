
<<<<<<< HEAD
=======


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
>>>>>>> 660a14d5a0f6d73a18cf15200f1fe0e55cd33521
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
