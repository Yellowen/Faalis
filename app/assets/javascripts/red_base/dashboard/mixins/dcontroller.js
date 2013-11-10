Dashboard.DController = Ember.Mixin.create({
    buttons: function(){
        return this.action_buttons;
    }.property(),

    actions: {
        delete_items: function(model){
            var records = this.get("model").filterBy('is_selected', true);
            records.forEach(function(x){
                console.dir(x.toString());
                x.deleteRecord();
                x.save();
            });
            success_message(_("Selected record(s) removed successfully."));
        }
    }

});