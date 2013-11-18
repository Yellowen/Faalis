//= require ./functions
//= require_tree ./routers
//= require_tree ./models
//= require_tree ./controllers
//= require_tree ./routes
//= require_self
//= require ./locale/translations

var dependencies = ["gettext", "Modules", "ngRoute"].concat(dashboard_dependencies);
console.log(dependencies);

var Dashboard = angular.module('Dashboard', dependencies);

Dashboard.config(['$routeProvider', function($routeProvider) {


}]);
