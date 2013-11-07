Dashboard.UsersIndexRoute = Ember.Route.extend({
    model: function(){
        return this.store.find('user');
    },
    renderTemplate: function(controller, model) {
        this.render("auth/users/index");
    }
});

Dashboard.UsersNewRoute = Ember.Route.extend({

    renderTemplate: function(controller, model) {
        this.render("auth/users/new");
    }
});
