
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
