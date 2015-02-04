
class @Resource
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

  constructor: (name, parents = []) ->

    @parents = {}
    console.log(parents)
    for parent in parents
      @parents[parent] = 0

    @name = name

  to_path: ->
    console.log("HERE")
    console.log(@parents)
    for parent in @parents

      console.log(parent)
    return @path
