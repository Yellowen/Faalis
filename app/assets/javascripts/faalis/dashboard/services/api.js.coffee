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

      # It's necessary to call this method, and pass an object
      # containing the require parameters of current resource.
      # For example we have `/posts/3/comments` as our RESTful
      # resource. Then we have to call `paretns` method in our
      # controller like this:
      #
      #   Resource.parents = { posts: 3 }
      #
      parents: (parents) ->
        @_resource.set_parents = parents

      resource: ->
        @_resource

      # Execute a query with given parameters and return a promise
      # object.
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

      all: ->
        url = @resource.to_path
        @execute('GET', url)

      get: (id) ->
        url = @resource.to_path(id)
        @execute('GET', url)

      create: (data) ->
        url = @resource.to_path
        @execute('POST', url, data)

      update: (data) ->
        url = @resource.to_path
        @execute('PUT', url, data)

      destroy: (id) ->
        url = @resource.to_path(id)
        @execute('DELETE', url)

    return Resource

]
