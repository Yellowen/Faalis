
<<<<<<< HEAD
=======


var Integer_ = angular.module("IntegerField", []);

/*
 * <string-field></string-field> directive defination
 */
>>>>>>> 660a14d5a0f6d73a18cf15200f1fe0e55cd33521
Integer_.directive('integerField', ["$filter", "gettext", function($filter, gettext) {

    function link(scope, element, attrs){
        var ltr = is_ltr();
        scope.element_id = "id_" + scope.field;
        scope.msg_element_id = "id_" + scope.field + "_msg";
    }
    // Actual object of <string-field> directive
    return {
        templateUrl: template("fields/integer/integer"),
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
