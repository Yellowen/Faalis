
function auth_routes($routeProvider) {

    $routeProvider.
        when("/auth", {
            templateUrl: templates_path + "auth/index.html",
            controller: function(){
                var $injector = angular.injector(["Auth"]);
                var a = $injector.get("AuthController");
                console.log(a);
                return a;
            }
        });

}
