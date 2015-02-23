class Faalis.APIFactory
  constructor: (resource, type = 'json', api_prefix = '/api/v1/') ->
    @_resource = resource
    @api_prefix = api_prefix
    @_type = type


  initialize: ['$http', '$log', '$q', 'catch_error', ($http, $log, catch_error) ->
    @http = $http
    @log = $log
    @catch_error = catch_error
  ]

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

  # Raw queries -----------------------
  get: (url, params) ->
    @execute('GET', url, params)

  post: (url, data) ->
    @execute('POST', url, data)

  put: (url, params) ->
    @execute('PUT', url, params)

  patch: (url, params) ->
    @execute('PATCH', url, params)

  delete: (url, params) ->
    @execute('DELETE', url, params)

  # Semantic queries -----------------
  all: ->
    url = @_resource.to_path()
    @execute('GET', url)

  find: (id) ->
    url = @resource.to_path(id)
    @execute('GET', url)

  create: (data) ->
    url = @resource.to_path
    @execute('POST', url, data)

  update: (id, data) ->
    url = @resource.to_path(id)
    @execute('PUT', url, data)

  destroy: (id) ->
    url = @resource.to_path(id)
    @execute('DELETE', url)
