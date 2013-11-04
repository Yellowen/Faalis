Ember.Handlebars.registerHelper('dynamic_render', function(template, model, options){
    template = Ember.Handlebars.get(this, template, options);
    //record = Ember.Handlebars.get(this, model, options);
    //console.dir(record);
    Ember.Handlebars.helpers.render(template, model, options);
});
