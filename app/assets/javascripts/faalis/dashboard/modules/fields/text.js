


var Text_ = angular.module("TextField", []);

/*
 * <string-field></string-field> directive defination
 */
Text_.directive('textField', ["$filter", "gettext", function($filter, gettext) {

    function link(scope, element, attrs){
        var ltr = is_ltr();
        scope.element_id = "id_" + scope.field;
        scope.msg_element_id = "id_" + scope.field + "_msg";
    }
    // Actual object of <string-field> directive
    return {
        templateUrl: template("fields/text/text"),
        replace: true,
        restrict: "E",
        transclude: true,
        scope: {
            cssClasses: '=cssClass',

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
