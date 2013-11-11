function build_recursive_route(that, modules) {
    modules.forEach(function(module) {
        var modules_list = [];
        if ("modules" in module) {
            module.modules.forEach(function(x){
                modules_list.push(x);
            });
        }

        var options = {};

        if ("path" in module) {
            options = {path: module.path};
        }

        that.resource(module.resource, options, function(){
            build_recursive_route(that, modules_list);
            that.route("new");
            that.route("edit");
        });

    });

}
/*
 * This function will calls some function based on
 * Resource name and let them create their own routes
 * each function should have a name like <resource>_routes
 */
function build_routes_for_modules(that, modules) {
    modules.forEach(function(module){
        var router_name = module.resource + "_routes";
        if (router_name in window) {
            console.log("Router: " + router_name);
            window[router_name](that);
        }
    });
}

Dashboard.Router.map(function() {
    var that = this;

    this.resource("widgets", {path: "/"});

    get_modules();
    build_routes_for_modules(this, Modules);
});
