Dashboard.ListViewComponent = Ember.Component.extend({
    // by this.userSpecifiedParameter we can access to user params
    classNames: ["table-list"],
    is_all_selected: true,
    page: 1,

    has_pagination: function(){
        console.log(this.get("total_pages"));
        if (this.get("total_pages") > 1){
            return true;
        }
        return false;
    }.property("total_pages"),

    total_pages: function(){
        return parseInt(this.get("count") / this.get("items_pp"));
    }.property('item_pp', 'count'),

    current_page: function(){
        return parseInt(this.page);
    }.property(),

    // Items Per Page
    items_pp: function(){
        return this.items_per_page;
    }.property('items_per_page'),

    this_page: function(){
        return this.model.slice((this.get("current_page") * this.get("items_pp")) - this.get("items_pp"),
                                (this.get("current_page") * this.get("items_pp")) - 1);

    }.property('model.content.length', 'current_page'),

    count: function(){
        var model = this.get("model");
        return parseInt(model.get("content").get("length"));
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
