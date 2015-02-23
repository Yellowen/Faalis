# This class is one of the most important classes in **Faalis** client side application,
# and is responsible for representing a remote resource.
class Faalis.Resource

  # Arguments list:
  # * **options**:     Extra properties and attributes to add to the resource.
  #                    All the key/value in this object will attached to the
  #                    Resource object by transforming key to _<key>. For example
  #                    `{ name: "James" } would create an attribute called "_name"
  #                    to `Resource` object with value of "James".
  constructor: (options = {}) ->
    @parents ||= []
    @_parents_values_is_set = false

    # Put all the options key resource itself
    Object.keys(options, (key) ->
      this['_' + key] = options[key]
    )

    type = this._api_type || 'json'
    api_prefix = this._api_prefix || '/api/v1/'
    @API = new Faalis.APIFactory(this, type, api_prefix)

  # Set the specific parents of current resource. This method should be called
  # in controllers and before any use of `Resource` object. and the **parents**
  # argument should be a object of parent resource name as keys and their id
  # as value. For example: {'posts': 4 } for 'Comment' Resource.
  set_parents: (parents) ->
    tmp = []

    for parent in parents
      tmp.push(parent)
      tmp.push(parents[parent])

    @parents = tmp

    # This flag will specify the existance of parents
    @_parents_values_is_set = true

  # Initialize the resource object. for example fetch parent objects
  # or relations and such stuff
  initialize: ['$http', '$log', 'catch_error', ($http, $log, catch_error) ->
    deps = window.STATIC_REQUIREMENTS.concat(window.dashboard_dependencies)
    $injector = angular.injector(['ng', 'Errors', 'gettext'])

    $injector.invoke(@API.initialize)

    for field in @fields
      unless field.initialize?
        throw "'" + field + "' does not have 'initialize' method."

      console.log(field.initialize)
      # inject services for field classes.
      $injector.invoke(field.initialize)
  ]

  # Join the given urls and return a uri
  join_url: (url1, urls...) ->
    '/' + url1.split('/').filter(Boolean).concat(urls).join('/')

  # Parse the given uri and return an object containing the
  # details
  parse_path: (path) ->
    parents = []
    params = [];

    for part in path.split("/")
      if part.startsWith(':')
        params.push(part.split(":").last)
      else
        parents.push(part.singularize()) unless part.isBlank()

    resource = parents.pop()

    return {
      parents: parents,
      params: params,
      resource: resource
    }

  # Return the url of current `Resource`
  to_path: (params...) ->
    if @_parents_values_is_set == false
      throw 'You need to set parents values to continue.'

    _parents = @parents[0..]

    for item in params
      _parents.push(item)

    return '/' + _parents.filter(Boolean).join('/') + @plural_name()

  plural_name: ->
    @name.pluralize()

  # Return the path of template that should be used as the
  # details template in the final view.
  detail_template: ->
    # `@_details_template` can be assigned via `ResourceFactory` contructor of
    # by assigning a value to it after initialization of object.
    if @_detail_template?
      return @_detail_template

    else
      return @plural_name() + "/details"


  # API Interface ----------------------------------------------------------
  # We can use these methods to interact with resource API interface
  # but the most important thing is to **initialize** the resource
  # before using these. **ResourceFactory** service will do it
  # before handing service to the controller or host code.

  # Get a resource instance with given ID
  find: (id) ->
    @API.get(id)

  # Get all the resources via API.
  all: ->
    @API.all()

  # Create a new resource using given **data**
  create: (data) ->
    @API.create(data)

  # Update the resource with given ID using **data** which is provided
  update: (id, data) ->
    @API.update(id, data)

  # Destroy the resource with given id
  destroy: (id) ->
    @API.destroy(id)
