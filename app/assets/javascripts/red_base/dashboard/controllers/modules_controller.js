var Modules = angular.module("Modules", ["ngRoute"])
        .config(["$routeProvider", function($routeProvider){


        }])
        .controller("ModulesController", ["$http", "$scope", function($http, $scope){

            this.modules = DModules;

        }]);
