var modules = [
    {
        title: "sameer",
        icon: "icon-twitter",
        url: "index"
    },
    {
        title: "ali",
        url: "modules"
    }
];

Dashboard.ApplicationRoute = Ember.Route.extend({
    setupController: function(controller, model){
        return this.controllerFor('modules').set('model', modules);
    }
});
