var modules = [
    {
        title: "sameer"
    },
    {
        title: "ali"
    }
];

Dashboard.ModulesRoute = Ember.Route.extend({
    model: function(){
        return modules;
    }
});
