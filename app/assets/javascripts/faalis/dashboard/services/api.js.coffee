API = angular.module "API"

API.provider "API", ->
  this.resource = undefined;
  this.api_path = '/api/v1/'

  this.$get = ["$http", "$q", ($http, $q) ->

    get = (resource, id) ->
      return

    all = (resource, id) ->
      return

    return {
      get: (id) ->
    }
  ]
