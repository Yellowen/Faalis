# General controller for a resource index. As you can see it extends the faalis base
# controller.
class Faalis.GenericIndexController extends Faalis.BaseController

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
    #@__set_attribute__('Resource', Resource)
    @Resource = Resource
    console.log("222222222222")
    console.log(Resource.plural_name())
    @rootScope = $rootScope
    @state = $state
    @stateParams = $stateParams
    @user = $user

    @__init__()
    @__setup_buttons__()
    @__fetch_resources__()

  # ## Internal methods

  # This method is used for initializing process at the begining of the controller
  # Users can override this method base on their needs
  __init__: ->
    # Set the list of objects at the angular scope.
    # For example if our **Resource** name was 'group'
    # it will create `$scope.groups`.
    @scope[@Resource.plural_name()] = [];

    # Set the current parent objects for API usage
    _parents = {}

    for parent in @Resource.parents
      _parents[parent] = @stateParams[parent + "_id"]

    @API.parents(_parents)

    # Container header informations
    @rootScope.section_name = @_(@Resource.plural_name().capitalize())
    @rootScope.section_slug = @_("list")

    # List view template
    @scope.details_template = template_url(@Resource.detail_template())

  # List of buttons to use in index view. If you need more
  # buttons in you own controller, just override this method.
  # **Note**: Checkout **Faalis.Button** class for more details.
  __buttons__: ->
    return [
      new Faalis.Button({
        title: @_("New " + @Resource.name.capitalize()),
        icon: "fa fa-plus",
        classes: "btn btn-success btn-sm",
        #route: @state.href(@Resource.plural_name().underscore() + '.new')
        permission: 'create'
      })
    ]

  # Setup up buttons based on user permissions.
  __setup_buttons__: ->

    @scope.buttons = []

    for button in @__buttons__()
      if @user.can button.permission, @Resource.name
        @scope.buttons.push(button)

  # Fetch remote resource using API interface
  __fetch_resources__: ->
    Resource = @Resource
    scope = @scope

    @API.all()
      .then (data) ->
        scope[Resource.plural_name()] = data.data

  on_delete: (resources) ->



Faalis.GenericIndexController.$inject = ["$scope", "gettext", "APIFactory", "Resource", "$rootScope", "$state", "$stateParams", "$user"]

angular.module('Faalis.Controllers', ["API", "Resource", "User"]).controller("Faalis.GenericIndexController", Faalis.GenericIndexController)
