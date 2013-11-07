function auth_routes(that) {
    that.resource("auth", function(){
        this.resource("users", function(){
            this.route("new");
        });
        this.resource("groups", function(){
            this.route("new");
        });
    });

}
