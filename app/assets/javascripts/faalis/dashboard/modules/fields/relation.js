var Relation = angular.module("RelationField", ["ui.select2"]);

/*
 * <relation-field></relation-field> directive defination
 */

Relation.directive('relationField', ["$filter", "gettext", "Restangular", "catch_error", function($filter, gettext, API, catch_error) {

    function link(scope, element, attrs){
        var ltr = is_ltr();
        scope.element_id = "id_" + scope.field.name;
        scope.msg_element_id = "id_" + scope.field.name + "_msg";
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

        if( scope.field.type != "in" ){
            scope.have = function(obj_id) {
                var tmp = _.where(scope.model, { id: obj_id });
                if (tmp.length > 0) {
                    return true;
                }
                else {
                    return false;
                }
            };

            scope.update_collection = function(){
                var list_object = API.all(scope.field.to);
                if ("list_object" in scope.options) {
                    list_object = scope.options.list_object;
                }
                list_object.getList().then(function(data){
                    scope.all_options = data;
                    if (scope.collection !== undefined) {
                        scope.collection = data;
                    }
                }, function(data){
                    catch_error(data);
                });
            };

            scope.update_collection();
        }

        // Populate model with new data
        function update_model_data(){
            var new_val = $("#" + scope.element_id).val();
            scope.model = new_val;
            if (scope.on_change !== undefined) {
                scope.$parent.$eval(scope.on_change);
            }

        }
        scope.on_select_change = function(){
            update_model_data();
        };

        scope.help_btn_clicked = function() {
            if ("show_help_callback" in scope.options) {
                scope.options.show_help_btn();
            }
            else {
                scope.show_help_text = !scope.show_help_text;
            }
        };
        update_model_data();
    }
    // Actual object of <relation-field> directive
    return {
        templateUrl: template("fields/relation/relation"),
        replace: true,
        restrict: "E",
        transclude: true,
        scope: {
            // select2 options. Also you can control the buttons and help
            // message of field here. for example you can use `help_text` to
            // show an small help under the control and you can set `show_help_btn`
            // to true to show an help button.
            options: '&',
            // A call back to pass to field ng-change directive
            on_change: "@onChange",

            // Place holder
            placeholder: "@placeholder",

            // Collection of all relation objects, This variable will
            // fill automatically so you don't have to provide an initial
            // value.
            collection: "=",

            // Does this field is required
            required: "=",

            // Field to use as title of options
            titleField: '=',

            // relation field data
            field: '=fieldData',

            // Actual Angularjs ng-model
            model: '='
        },
        link: link
    };
}]);
