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


Group.controller "NewGroupController", ["$state", "$rootScope", "$scope", "Resources", "$stateParams", "gettext",
($state, $rootScope, $scope, Resources, $stateParams, _) ->


  $scope.resource = Resources.main_resource()
  $scope.group = {}

  $rootScope.section_name = _("Groups")
  $rootScope.section_slug = _("Add")

  resource.initialize($stateParams)

  $scope.relations = resource.get_all_relations()
]
