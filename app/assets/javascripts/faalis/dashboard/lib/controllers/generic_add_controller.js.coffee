# General controller for a resource creation. As you can see it extends the faalis base
# controller.
class Faalis.GenericAddController extends Faalis.BaseController

  constructor: ($scope, _, API, Resource, $rootScope, $state, $stateParams, $user) ->
    # Call constructor of **Faalis.BaseController** which maps all
    # the methods (prototype methods) of current object to $scope except of those that
    # their name starts with a '_' ( underscore ). Those methods are reserved for internal
    # usage.
    super $scope

    # Isn't it obvious ?
    # Ok for those who are a little slow. I just mapped angular services
    # accessible in this method scope to class level scope.
    @scope = $scope
    @_ = _
    @API = API
    @Resource = Resource
    @rootScope = $rootScope
    @state = $state
    @stateParams = $stateParams
    @user = $user

    @__init__()

  # ## Internal methods
  __init__: ->
    @Resource.initialize
