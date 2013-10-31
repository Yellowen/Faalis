Dashboard.UsersRoute = Ember.Route.extend({
    model: function(){
        return this.store.find('user');
    },
    renderTemplate: function(controller, model) {
        this.render("users/index");
    }
});
