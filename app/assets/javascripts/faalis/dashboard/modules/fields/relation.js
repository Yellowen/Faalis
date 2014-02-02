


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
                }, function(data){
                    catch_error(data);
                });
            };

            scope.update_collection();
        }
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
