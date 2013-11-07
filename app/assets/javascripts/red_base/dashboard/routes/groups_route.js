Dashboard.GroupsIndexRoute = Ember.Route.extend({
    model: function(){
        return this.store.find('group');
    },
    renderTemplate: function(controller, model) {
        this.render("auth/groups/index");
    }
});

Dashboard.GroupsNewRoute = Ember.Route.extend({

    renderTemplate: function(controller, model) {
        this.render("auth/groups/new");
    }
});
