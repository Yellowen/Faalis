# Group module
Group = angular.module "Group", ["ListView", "Errors", "ui.router",
  "Auth", "Faalis.Controllers"]

Group.config ["$stateProvider", "ResourcesProvider",
($stateProvider, ResourcesProvider) ->

  $stateProvider.
        state("groups",{
          url: "/auth/groups",
          templateUrl: template_url("auth/groups/index"),
          controller: "Faalis.GenericIndexController"
        }).
        state("groups.new",{
          url: "/new",
          templateUrl: template_url("auth/groups/new"),
          controller: "NewGroupController"
        }).
        state("groups.edit",{
          url: "/:id/edit",
          templateUrl: template_url("auth/groups/new"),
          controller: "AddGroupController"
        })

  group = new Faalis.GroupResource()
  ResourcesProvider.resources = [group]
]


Group.controller "NewGroupController", ["$state", "$rootScope", "$scope", "Restangular", "$stateParams", "gettext", "catch_error",
($state, $rootScope, $scope, Resources, $stateParams, _, catch_error) ->


  $scope.group = {}

  $rootScope.section_name = _("Groups")
  $rootScope.section_slug = _("Add")

  Resources.all('permissions').getList().then (data)->
    console.log(data);
    $scope.permissions = data[0].permissions
  , (data)->
    catch_error(data)

]
