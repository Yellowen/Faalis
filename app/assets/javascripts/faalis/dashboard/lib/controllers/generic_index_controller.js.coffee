# General controller for a resource index. As you can see it extends the faalis base
# controller.
class Faalis.GenericIndexController extends Faalis.BaseController

  constructor: ($scope, _, API, Resource, $rootScope, $state, $stateParams, $user) ->
    super $scope

    @scope = $scope
    @_ = _
    @API = API
    @Resource = Resource
    @rootScope = $rootScope
    @state = $state
    @stateParams = $stateParams
    @user = $user

    @__init__()
    @__setup_buttons__()


    API.all()
      .then (data) ->
        $scope[Resource.plural_name()] = data.data


  __init__: ->
    @scope[@Resource.plural_name()] = [];
    # Set the current parent objects for API usage
    _parents = {}

    for parent in @Resource.parents
      _parents[parent] = @stateParams[parent + "_id"]

    @API.parents(_parents)

    # Container header informations
    @rootScope.section_name = _(@Resource.plural_name())
    @rootScope.section_slug = _("list")

    # List view template
    @scope.details_template = template_url(@Resource.detail_template())

  __buttons__: ->
    return [
      {
        title: _("New"),
        icon: "fa fa-plus",
        classes: "btn btn-success btn-sm",
        route: $state.href(Resource.plural_name().underscore() + '.new')
      }
    ]

  __setup_buttons__: ->
    $scope.buttons = []

    for button in @__buttons__()

    if $User.can 'create', Resource.name
      $scope.buttons.push()


  on_delete: (groups) ->

      query = []

      _.each groups, (group) ->
        query.push group.id


      API.all("groups").customDELETE(query.join(","))
        .then (data) ->
          $scope.groups = _.filter $scope.groups, (x) ->
            return !(query.indexOf(x.id) != -1)
          success_message(data.msg)

        .catch(catch_error);


Faalis.GenericIndexController.$inject = ["$scope", "gettext", "APIFactory", "Resource", "$rootScope", "$state", "$stateParams", "$user"]

angular.module('Faalis.Controllers', ["API", "Resource", "User"]).controller("Faalis.GenericIndexController", Faalis.GenericIndexController)
