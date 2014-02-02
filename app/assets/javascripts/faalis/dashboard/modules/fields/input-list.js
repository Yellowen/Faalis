
<<<<<<< HEAD
=======


var InputList = angular.module("InputList", []);

/*
 * <input-list></input-list> directive defination
 */
>>>>>>> 660a14d5a0f6d73a18cf15200f1fe0e55cd33521
InputList.directive('inputList', ["$filter", "gettext", function($filter, gettext) {

    function link(scope, element, attrs){
        var ltr = is_ltr();
        scope.element_id = "id_" + scope.field;
        scope.msg_element_id = "id_" + scope.field + "_msg";
    }
    // Actual object of <boolean-field> directive
    return {
        templateUrl: template("fields/input-list/input-list"),
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
