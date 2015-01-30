Perm = angular.module "Permissions", []

Perm.factory 'UserPermissions', ["$rootScope", ($rootScope) ->
  return {
    set_permissions: (permissions) ->
      PERMISSIONS = permissions
      $rootScope.$broadcast 'permissions_changed'

    # Check if user has specific permission on an object
    can: (action, model) ->
      console.log(PERMISSIONS)
      console.log("Action: " + action + " Model: " + model)
      if PERMISSIONS[model] != undefined
        if _.indexOf(PERMISSIONS[model], action) != -1
          console.log("User can " + action + " " + model)
          return true

      console.log("User can't " + action + " " + model);
      return false

    # Check if user has specific permission on an object
    can_not: (action, model) ->
      return ! this.can(action,model)
  }
]

Perm.directive 'ifUser', ["UserPermissions", (User) ->

  link = (scope, element, attrs) ->
    if scope.value == true
      element.show()

    else
      element.hide()


  return {
    restrict: "A",
    scope:
      value: "=ifUser"
    link: link
  }
]
