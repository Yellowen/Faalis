//= require ./functions
//= require_tree ./routers
//= require_tree ./models
//= require_tree ./controllers
//= require_tree ./routes
//= require_self
//= require ./locale/translations

var Dashboard = angular.module('Dashboard', ["gettext", "Modules"]);
