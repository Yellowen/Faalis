var Time_ = angular.module("TimeField",[]);
/*
 * <string-field></string-field> directive defination
 */

Time_.directive('timeField', ["$filter", "gettext", function($filter, gettext){

    function link(scope, element, attrs){

        if (scope.model === undefined) {
            scope.model = new Time();
        }
        else {
            if (! scope.model instanceof Time) {
                scope.model = new Time(scope.model);
            }
        }

        if (scope.on_change !== undefined) {
            // Watch event changes
            scope.$watch("model", function(newv, oldv, $scope) {
                // TODO: maybe we should pass locals to $eval
                scope.$parent.$eval(scope.on_change);
            }, true);
        }

    /* Increases hours by one */
    scope.increaseHours = function () {

        //Check whether hours have reached max
        if (scope.hours < 23) {
            scope.hours = ++scope.hours;
            scope.model.set_hour = scope.hours;
        }
        else {
            scope.hours = 0;
            scope.model.set_hour = 0;
        }
    };

    /* Decreases hours by one */
    scope.decreaseHours = function () {

        //Check whether hours have reached min
        scope.hours = scope.hours <= 0 ? 23 : --scope.hours;
        scope.model.set_hour = scope.hours;
    };

    /* Increases minutes by one */
    scope.increaseMinutes = function () {
        //Check whether to reset
        if (scope.minutes < 59) {
            scope.minutes++;
        }else if(scope.minutes == 59) {
            scope.increaseHours();
            scope.minutes = 0;
        }else {
            scope.minutes = 0;
        }
        scope.model.set_minute = scope.minutes;
    };

    /* Decreases minutes by one */
    scope.decreaseMinutes = function () {

        //Check whether to reset
        if (scope.minutes <= 0) {
            scope.minutes = 59;
        }else if (scope.minutes === 0){
            scope.hours--;
        }else {
            scope.minutes--;
        }
    };

        /* Update model when interface values changed */
        scope.update = function (value) {
            if (value == 'hour'){
                if (scope.hours <= 23) {
                    scope.model.set_hour = scope.hours;
                }
                else {
                    scope.hours = 0;
                    scope.model.set_hour = 0;
                }
            }
            else{
                //Check whether to reset
                if(scope.minutes <= 59) {
                    scope.model.set_minute = scope.minutes;
                }else {
                    scope.minutes = 0;
                }
            }
        };

    /* Displays hours - what the user sees */
    scope.displayHours = function () {

        //Create vars
        var hoursToDisplay = scope.hours;

        //Check whether to reset etc
        if (scope.hours > 23) {
            hoursToDisplay = scope.hours - 23;
        }

        else {

            //Check whether to prepend 0
            if (hoursToDisplay <= 9) {
                hoursToDisplay = "0" + hoursToDisplay;
            }
        }

        return hoursToDisplay;
    };

    /* Displays minutes */
    scope.displayMinutes = function () {
        return scope.minutes <= 9 ? "0" + scope.minutes : scope.minutes;
    };

}
    // Actual object of <string-field> directive
    return {
        templateUrl: template("fields/datetime/time"),
        replace: true,
        restrict: "E",
        transclude: true,
        scope: {
            cssClasses: '=cssClass',
            // A call back to pass to field ng-change directive
            on_change: "@onChange",
            // fieldname
            field: "=fieldName",
            // Actual Angularjs ng-model
            model: '='
        },
        link: link
    };

                             }]);
