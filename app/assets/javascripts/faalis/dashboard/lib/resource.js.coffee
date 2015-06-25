# This class is one of the most important classes in **Faalis** client side application,
# and is responsible for representing a remote resource.
class Faalis.Resource

  # This array hold all the fields which represent a relationship
  # for current resource.
  #
  # for example `belongs_to` or `has_many` relationship
  __relations__: []

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

    @__init__.$inject = ['$http', '$log', 'catch_error']

  # Set the specific parents of current resource. This method should be called
  # in controllers and before any use of `Resource` object. and the **parents**
  # argument should be a object of parent resource name as keys and their id
  # as value. For example: {'posts': 4 } for 'Comment' Resource.
  __set_parents__: (parents) ->
    tmp = []

    for parent in parents
      tmp.push(parent)
      tmp.push(parents[parent])

    @parents = tmp

    # This flag will specify the existance of parents
    @_parents_values_is_set = true

  # Init the resource object to be used in **run** stage. this
  # method will call by **ResourceFactory** service.
  __init__: ($http, $log, catch_error) ->

    deps = window.STATIC_REQUIREMENTS.concat(window.dashboard_dependencies)

    Faalis.$injector.invoke(@API.__init__, @API)

    for attr in @__attributes__
      unless attr.__init__?
        throw "'" + attr + "' does not have '__init__' method."

      if attr.relation
        @__relations__.push(attr)

      # inject services for field classes.
      Faalis.$injector.invoke(attr.__init__, attr)


  # Initialize the resource object. for example fetch parent objects
  # or relations and such stuff.
  initialize: (params) ->
    _parents = {}

    for parent in @parents
      _parents[parent] = params[parent + "_id"]

    # Set the current parent objects for API usage
    @__set_parents__(_parents)

  # Join the given urls and return a uri
  __join_url__: (url1, urls...) ->
    '/' + url1.split('/').filter(Boolean).concat(urls).join('/')

  # Parse the given uri and return an object containing the
  # details
  __parse_path__: (path) ->
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
    _parents = @parents[0..]
    return '/' + _parents.filter(Boolean).join('/') + @plural_name()

    if @_parents_values_is_set == false
      throw 'You need to set parents values to continue.'

    if @parents.length > 0
      _parents = @parents[0..]

      if params.length > 1
        for item in params
          console.log(item)
          _parents.push(item)

        console.log(_parents)
        return '/' + _parents.filter(Boolean).join('/') + @plural_name()

  plural_name: ->
    @__name__.pluralize()

  # Return the path of template that should be used as the
  # details template in the final view.
  __detail_template__: ->
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
    return @API.get(id)

  # Get all the resources via API.
  all: ->
    return @API.all()

  # Create a new resource using given **data**
  create: (data) ->
    return @API.create(data)

  # Update the resource with given ID using **data** which is provided
  update: (id, data) ->
    return @API.update(id, data)

  # Destroy the resource with given id
  destroy: (id) ->
    return @API.destroy(id)

  # Get All possible objects for current resource relations
  get_all_relations: ->
    # --- This method should run after injection ---
    result_obj = {}

    for relation in @__relations__
      # relation would be a Field (or its children) Instance and
      # relation.resource would be a Resource instance.
      relation.fetch_all_objects().then( (result) ->
        # Put the result promise in the result object
        result_obj[relation.name] = result
      )

    return result_obj
