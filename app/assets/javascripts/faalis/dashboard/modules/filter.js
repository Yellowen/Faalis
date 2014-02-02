
<<<<<<< HEAD
=======


var Filter = angular.module("Filter", ["Errors"]);

/*
 * <filter></filter> directive defination
 */
>>>>>>> 660a14d5a0f6d73a18cf15200f1fe0e55cd33521
Filter.directive('filter', ["catch_error", "gettext", function(catch_error, gettext) {

    function link(scope, element, attrs){
        var config = scope.config;
        config.list.getList().then(function(data){
            scope.result = data;
        }, catch_error);
    }
    // Actual object of <filter> directive
    return {
        templateUrl: template("filter/index"),
        restrict: "E",
        transclude: true,
        scope: {
            result: "=",
            config: "="
        },
        link: link
    };
}]);
