var Date_ = angular.module("DateField",[]);

Date_.directive('dateField', ["$filter", "gettext", function($filter, gettext){
    function link(scope, element, attrs){
        if(scope.model === undefined){
            scope.model = new Date();
        }
    }

    // Actual object of <string-field> directive
    return {
        templateUrl: template("fields/datetime/date"),
        replace: true,
        restrict: "E",
        transclude: true,
        scope: {
            cssClasses: '=cssClass',
            // A call back to pass to field ng-change directive
            on_change: "@onChange",
            // fieldname
            field: "=fieldName",
            // Actual Angularjs ng-model
            model: '='
        },
        link: link
    };

}]);
