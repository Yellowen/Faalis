var Date_ = angular.module("DateField", []);

/*
 * <string-field></string-field> directive defination
 */

Date_.directive('dateField', ["$filter", "gettext",  function($filter, gettext) {

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
            format: 'dd-MM-yy',
            locale: locale

        });
    }
    // Actual object of <date-field> directive
    return {
        templateUrl: template("fields/datetime/date"),
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
