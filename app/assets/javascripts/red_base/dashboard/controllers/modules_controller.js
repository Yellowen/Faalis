var Modules = angular.module("Modules", [])
        .controller("ModulesController", ["$http", "$scope", function($http, $scope){
            var that = this;
            $http({method: 'GET', responseType: 'json',
                   url: DashboardURL + '/modules.json'})
                .success(function(data, status, headers, config){
                    Modules = data.modules;
                    that.modules = Modules;
                    Modules.forEach(function(module){

                    });
                });

        }]);
