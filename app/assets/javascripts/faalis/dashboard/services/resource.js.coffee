Resource = angular.module "Resources", []

Resource.provider "Resources", [->

  # resources should be an array of resource factories
  @resources = undefined

  @main_resource = undefined

  this.$get = [->
    main_resource = @main_resources || @resources[0]
    resources = @resources

    obj = { _resources: @resources }

    obj.main_resource = ->
      return main_resource

    obj.all = ->
      return resources

    return obj
  ]
  return
]
