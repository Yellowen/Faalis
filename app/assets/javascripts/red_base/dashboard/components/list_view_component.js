Dashboard.ListViewComponent = Ember.Component.extend({
    classNames: ["table-list"],
    is_all_selected: true,

    count: function(){
        var model = this.get("model");
        return model.get("content").get("length");
    }.property("model.content.length"),

    selected_count: function(){
        var model = this.get("model");
        return model.filterBy("is_selected", true).get("length");
    }.property("model.@each.is_selected"),

    actions: {

        delete_items: function(model){
            this.sendAction('delete_items', model);
            /*var records = model.filterBy('is_selected', true);

            records.forEach(function(x){
                console.dir(x.toString());
                x.record.deleteRecord();
            });
            records.save();*/
        },
        select_item: function(record){
            record.set('is_selected', !record.get('is_selected'));
        },

        toggle_select: function(model){
            model.get("content").forEach (function(x){
                x.record.toggleProperty("is_selected");
            });
        },
        select_all: function(model){
            model.get("content").setEach("record.is_selected", this.is_all_selected);
            this.is_all_selected = !this.is_all_selected;
        },

        toggle_details: function(record){
            record.toggleProperty("view_details");
        }
    }
});
