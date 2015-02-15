User = angular.module("User")
  .service "$User", ->
    @can: (object, perm)->
      return true
