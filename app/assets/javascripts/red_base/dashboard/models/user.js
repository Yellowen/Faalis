Dashboard.User = DS.Model.extend({
  email: DS.attr('string')
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
