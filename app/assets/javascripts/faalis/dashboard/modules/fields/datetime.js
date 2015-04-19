var Datetime_ = angular.module("DatetimeField", []);

/*
 * <string-field></string-field> directive defination
 */

Datetime_.directive('datetimeField', ["$filter", "gettext",  function($filter, gettext) {

    function link(scope, element, attrs){
        var ltr = is_ltr();
        var locale = (ltr) ? 'en' : 'fa';
        scope.element_id = "id_" + scope.field;
        //TODO: change the find selector to use ID
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
            widgetPositioning: {
                horizontal: 'left',
                vertical: 'bottom'
            },
            sideBySide: true,
            locale: locale

        });

        scope.$watch('fake_model', function(x, y) {
        });
    }
    // Actual object of <datetime-field> directive
    return {
        templateUrl: template("fields/datetime/datetime"),
        replace: true,
        restrict: "E",
        transclude: true,
        scope: {
            // disable timepicker
            time: "=?",

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
