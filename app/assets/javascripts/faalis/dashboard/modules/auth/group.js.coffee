# Group module
Group = angular.module "Group", ["ListView", "Errors", "ui.router", "Auth"]

Group.config ["$stateProvider", ($stateProvider) ->

  $stateProvider.
        state("groups",{
          url: "/auth/groups",
          templateUrl: template_url("auth/groups/index"),
          controller: "GroupsController"
        }).
        state("groups.new",{
          url: "/new",
          templateUrl: template_url("auth/groups/new"),
          controller: "AddGroupController"
        }).
        state("groups.edit",{
          url: "/:id/edit",
          templateUrl: template_url("auth/groups/new"),
          controller: "AddGroupController"
        })
]

Group.controller "GroupsController", ["$scope", "gettext", "Restangular", "catch_error", "$rootScope", "$state", ($scope, _, API, catch_error, $rootScope, $state) ->

  # Container header informations
  $rootScope.section_name = _("Groups")
  $rootScope.section_slug = _("list")

  # List view template
  $scope.details_template = template_url("auth/groups/details")

  $scope.buttons = [{
    title: _("New"),
    icon: "fa fa-plus",
    classes: "btn btn-success btn-sm",
    route: $state.href('groups.new')

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

Group.controller "AddGroupController", ["Restangular", "$scope", "$state", "$stateParams", "gettext", "catch_error", "$rootScope", (API, $scope, $state, $stateParams, _, catch_error, $rootScope) ->

  $rootScope.section_slug = _("Add new one")

  $scope.selected_perms = []
  $scope.permissions = []
  $scope.editing = false

  $scope.cancel = ->
    $(".form input").val()
    $state.go("groups");

]
