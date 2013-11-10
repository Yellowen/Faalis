
Dashboard.ApplicationRoute = Ember.Route.extend({
    setupController: function(controller, model){
        var that = this;
        get_modules();
        this.controllerFor('modules').set('model', Modules);
    }
});
