var Modules = angular.module("Modules", ["ngRoute"])
        .config(["$routeProvider", function($routeProvider){

            // Get all the modules syncly
            $.ajax({method: 'GET', type: 'json', async: false,
                    url: DashboardURL + '/modules.json'})
                .success(function(data, status, headers, config){

                    DModules = data.modules;

                    DModules.forEach(function(module){
                        var module_route_function = module.resource + "_routes";
                        if (module_route_function in window) {
                            var url_list = window[module_route_function]($routeProvider);
                        }
                    });

                });

        }])
        .controller("ModulesController", ["$http", "$scope", function($http, $scope){

            this.modules = DModules;

        }]);
