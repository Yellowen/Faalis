class Faalis.HasManyField extends Faalis.BaseField
  type: 'has_many'
  relation: true

  # **Name**:   The name of current field.
  # **object**: Target resource object
  constructor: (name, resource) ->
    @name = name
    @resource = resource
    console.log(resource)

  __init__: ->
    console.log("<<<<<<<<<<<<<<<<")
    console.log(this)
    #console.log(@resource)
    return
    @resource = new @resource()

    unless @resource.__init__?
      throw "'" + @to + "' does not have '__init__' method."

    Faalis.$injector.invoke(@resource.__init__, @resource)


  # Fetch all the possible objects for current relation.
  # for example if @object was Post resource, then it will
  # fetch all the post from API
  fetch_all_objects: ->
    # --- This method should run after injection ---
    return @object.all()
