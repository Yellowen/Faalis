// InputGrid control
// -----------------
// This module is responsible for `<input-grid></input-grid>` directive which will create
// a grid of controls. This directive can populate with data from a remote **API** and add
// any suitable inputs to each record of data and build a grid.

// **InputGrid** module defination. To use this directive you should specify this module as
// dependency.
var InputGrid = angular.module("InputGrid", []);

// Directive defination
// --------------------
InputGrid.directive('inputGrid', ["$filter", "gettext", function($filter, gettext) {

    // `link` function of `<input-grid></input-grid>` directive.
    function link(scope, element, attrs){
        var ltr = is_ltr();
        scope.element_id = "id_" + scope.field;
        scope.msg_element_id = "id_" + scope.field + "_msg";
    }

    // Actual object of `<input-grid></input-grid>` directive object
    return {

        // Address of temlate to use with this directive
        templateUrl: template("fields/input-grid/input-list"),

        // Replace the template with `<input-grid></input-grid>` defination in view
        replace: true,

        // directive type
        restrict: "E",

        // scope data
        scope: {

            // css classes to pass to input field
            cssClasses: '=cssClass',

            // Does this field is required
            required: "=",
            // Actual Angularjs ng-model
            model: '='
        },
        link: link
    };
}]);
