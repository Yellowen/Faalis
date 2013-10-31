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
            console.log(this.$);
            var details = this.$.find(".details");
            this.$.parent().find(".details").not(this.$).slideUp();
            this.$.parent().find(".handle").not(this.$.find(".handle")).removeClass("fa-rotate-90");
            if ($(details).is(":visible")) {
                this.$.find(".handle").removeClass("fa-rotate-90");
            }
            else {
                if ($(details).length !== 0) {
                    this.$.find(".handle").addClass("fa-rotate-90");
                }
            }
            $(details).slideToggle();
        }
    }
});
