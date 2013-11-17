function auth_routes(router) {
    console.log(router);
    router.
        when("/auth", {
            templateUrl: templates_path + "auth/index.html",
            controller: 'AuthController'
        });
}
