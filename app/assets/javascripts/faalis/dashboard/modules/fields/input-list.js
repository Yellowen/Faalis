


var InputList = angular.module("InputList", []);

/*
 * <input-list></input-list> directive defination
 */
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
