var modules = [
    {
        title: "sameer",
        icon: "icon-twitter",
        resource: "index"
    },
    {
        title: "ali",
        resource: "modules"
    }
];

Dashboard.ApplicationRoute = Ember.Route.extend({
    setupController: function(controller, model){
        var that = this;
        Ember.$.getJSON("modules.json")
            .done(function(data) {
                that.controllerFor('modules').set('model',data.modules);
            })
            .fail(function(data){
                console.log("Fix me");
            });
    }
});
