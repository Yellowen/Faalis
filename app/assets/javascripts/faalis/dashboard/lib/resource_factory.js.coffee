class @ResourceFactory

  constructor: (name, parents = []) ->

    @parents = []
    @name = name

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
    if params.length - 1 != @parents.length
      throw "You should specify enough parent values based on resource parents."

    _parents = []

    if @parent.length > 0
      i = 0

      for parent in @parents
        _parents.push(parent.underscore())
        _parents.psuh(params[i].toString())
        i++
    _parents.push(params[-1])
    '/' + _parents.filter(Boolean).join('/')

  plural_name: ->
    @name.pluralize()
