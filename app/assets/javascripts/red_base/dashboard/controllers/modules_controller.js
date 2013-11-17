var Modules = angular.module("Modules", ["ngRoute"])
        .controller("ModulesController", ["$http", "$scope", function($http, $scope){

            var $injector = angular.injector();
            var that = this;

            $http({method: 'GET', responseType: 'json',
                   url: DashboardURL + '/modules.json'})
                .success(function(data, status, headers, config){
                    Modules = data.modules;
                    that.modules = Modules;
                    Modules.forEach(function(module){
                        var module_route_function = module.resource + "_route";
                        if (module_route_function in window) {
                            $injector.invoke("$routeProvider", window[module_route_function]);
                        }
                    });
                });

        }]);
