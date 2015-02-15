Resource = angular.module "Resource", []

Resource.provider "Resource", [->
  @resource = undefined
  this.$get = [->
    return @resource
  ]
  return
]
