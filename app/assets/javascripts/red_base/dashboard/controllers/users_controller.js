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

Dashboard.UsersNewController = Ember.ArrayController.extend(Dashboard.DController, {
    actions: {
        add_user: function(){
            var first_name = this.get('first_name'.trim());
            var last_name = this.get('last_name'.trim());
            var email = this.get('email'.trim());
            if (!first_name || !last_name || !email){
                error_message(_("You should fill the form completely"));
            }else{
                var user = this.store.createRecord('user', {
                    first_name: first_name,
                    last_name: last_name,
                    email: email
                });
                this.set('first_name', '');
                this.set('last_name','');
                this.set('email');
                user.save();
                consol.log("saved");
            }
        }
    }
});
