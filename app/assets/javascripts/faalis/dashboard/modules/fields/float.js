// Float control
// -----------------
// This module is responsible for `<float-field></float-field>` directive which will create
// an input for getting float value from user. This directive can populate with data from
// a remote **API** .

// **FloatField** module defination. To use this directive you should specify this module as
// dependency.

var Float_ = angular.module("FloatField", []);

// Directive defination
Float_.directive('floatField', ["$filter", "gettext", function($filter, gettext) {

    // Link function
    function link(scope, element, attrs){
        var ltr = is_ltr();
        scope.element_id = "id_" + scope.field;
        scope.msg_element_id = "id_" + scope.field + "_msg";

        // on change related watch section.
        if (scope.on_change !== undefined) {
            // Watch event changes
            scope.$watch("model", function(newv, oldv, $scope) {
                // TODO: maybe we should pass locals to $eval
                scope.$parent.$eval(scope.on_change);
            }, true);
        }

    }
    // Actual object of <float-field> directive
    return {
        templateUrl: template("fields/float/float"),
        replace: true,
        restrict: "E",
        transclude: true,
        scope: {
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
