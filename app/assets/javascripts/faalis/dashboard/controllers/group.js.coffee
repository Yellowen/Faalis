# Group module
Group = angular.module "Group", ["ListView", "Errors", "ui.router", "Auth", "Faalis.Controllers"]

Group.config ["$stateProvider", "ResourceProvider", "APIFactoryProvider",
($stateProvider, ResourceProvider, APIFactoryProvider) ->

  $stateProvider.
        state("groups",{
          url: "/auth/groups",
          templateUrl: template_url("auth/groups/index"),
          controller: "Faalis.GenericIndexController"
        }).
        state("groups.new",{
          url: "/new",
          templateUrl: template_url("faalis/views/generic_add_view"),
          controller: "Faalis.GenericAddController"
        }).
        state("groups.edit",{
          url: "/:id/edit",
          templateUrl: template_url("auth/groups/new"),
          controller: "AddGroupController"
        })

  ResourceProvider.resource = new Faalis.GroupFactory()
  APIFactoryProvider.resource = ResourceProvider.resource
]
