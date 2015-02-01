class Resource
  parse_path: (path) ->
    parents = []
    params = [];

    for part in path.split("/")
      if part.startsWith(':')
        params.push(part.split(":").last)
      else
        parents.push(part.singularize())

    resource = parents.pop()

    return {
      parents: parents,
      params: params,
      resource: resource
    }

  constructor: (path) ->
    @path = path
    details = parse_path(path)
    @parents = details.parents
    @resource_name = details.resoure

  to_path: ->
    return
