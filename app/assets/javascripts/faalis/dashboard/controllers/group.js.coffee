# Group module
Group = angular.module "Group", ["ListView", "Errors", "ui.router",
  "Auth", "Faalis.Controllers", "Faalis.ResourceFactory"]

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

  ResourcesProvider.resources = [new Faalis.GroupResource()]
]


Group.controller "NewGroupController", ["$state", "$rootScope", "$scope", "API", ($state, $rootScope, $scope, API) ->

]
