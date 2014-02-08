var ListView = angular.module("ListView", ['ngGrid', 'Permissions']);

/*
 * <element object-action></element> directive defination
 */
ListView.directive("objectAction", function(){

    function link(scope, element, attrs){

        var object = scope.object;
        var action = scope.action;

        if ("route" in object){
            element.attr("href", object.route);
        }
        else if ("action" in object) {
            element.on("click", object.action);
        }
    }

    // Actual object
    return {
        restrict: "A",
        scope: {
            object: "="
        },
        link: link
    };

});


/*
 * <list-view></list-view> directive defination
 */

ListView.directive('listView', ["$filter", "gettext", "UserPermissions", function($filter, gettext, User) {

    function link(scope, element, attrs){
        var ltr = is_ltr();
        var _item_per_page = parseInt(scope.item_per_page, 10) || 10;
        var _current_page = 1;
        scope.list_view = true;
        scope.grid_view = false;
        var use_permissions;

        if (scope.use_permissions === undefined) {
            use_permissions = true;
        }
        else {
            use_permissions = false;
        }


        scope.title = function(object, t) {
            if (typeof(scope.title_attr) == "function") {
                return scope.title_attr(object);
            }
            return object[scope.title_attr];
        };

        var filtered_objects = function(){
            var filterby = {};
            if (typeof(scope.title_attr) == "function") {
                filterby = scope.title_attr;
            }
            else {
                filterby[scope.title_attr] = scope.searchterm;
            }
            var result =  $filter('filter')(scope.objects, filterby, function(expected, actual){
                var re = new RegExp(".*" + actual + ".*", "ig");
                scope.go_to_first_page();
                if( expected.match(re) ){
                    return true;
                }
                return false;
            });
            // TODO: Double check this or condition
            return result  || [];
        };

        scope.grid_options = {
            data: 'objects',
            headerRowHeight: 30,
            rowHeight: 30,
            enablePaging: true,
            afterSelectionChange: function(rowitem, event){
                console.dir(rowitem);
                console.dir(event);
            },
            columnDefs: scope.column_defs
        };
        var delete_method = scope.on_delete || function(x){
            console.log( "undefined on delete method" );
        };

        scope.is_ltr = ltr;
        scope.handle_icon = ltr ? "fa-angle-right" : "fa-angle-left";
        scope.first_page_icon = ltr ? "fa-angle-double-left" : "fa-angle-double-right";
        scope.last_page_icon = ltr ? "fa-angle-double-right" : "fa-angle-double-left";
        scope.prev_page_icon = ltr ? "fa-angle-left" : "fa-angle-right";
        scope.next_page_icon = ltr ? "fa-angle-right" : "fa-angle-left";
        scope.hand_icon = ltr ? "fa-hand-o-right" : "fa-hand-o-left";
        scope.is_all_selected = false;

        scope.handle_icon_expand = function(object){
            if(scope.should_view(object)) {
                return ltr ? "fa-rotate-90" : "fa-rotate-270";
            }
            return "";
        };

        // View an item details
        scope.toggle_details = function(object){
            if ("view_details" in object){
                object.view_details = ! object.view_details;
            }
            else {
                object.view_details = true;
            }
        };

        // Should we open details section
        scope.should_view = function(object){
            if ("view_details" in object) {
                return object.view_details;

            }
            return false;
        };

        scope.delete_items = function(){

            var len = scope.selected_count();
            var objects_to_delete = [];

            if( confirm(gettext("Are sure you want to delete ") + len + gettext(" item(s)?")) ){
                var objects_list = filtered_objects();

                for(i = 0 ; i < objects_list.length; i++){

                    if (objects_list[i].is_selected === true) {
                        objects_to_delete.push(objects_list[i]);
                    }

                }

                delete_method(objects_to_delete);
            }


        };
        // Selection related methods -----------------------------------
        // Select a row in table
        scope.select_item = function(object) {
            if ("is_selected" in object) {
                object.is_selected = ! object.is_selected;
            }
            else {
                object.is_selected = true;
            }

        };

        scope.toggle_select = function (){
            var objects_list = filtered_objects();

            for(i = 0 ; i < objects_list.length; i++){
                objects_list[i].is_selected = ! objects_list[i].is_selected;
            }
        };

        scope.toggle_select = function (){
            var objects_list = filtered_objects();

            for(i = 0 ; i < objects_list.length; i++){
                objects_list[i].is_selected = ! objects_list[i].is_selected;
            }
        };

        scope.select_all = function (){
            var objects_list = filtered_objects();

            for(i = 0 ; i < objects_list.length; i++){
                objects_list[i].is_selected = ! scope.is_all_selected;
            }

            scope.is_all_selected = ! scope.is_all_selected;

        };

        scope.selected_count = function(){
            var myobjects = filtered_objects();
            var count = 0;
            for(i = 0; i < myobjects.length; i++) {
                if("is_selected" in myobjects[i]){
                    if(myobjects[i].is_selected) {
                        count++;
                    }
                }

            }
            return count;
        };
        // Pagination methods ---------------------------------

        scope.has_pagination = function(){
            return scope.total_pages() > 1 ? true : false;
        };

        scope.total_pages = function(){
            var len = filtered_objects().length;
            var pages = parseInt(len / _item_per_page, 10);

            if (len % _item_per_page > 0 || len < _item_per_page) {
                pages++;
            }

            return pages;
        };

        scope.current_page = function(){
            return _current_page;
        };

        scope.go_to_next_page = function(){
            if (_current_page < scope.total_pages()) {
                _current_page++;
            }
            else {
                _current_page = scope.total_pages();
            }
        };

        scope.go_to_prev_page = function(){
            if (_current_page > 1) {
                _current_page--;
            }
            else {
                _current_page = 1;
            }
        };

        scope.go_to_last_page = function(){
            _current_page = scope.total_pages();
        };

        scope.go_to_first_page = function(){
            _current_page = 1;
        };

        scope.go_to_page = function($event, value){
            if( $event.which == 13 ){

                var page = parseInt(value, 10);

                if (page > 0 && page <= scope.total_pages()) {
                    _current_page = page;
                }
                else {
                    value = _current_page;
                }

            }

        };

        scope.get_current_page = function(){
            var start = (scope.current_page() * _item_per_page) - _item_per_page;
            var end = (scope.current_page() * _item_per_page);

            return filtered_objects().slice(start, end);
        };

        scope.objects_count = function(){
            return filtered_objects().length;
        };

        scope.has_permission = function(button) {
            if (use_permissions === true) {
                if( "permission" in button ){
                    if ((!("name" in button.permission)) || (!("model" in button.permission))) {
                        console.log("Button permission should be an object and has 'name' and 'model' keys");
                        throw "Button permission should be an object and has 'name' and 'model' keys";
                    }
                    return User.can(button.permission.name, button.permission.model);
                }
            }
            return true;
        };
        scope.can = function(perm, model) {
            if (use_permissions === true) {
                return User.can(perm, model);
            }
            return true;
        };
    }


    // Actual object of <list-view> directive
    return {
        templateUrl: template("list-view/index"),
        restrict: "E",
        transclude: true,
        scope: {
            // Header section custom buttons
            buttons: "=buttons",

            // Objects which should listed
            objects: "=",

            // Object attribute which should show as title in main li
            title_attr: "=titleAttribute",

            // Template address for details section
            details_template: "=detailsTemplate",

            // Number of item per pages
            item_per_page: "=itemPerPage",

            // Search input
            search: "=",

            // Grid columns
            column_defs: "=columnDefs",

            // Permissions
            use_permissions: "=usePermissions",

            // Permission model
            permission_model: "=model",

            // On delete method
            on_delete: "=onDelete",

            // Custom delete title method
            delete_title: "=deleteTitle"
        },
        link: link
    };
}]);
