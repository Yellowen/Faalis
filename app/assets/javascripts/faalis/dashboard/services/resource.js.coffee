Resource = angular.module "Resource"

Resource.provider "Resource", ->
  @resource = undefined
  return @resource
