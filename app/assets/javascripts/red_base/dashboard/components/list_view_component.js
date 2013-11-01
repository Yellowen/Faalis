Dashboard.ListViewComponent = Ember.Component.extend({
    classNames: ["table-list"],
    selected_list: [],

    actions: {

        delete: function(record){
            record.deleteRecord();
            record.save();
        },
        select_item: function(record){
            record.set('is_selected', !record.get('is_selected'));
        },

        toggle_details: function(record){
            record.toggleProperty("view_details");
        }
    }
});
