class @ResourceFactory

  constructor: (name, parents = [], options = {}) ->
    @parents = []
    @name = name
    @_parents_values_is_set = false

    # Put all the options key resource itself
    Object.keys(options, (key) ->
      this['_' + key] = options[key]
    )

  set_parents: (parents) ->
    tmp = []

    for parent in parents
      tmp.push(parent)
      tmp.push(parents[parent])

    @parents = tmp
    @_parents_values_is_set = true

  join_url: (url1, urls...) ->
    '/' + url1.split('/').filter(Boolean).concat(urls).join('/')

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


  to_path: (params...) ->
    if @_parents_values_is_set == false
      throw 'You need to set parents values to continue.'

    _parents = @parents[0..]

    for item in params
      _parents.push(item)

    return '/' + _parents.filter(Boolean).join('/') + @plural_name()

  plural_name: ->
    @name.pluralize()

  detail_template: ->
    if @_detail_template?
      return @_detail_template
    else
      return @plural_name() + "/details"
