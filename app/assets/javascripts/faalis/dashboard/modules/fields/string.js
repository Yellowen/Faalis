var String_ = angular.module("StringField", []);

/*
 * <string-field></string-field> directive defination
 */
String_.directive('stringField', ["$filter", "gettext", function($filter, gettext) {

    function link(scope, element, attrs){
        var ltr = is_ltr();
        scope.element_id = "id_" + scope.field;
        scope.msg_element_id = "id_" + scope.field + "_msg";
        scope.show_help_btn = false;
        scope.show_help_text = true;
        // Decide to see help text or help button
        if (scope.options === undefined) {
            scope.options = {};
        }

        if ("help_text" in scope.options) {
            if ("show_help_btn" in scope.options && scope.options.show_help_btn === true) {
                scope.show_help_btn = true;
                scope.show_help_text = false;
            }
        }

        if (scope.on_change !== undefined) {
            // Watch event changes
            scope.$watch("model", function(newv, oldv, $scope) {
                // TODO: maybe we should pass locals to $eval
                scope.$parent.$eval(scope.on_change);
            }, true);
        }

        scope.help_btn_clicked = function() {
            if ("show_help_callback" in scope.options) {
                scope.options.show_help_btn();
            }
            else {
                scope.show_help_text = !scope.show_help_text;
            }
        };

        scope.have = function(ob, element) {
          if (ob !== undefined) {
            if (element in ob) {
                return true;
            }
            else {
                return false;
            }
          }
          return false;
        };

    }
    // Actual object of <string-field> directive
    return {
        templateUrl: template("fields/string/string"),
        replace: true,
        restrict: "E",
        scope: {
            // you can control the buttons and help
            // message of field here. for example you can use `help_text` to
            // show an small help under the control and you can set `show_help_btn`
            // to true to show an help button.
            // options is optional (notice '=?')
            options: '=?',

            // Css classes to apply on element
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
