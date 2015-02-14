API = angular.module "API"

API.provider "APIFactory", ->
    @resource = undefined;
    @type = "json"
    @api_path = '/api/v1/'

    this.$get = ['$http', '$log', '$q', 'catch_error', ($http, $log, catch_error) ->

      class API
        constructor: (resource, type, api_prefix = '/api/v1/') ->
          @_resource = resource
          @_type = type
          @http = $http
          @log = $log
          @catch_error = catch_error
          @api_prefix = api_prefix

        # It's necessary to call this method, and pass an object
        # containing the require parameters of current resource.
        # For example we have `/posts/3/comments` as our RESTful
        # resource. Then we have to call `paretns` method in our
        # controller like this:
        #
        #   Resource.parents = { posts: 3 }
        #
        parents: (parents) ->
          @_resource.set_parents(parents)

        resource: ->
          @_resource

        # Execute a query with given parameters and return a promise
        # object.
        execute: (method, url, params = {}) ->

          new_url = @api_prefix + url + "." + @_type
          new_url = new_url.replace('//', "/")

          request =
            method: method
            url: new_url

          request.data = params if params != {} and method != 'GET'
          request.params = params if params != {} and method == 'GET'

          @http(request).success((data) ->
            return data
          ).error((data) ->
            @log.error(data)
            @catch_error(data)
          )

        all: ->
          url = @_resource.to_path()
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

      return new API(@resource, @type, @api_path)
    ]

    return
