Dashboard.DController = Ember.Mixin.create({
    buttons: function(){
        return this.action_buttons;
    }.property(),

    // Is current layout left to right ?
    is_ltr: function(){
        if($("html").attr("dir") == "ltr") {
            return true;
        }
        return false;
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
