// Integer control
// -----------------
// This module is responsible for `<integer-field></integer-field>` directive which will create
// an input for getting integer value from user. This directive can populate with data from
// a remote **API** .

// **IntegerField** module defination. To use this directive you should specify this module as
// dependency.

var Integer_ = angular.module("IntegerField", []);

// Directive defination
Integer_.directive('integerField', ["$filter", "gettext", function($filter, gettext) {

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
    // Actual object of <integer-field> directive
    return {
        templateUrl: template("fields/integer/integer"),
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
