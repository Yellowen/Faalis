var Datetime_ = angular.module("DatetimeField", ['ngQuickDate']);

/*
 * <string-field></string-field> directive defination
 */

Datetime_.directive('datetimeField', ["$filter", "gettext", function($filter, gettext) {

    function link(scope, element, attrs){
        var ltr = is_ltr();
        scope.element_id = "id_" + scope.field;
        scope.msg_element_id = "id_" + scope.field + "_msg";

        if ((scope.timepicker === undefined) || (scope.timepicker == null)) {
            scope.timepicker = true;
        }
        console.log(scope);
        console.log(scope.timepicker);
        if (scope.on_change !== undefined) {
            // Watch event changes
            scope.$watch("model", function(newv, oldv, $scope) {
                // TODO: maybe we should pass locals to $eval
                scope.$parent.$eval(scope.on_change);
            }, true);
        }

    }
    // Actual object of <datetime-field> directive
    return {
        templateUrl: template("fields/datetime/datetime"),
        replace: true,
        restrict: "E",
        transclude: true,
        scope: {
            // disable timepicker
            timepicker: "=?",

            cssClasses: '=cssClass',
            // A call back to pass to field ng-change directive
            on_change: "@onChange",
            // fieldname
            field: "=fieldName",
            // Does this field is required
            required: "=",
            // Actual Angularjs ng-model
            model: '='
        },
        link: link
    };
}]);
