Dashboard.UsersIndexController = Ember.ArrayController.extend(Dashboard.DController, {
    action_buttons: [
            {
                classes: "btn small green",
                label: _('New'),
                icon: "fa fa-plus",
                route: 'users.new'
            },
            {
                classes: "btn small yellow",
                label: _('Activate'),
                icon: "fa fa-check-circle-o"
            }]
});
