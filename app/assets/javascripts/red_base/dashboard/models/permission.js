Dashboard.Permission = DS.Model.extend(Dashboard.DModel, {
    name: DS.attr('string'),
    string: DS.attr('string'),
    groups: DS.hasMany("group")
});

Dashboard.Permission.FIXTURES =[
    {id: 1, "name":"read|RedBase::User", "string":"can read Red base/user"},
    {id: 2, "name":"update|RedBase::User","string":"can update Red base/user"}
];
