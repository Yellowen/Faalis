
<<<<<<< HEAD
=======

>>>>>>> 660a14d5a0f6d73a18cf15200f1fe0e55cd33521

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
