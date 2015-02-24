Resource = angular.module "Faalis.ResourceFactory", []

Resource.provider "Resources", [->

  # resources should be an array of resource factories
  @resources = undefined

  # This field will specify the main resource class
  # for current functionality. First element of
  # @resource will be used if `main_resource` was undefined
  @main_resource = undefined


  this.$get = [->

    main_resource = @main_resources || @resources[0]
    resources = @resources

    # Public injector to inject required services into
    # resources `initialize` method.

    #deps = window.STATIC_REQUIREMENTS.concat(window.dashboard_dependencies)
    #$injector = angular.injector(deps)
    $injector = angular.injector(['ng', 'Errors', 'gettext'])

    obj = {}

    for resource in resources
      unless resource.name?
        throw "Resource '" + resource + "' does not have a 'name'"

      unless resource.__init__?
        throw "Resource '" + resource.name + "' does not have '__init__' method."

      $injector.invoke(resource.__init__, resource)

      obj[resource.name.underscore()] = resource

    obj.main_resource = ->
      return main_resource

    obj.all = ->
      return resources

    return obj
  ]
  return
]
