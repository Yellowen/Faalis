Resource = angular.module "Resources", []

Resource.provider "Resources", [->

  # resources should be an object like this:
  # { <resource_name>: <actual_resource_object> }
  @resources = undefined

  @main_resource = undefined
  this.$get = [->
    @main_resource ||= @resources.keys()[0]

    @resource.main_resource = ->
      return @resource[@main_resource]

    return @resources
  ]
  return
]
