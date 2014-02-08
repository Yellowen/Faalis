var Boolean_ = angular.module("BooleanField", []);

/*
 * <string-field></string-field> directive defination
 */
Boolean_.directive('booleanField', ["$filter", "gettext", function($filter, gettext) {

    function link(scope, element, attrs, ngModel){
        var ltr = is_ltr();
        scope.element_id = "id_" + scope.field;
        scope.msg_element_id = "id_" + scope.field + "_msg";

        if (scope.on_change !== undefined) {
            // Watch event changes
            scope.$watch("model", function(newv, oldv, $scope) {
                // TODO: maybe we should pass locals to $eval
                scope.$parent.$eval(scope.on_change);
            }, true);
        }
    }
    // Actual object of <boolean-field> directive
    return {
        templateUrl: template("fields/boolean/boolean"),
        replace: true,
        restrict: "E",
        //require: "ngModel",
        scope: {
            cssClasses: '=cssClass',
            // string to shown as label for control
            label: "=",
            // fieldname
            field: "=fieldName",
            // Does this field is required
            required: "=",
            // A call back to pass to field ng-change directive
            on_change: "@onChange",
            // Actual Angularjs ng-model
            model: '='
        },
        link: link
    };
}]);
