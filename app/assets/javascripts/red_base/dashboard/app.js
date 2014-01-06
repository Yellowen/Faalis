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

//= require ./functions
//= require_tree ./modules
//= require_self
//= require ./locale/translations

var dependencies = ["gettext", "Modules", "Navigation", "ngAnimate", "ngRoute",
                    "restangular", "ngQuickDate", "Errors", "Profile"].concat(dashboard_dependencies);

console.log("Dashboard dependencies:");
console.log(dependencies);

var Dashboard = angular.module('Dashboard', dependencies);

Dashboard.config(['$routeProvider', function($routeProvider) {
    $routeProvider.
        when("/", {
            templateUrl: template("index")
        });

}]);

Dashboard.config(["RestangularProvider", "$httpProvider", "ngQuickDateDefaultsProvider", function(RestangularProvider, $httpProvider, ngQuickDateDefaultsProvider) {

    ngQuickDateDefaultsProvider.set({
        closeButtonHtml: "<i class='fa fa-times'></i>",
        buttonIconHtml: "<i class='fa fa-calendar'></i>",
        nextLinkHtml: "<i class='fa fa-chevron-right'></i>",
        prevLinkHtml: "<i class='fa fa-chevron-left'></i>"
    });

    RestangularProvider.setBaseUrl('/api/v1');

    $httpProvider.defaults.headers.common.lang = $("html").attr("lang");
    $httpProvider.defaults.headers.common.RTYPE = "ajax";

    // Show loading icon on any request
    $httpProvider.interceptors.push(function($q) {
        return {
            'request': function(config) {
                $(".loading").show();
                return config;
            },
            'response': function(response) {
                $(".loading").hide();
                return response;
            }
        };
    });
    RestangularProvider.setErrorInterceptor(function(response, a){
        $(".loading").hide();
        if (response.status == 401) {
            error_message(response.data.error);
            return false;
        }
    });
}]);
