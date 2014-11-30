var Tag = angular.module("TagField", ["ui.select2"]);

// <tag-field></tag-field> directive defination

Tag.directive('tagField', ["$filter", "gettext", "Restangular", "catch_error", function($filter, gettext, API, catch_error) {

    function link(scope, element, attrs){

        var ltr = is_ltr();
        scope.element_id = "id_" + scope.fieldName;
        scope.msg_element_id = "id_" + scope.fieldName + "_msg";
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

        scope.help_btn_clicked = function() {
            if ("show_help_callback" in scope.options) {
                scope.options.show_help_btn();
            }
            else {
                scope.show_help_text = !scope.show_help_text;
            }
        };
    }
    // Actual object of <tag-field> directive
    return {
        templateUrl: template("fields/tag/tag"),
        replace: false,
        restrict: "E",
        transclude: false,
        scope: {
            // select2 options. Also you can control the buttons and help
            // message of field here. for example you can use `help_text` to
            // show an small help under the control and you can set `show_help_btn`
            //options: '&',
            // to true to show an help button.

            // A call back to pass to field ng-change directive
            on_change: "@onChange",

            // Place holder
            placeholder: "@placeholder",

            // Does this field is required
            required: "=",

            // tag field data
            fieldName: '=',
            options: '=',
            // A variable to watch. in case of change current field
            // collection will update.
            update_on_change: '=updateOnChange',

            // Actual Angularjs ng-model
            model: '='
        },
        link: link
    };
}]);
