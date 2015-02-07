
["$scope", "gettext", "API", "catch_error", "$rootScope", "$state", ($scope, _, API, catch_error, $rootScope, $state) ->

class GenericIndexController
  constructor: ($scope, _, API, catch_error, $rootScope, $state) ->

    resource = API.resource
    # Container header informations
    $rootScope.section_name = _(resource.plural_name)
    $rootScope.section_slug = _("list")

    # List view template
    $scope.details_template = template_url("auth/groups/details")

    $scope.buttons = [{
      title: _("New"),
      icon: "fa fa-plus",
      classes: "btn btn-success btn-sm",
      route: $state.href(resource.plural_name.underscore() + '.new')
    }]

    API.all("groups").getList()
      .then (data) ->
        $scope.groups = data
      .catch(catch_error);


  $scope.on_delete = (groups) ->

    query = []

    _.each groups, (group) ->
      query.push group.id


    API.all("groups").customDELETE(query.join(","))
      .then (data) ->
        $scope.groups = _.filter $scope.groups, (x) ->
          return !(query.indexOf(x.id) != -1)
        success_message(data.msg)

      .catch(catch_error);



]
