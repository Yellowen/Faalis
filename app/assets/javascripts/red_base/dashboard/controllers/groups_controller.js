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
        save_group: function(){
            var name = this.get("new_name");
            var permissions = [];
            var has_error = false;
            var store = this.get("store");

            if (name === undefined) {

                $("#new_name").addClass("error");
                $("#new_name + small").addClass("error");
                $("#new_name + small").html(_("Name is not optional."));
                has_error = true;
            }
            if (has_error) {
                error_message(_("Save action failed. Check your form for possible errors."));
                return;
            }

            $(".permissions li.selected").each(function(){
                permissions.push($(this).attr("id"));
            });

            var group = this.store.createRecord("group",
                                           {name: name,
                                            permisssions: permissions});

            group.save();
            success_message(_("Your group created successfully."));
            this.transitionTo('groups');

        },
        select_permission: function(perm) {
            perm.toggleProperty("is_selected");
        }
    }
});
