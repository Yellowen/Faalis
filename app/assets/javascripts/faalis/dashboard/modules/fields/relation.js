var Relation = angular.module("RelationField", ["ui.select2"]);

/*
 * <relation-field></relation-field> directive defination
 */

Relation.directive('relationField', ["$filter", "gettext", "Restangular", "catch_error", function($filter, gettext, API, catch_error) {

    function link(scope, element, attrs){
        var ltr = is_ltr();
        scope.element_id = "id_" + scope.field.name;
        scope.msg_element_id = "id_" + scope.field.name + "_msg";

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
                API.all(scope.field.to).getList().then(function(data){
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
        update_model_data();
    }
    // Actual object of <relation-field> directive
    return {
        templateUrl: template("fields/relation/relation"),
        replace: true,
        restrict: "E",
        transclude: true,
        scope: {
            // select2 options
            select2Options: '=',
            // A call back to pass to field ng-change directive
            on_change: "@onChange",

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
