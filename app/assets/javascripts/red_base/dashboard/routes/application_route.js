var modules = [
    {
        title: "sameer"
    },
    {
        title: "ali"
    }
];

Dashboard.ApplicationRoute = Ember.Route.extend({
    setupController: function(controller, model){
        return this.controllerFor('modules').set('model', modules);
    }
});
