// For more information see: http://emberjs.com/guides/routing/

Dashboard.Router.map(function(match) {
    this.resource("modules");
    this.resource("users");
    //this.resource("navigation");
    //this.resource("user", {path: "me"});

});
