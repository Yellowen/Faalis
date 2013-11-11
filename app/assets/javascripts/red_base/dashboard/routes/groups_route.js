Dashboard.GroupsIndexRoute = Ember.Route.extend({
    model: function(){
        return this.store.find('group');
    },
    renderTemplate: function(controller, model) {
        this.render("auth/groups/index");
    }
});

Dashboard.GroupsNewRoute = Ember.Route.extend({
    setupController: function (controller, model) {
        /*$.ajax({url: API_PREFIX + "permissions",
                async: false,
                dataType: 'json',
                type: 'GET'})
        .done(function(data){
            controller.set("permissions", data);
        })
        .fail(function(data){
            error_message(_("Can not connect to remote, please try again"));
        });*/

        var permissions = this.store.find("permission");
        controller.set("permissions", permissions);
    },
    renderTemplate: function(controller, model) {
        this.render("auth/groups/new");
    }
});
