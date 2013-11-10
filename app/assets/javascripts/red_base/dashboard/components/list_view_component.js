Dashboard.ListViewComponent = Ember.Component.extend({
    // by this.userSpecifiedParameter we can access to user params
    classNames: ["table-list"],
    is_all_selected: true,
    page: 1,

    has_pagination: function(){
        if (this.get("total_pages") > 1){
            return true;
        }
        return false;
    }.property("total_pages"),

    total_pages: function(){
        var pages = parseInt(this.get("count") / this.get("items_pp"), 10);
        if (parseInt(this.get("count") % this.get("items_pp"), 10) > 0) {
            pages++;
        }
        return pages;
    }.property('item_pp', 'count'),

    current_page: function(){
        return parseInt(this.page, 10);
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
        return parseInt(model.get("content").get("length"), 10);
    }.property("model.content.length"),

    selected_count: function(){
        var model = this.get("model");
        return model.filterBy("is_selected", true).get("length");
    }.property("model.@each.is_selected"),

    // Buttons in Action bar
    action_buttons: function(){
        return this.buttons;
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
            this.sendAction('delete_items', model);
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
        },

        // Pagination action handlers ------------------
        go_to_page: function(value) {
            var tp = this.get("total_pages");
            if (value <= tp) {
                this.set("current_page", value);
            }
            else {
                error_message(_('Given page does not exists'));
            }

        },

        go_to_next_page: function(){
            var cp = this.get("current_page");
            var tp = this.get("total_pages");
            console.log(cp);
            console.log(tp);
            if (cp < tp ) {
                this.incrementProperty("current_page");
            }
        },
        go_to_prev_page: function(){
            var cp = this.get("current_page");
            var tp = this.get("total_pages");
            console.log(cp);
            console.log(tp);
            if (1 < cp ) {

                this.decrementProperty("current_page");
            }
        },
        go_to_last_page: function(){
            var tp = this.get("total_pages");
            this.set("current_page", tp - 1);
        },
        go_to_first_page: function(){
            var tp = this.get("total_pages");
            this.set("current_page", 1);
        }
        // -----------------------------------------------

    }
});