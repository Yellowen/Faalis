


var String_ = angular.module("StringField", []);

/*
 * <string-field></string-field> directive defination
 */
String_.directive('stringField', ["$filter", "gettext", function($filter, gettext) {

    function link(scope, element, attrs){
        var ltr = is_ltr();
        scope.element_id = "id_" + scope.field;
        scope.msg_element_id = "id_" + scope.field + "_msg";
    }
    // Actual object of <string-field> directive
    return {
        templateUrl: template("fields/string/string"),
        replace: true,
        restrict: "E",
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
