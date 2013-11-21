/* -----------------------------------------------------------------------------
    Red Base - Basic website skel engine
    Copyright (C) 2012-2013 Yellowen

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License along
    with this program; if not, write to the Free Software Foundation, Inc.,
    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
----------------------------------------------------------------------------- */

var ListView = angular.module("ListView", []);

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
            var controller = element.controller();
            element.on("click", function(){ controller[object.action]();});
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
ListView.directive('listView', function($filter) {

    function link(scope, element, attrs){
        var ltr = is_ltr();
        var _item_per_page = parseInt(scope.item_per_page, 10) || 10;
        var _current_page = 1;
        var filtered_objects = function(){
            return $filter('filter')(scope.objects, scope.searchterm);
        };

        scope.is_ltr = ltr;
        scope.handle_icon = ltr ? "fa-angle-right" : "fa-angle-left";
        scope.first_page_icon = ltr ? "fa-angle-double-left" : "fa-angle-double-right";
        scope.last_page_icon = ltr ? "fa-angle-double-right" : "fa-angle-double-left";
        scope.prev_page_icon = ltr ? "fa-angle-left" : "fa-angle-right";
        scope.next_page_icon = ltr ? "fa-angle-right" : "fa-angle-left";
        scope.hand_icon = ltr ? "fa-hand-o-right" : "fa-hand-o-left";

        scope.handle_icon_expand = function(object){
            if(scope.should_view(object)) {
                return ltr ? "fa-rotate-90" : "fa-rotate-270";
            }
            return "";
        };

        // Select a row in table
        scope.select_item = function(object) {
            if ("is_selected" in object) {
                object.is_selected = ! object.is_selected;
            }
            else {
                object.is_selected = true;
            }

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
            var pages = parseInt(len / _item_per_page);

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
        // ----------------------------------------------------
        // TODO: create some methods in scope for those buttons
        //       which need to call a method instead of changing location
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
            item_per_page: "=itemPerPage"
        },
        link: link
    };
});
