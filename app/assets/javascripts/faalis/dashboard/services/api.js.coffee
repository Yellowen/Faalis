API = angular.module "API"

API.provider "APIFactory", ['$http', '$log', '$q', 'catch_error',
  ($http, $log, $q, catch_error) ->
    @resource = undefined;
    resource = @resource
    type = "json"
    @api_path = '/api/v1/'

    class API
      constructor:  ->
        @_resource = resource
        @_type = type

      execute: (method, url, params = {}) ->
        request =
          method: method
          url: url + "." + @_type

        request.data = params if params != {} and method != 'GET'
        request.params = params if params != {} and method == 'GET'

        $http(request)
          .success (data) ->
            return data
          .error (data) ->
            $log.error(data)
            catch_error(data)

      all: (ids...) ->
        url = @resource.to_path(ids...)
        @execute('GET', url)

      get: (ids...) ->
        url = @resource.to_path(ids...)
        @execute('GET', url)

      create: (data, ids...) ->
        url = @resource.to_path(ids...)
        @execute('POST', @path, data)

      update: (data) ->
        @execute('PUT', @path, data)

      destroy: (id) ->
        url = @join_path(@path, id)
        @execute('DELETE', url)

    return Resource

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
