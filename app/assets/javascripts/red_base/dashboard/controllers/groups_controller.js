Dashboard.GroupsIndexController = Ember.ArrayController.extend(Dashboard.DController, {
    action_buttons: [{
        classes: "btn small green",
        label: _('New'),
        icon: "fa fa-plus",
        route: 'groups.new'
    }]
});

Dashboard.GroupsNewController = Ember.ArrayController.extend(Dashboard.DController, {
    _permissions: [],

    permissions: function(key, value){

        if (value === undefined) {
            return this._permissions;
        } else {
            this._permissions = value;
            return value;
        }
    }.property(),

    actions: {
        select_permission: function(perm) {
            perm.toggleProperty("is_selected");
        }
    }
});
