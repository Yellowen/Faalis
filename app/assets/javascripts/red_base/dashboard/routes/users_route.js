Dashboard.UsersRoute = Ember.Route.extend({
    renderTemplate: function(controller, model) {
        this.render("users/index");
    }
});
