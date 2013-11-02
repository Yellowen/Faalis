Dashboard.DController = Ember.Mixin.create({
    actions: {
        delete: function(model){
            var records = this.get("model").filterBy('is_selected', true);
            records.forEach(function(x){
                console.dir(x.toString());
                x.deleteRecord();
                x.save();
            });

        }

    }

});


Dashboard.DModel = Ember.Mixin.create({
    is_selected: false,
    view_details: false
});
