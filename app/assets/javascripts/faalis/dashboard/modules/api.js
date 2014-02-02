var API = angular.module("API", []);

API.provider("API", function(){

    var _resource;
    this.resource = function(resource){
        _resource = resource;
    };

    this.$get = ["Restangular", function(Restangular){
        return new Restangular.all(_resource);
    }];
});
