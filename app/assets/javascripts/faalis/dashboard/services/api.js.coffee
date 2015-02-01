API = angular.module "API"

API.provider "API", ->
  @resource = undefined;
  @api_path = '/api/v1/'

  this.$get = ["$http", "$q", ($http, $q) ->

    get = (resource, id) ->
      return

    all = (resource, id) ->
      $http.get('')
      return

    return {
      get: (resource, id) ->
        resource = _get_resource(resource, id)
        return get(resource.name, resource.id)

      all: (resource) ->
        return all(resource)
    }
  ]
