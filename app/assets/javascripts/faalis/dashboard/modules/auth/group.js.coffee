# Group module
Group = angular.module "Group", ["ListView", "Errors", "ui.router"]

Group.config ["$stateProvider", ($stateProvider) ->

  $stateProvider.
        state("auth.groups",{
          url: "/groups",
          templateUrl: template_url("auth/groups/index"),
          controller: "GroupsController"
        }).
        state("auth.groups.new",{
          url: "/new",
          templateUrl: template_url("auth/groups/new"),
          controller: "AddGroupController"
        }).
        state("auth.groups.edit",{
          url: "/:id/edit",
          templateUrl: template_url("auth/groups/new"),
          controller: "AddGroupController"
        })
]

Group.controller "GroupsController", ["$scope", "gettext", "Restangular", "catch_error", "$rootScope", ($scope, _, API, catch_error, $rootScope) ->

  $rootScope.section_name = _("Groups")
  $rootScope.section_slug = _("list")

  $scope.details_template = template_url("auth/groups/details")

  $scope.buttons = [{
    title: _("New"),
    icon: "fa fa-plus",
    classes: "btn btn-success btn-sm",
    route: "#/auth/groups/new"

  }]

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



    API.all("groups").getList()
        .then (data) ->
            $scope.groups = data
        .catch(catch_error);

]

Group.controller "AddGroupController", ["Restangular", "$scope", "$location", "$routeParams", "gettext", "catch_error", (API, $scope, $location, $routeParams, gettext, catch_error) ->

    $scope.selected_perms = []
    $scope.permissions = []
    $scope.editing = false

]
