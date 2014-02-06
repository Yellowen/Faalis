// ControlCombo control
// -----------------
// This module is responsible for `<control-combo></control-combo>` directive which will create
// a list of controls which each row will be a dedicated to a record in a table.
// Using this field user can select data like a multiple select control but also he/she can add
// extra information for his/her selection.
//  This directive can populate with data from a remote **API** and add
// any suitable inputs to each record of data.

// **ControlCombo** module defination. To use this directive you should specify this module as
// dependency.
var ControlCombo = angular.module("ControlCombo", []);

// Directive defination
// --------------------
ControlCombo.directive('controlCombo', ["$filter", "gettext", "catch_error",  function($filter, gettext, catch_error) {

    // `link` function of `<control-combo></control-combo>` directive.
    function link(scope, element, attrs){
        var ltr = is_ltr();
        scope.element_id = "id_" + scope.field;
        scope.msg_element_id = "id_" + scope.field + "_msg";

        // Get the objects list from remote API
        scope.config.objects.getList().then(function(data){
            scope.objects_rows = data;
        }, function(data){
            catch_error(data);
        });
    }

    // Actual object of `<control-combo></control-combo>` directive object
    return {

        // Address of temlate to use with this directive
        templateUrl: template("fields/control-combo/control-list"),

        // Replace the template with `<control-combo></control-combo>` defination in view
        replace: true,

        // directive type
        restrict: "E",

        // scope data
        scope: {
            // Configuration object. this object should be like:
            // ```javascript
            // {
            //        objects: API.all("<resource>"),
            //        row_template: template("<template-address>"),
            // }
            // row_template should contains the template for one row of controls
            config: '=',
            // Scope variable which will be the angular model
            model: "=",
            // css classes to pass to input field
            cssClasses: '=cssClass',
            // Does this field is required
            required: "="
        },
        link: link
    };
}]);
