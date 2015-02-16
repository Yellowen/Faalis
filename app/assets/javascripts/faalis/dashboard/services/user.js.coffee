User = angular.module("User")
  .service "$user", ->
    can: (object, perm)->
      return true
