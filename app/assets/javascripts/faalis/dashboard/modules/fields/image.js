var Image_ = angular.modulde("DatetimeField", ['flow']);

/*
 * <image-field></image-field>
*/

Image_.directive('imageField',["gettext", function(gettext){
    function link(scope, element, attrs){
        var ltr = is_ltr();
        scope.element_id = "id_" + scope.field;
        scope.msg_element_id = "id_" + scope.field + "_msg";

        if (scope.on_change !== undefined) {
            // Watch event changes
            scope.$watch("model", function(newv, oldv, $scope) {
                // TODO: maybe we should pass locals to $eval
                scope.$parent.$eval(scope.on_change);
            }, true);
        }
    }
    return {
        templateUrl: template("fields/image/image"),
        replace: true,
        restrict: "E",
        transclude: true,
        scope: {

            cssClasses: '=cssClass',
            // A call back to pass to field ng-change directive
            on_change: "@onChange",
            // fieldname
            required: "=",
            // Actual Angularjs ng-model
            model: '=',
            // image source
            src: '='
        },
        link: link
    };

}]);
