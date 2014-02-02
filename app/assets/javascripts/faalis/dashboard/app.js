

//= require ./functions
//= require_tree ./modules
//= require_self
//= require ./locale/translations

var dependencies = ["gettext", "Modules", "Navigation","ui.select2",  "ngAnimate", "ngRoute",
                    "restangular", "ngQuickDate", "Errors", "Profile", "Permissions", "Conversation"].concat(dashboard_dependencies);

console.log("Dashboard dependencies:");
console.log(dependencies);

var Dashboard = angular.module('Dashboard', dependencies);

Dashboard.config(["$routeProvider", "RestangularProvider", "$httpProvider", "ngQuickDateDefaultsProvider", function($routeProvider, RestangularProvider, $httpProvider, ngQuickDateDefaultsProvider) {

    $routeProvider.when("/", {
        templateUrl: template("index")
    });

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

Dashboard.run(["UserPermissions", "$rootScope", function(User, $rootScope){
    $rootScope.user = User;
}]);

angular.element(document).ready(function(){
    $.ajax({method: 'GET', type: 'json',
            url: API_PREFIX + "permissions/user"})
           .success(function(data, status, headers, config){
               PERMISSIONS = data.permissions;
               angular.bootstrap(document, ["Dashboard"]);
           })
           .fail(function(data){
               alert('Can not connect to remote, please try again');
           }).always(function(){
               $("#mainloader").hide();
               $("#content").show();
           });
});
