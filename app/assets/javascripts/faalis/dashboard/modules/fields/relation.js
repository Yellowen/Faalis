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
            scope.show_buttons = function() {
                if ("hide_buttons" in scope.field) {
                    return !scope.field.hide_buttons;
                }
                return true;
            };

            // Update current field collection list by execute a query on remote end.
            // if `force` param had non undefined value this method will skip `parent_id`
            // check
            scope.update_collection = function(force){
                if ("parent_id" in scope.field) {
                    if ((scope.field.parent_id === undefined) && (force === undefined)) {
                        return;
                    }
                }
                var to = scope.field.to;
                if (typeof(scope.field.to) === "function") {
                    to = scope.field.to();
                }
                var list_object = API.all(to);
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
        else {
            // Add support for `multiple` key in fields with `in` type
            scope.multiple = function(){
                if ("multiple" in scope.field) {
                    if (scope.field.multiple !== undefined) {
                        return scope.field.multiple;
                    }
                }
                return false;
            };
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

        // User can provide a variable to watch on. In case of
        // any change below function will run. for example:
        // suppose your select box should update by using value
        // of other fields. you can add `update-on-change="OtherVar"
        // to your relation-field.
        // Remember that in that case you should specify a function
        // for `to` field of `field-data` which should return a url
        // of destination resource.
        scope.$watch('update_on_change', function(newv) {
            if (newv !== undefined) {
                scope.update_collection(true);
            }
        });
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

            // A variable to watch. in case of change current field
            // collection will update.
            update_on_change: '=updateOnChange',

            // Actual Angularjs ng-model
            model: '='
        },
        link: link
    };
}]);
