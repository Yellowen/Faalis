Dashboard.ListViewComponent = Ember.Component.extend({
    classNames: ["table-list"],
    actions: {

        delete: function(record){
            record.deleteRecord();
            record.save();
        }
    }
});
