Dashboard.User = DS.Model.extend({
    email: DS.attr('string'),
    is_selected: false,
    view_details: false
});

Dashboard.User.FIXTURES =[
    {
        id: 1,
        email: "lxsameer@gnu.org"
    },
    {
        id: 2,
        email: "b3hnam@gnu.org"
    }
];
