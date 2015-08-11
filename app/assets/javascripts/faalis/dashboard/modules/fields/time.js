var Time_ = angular.module("TimeField", []);

/*
 * <time-field></time-field> directive defination
 */

Time_.directive('timeField', ["$filter", "gettext",  function($filter, gettext) {

    function link(scope, element, attrs){
        var ltr = is_ltr();
        var locale = (ltr) ? 'en' : 'fa';
        scope.element_id = "id_" + scope.field;
        element.find('div.date').datetimepicker({
            icons:{
                time: 'fa fa-clock-o',
                date: 'fa fa-calendar',
                up: 'fa fa-chevron-up',
                down: 'fa fa-chevron-down',
                previous: 'fa fa-chevron-left',
                next: 'fa fa-chevron-right',
                today: 'fa fa-screenshot',
                clear: 'fa fa-trash'

            },
            format: 'LT',
            locale: locale

        });
        scope.$watch('model', function(newv, oldv, $scope) {
            console.log(scope.model);
        });
    }
    // Actual object of <time-field> directive
    return {
        templateUrl: template("fields/datetime/time"),
        replace: true,
        restrict: "E",
        transclude: true,
        scope: {
            // disable timepicker
            timepicker: "=?",

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
