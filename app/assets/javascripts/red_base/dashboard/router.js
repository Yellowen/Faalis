// For more information see: http://emberjs.com/guides/routing/

Dashboard.Router.map(function() {
    this.resource("widgets", {path: "/"});
    this.resource("modules");
    this.resource("users");
    //this.resource("navigation");
    //this.resource("user", {path: "me"});

});
