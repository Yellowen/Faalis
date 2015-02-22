# Group module
Group = angular.module "Group", ["ListView", "Errors", "ui.router", "Auth", "Faalis.Controllers", "GroupResource"]

Group.config ["$stateProvider", "ResourcesProvider", "APIFactoryProvider", "GroupFactoryProvider",
($stateProvider, ResourcesProvider, APIFactoryProvider, GroupFactoryProvider) ->

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

  ResourcesProvider.resources = [new GroupFactoryProvider.resource()]
  APIFactoryProvider.resource = ResourcesProvider.resources[0]
]


Group.controller "NewGroupController", ["$state", "$rootScope", "$scope", "API", ($state, $rootScope, $scope, API) ->

]
