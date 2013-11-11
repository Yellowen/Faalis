Dashboard.Group = DS.Model.extend(Dashboard.DModel, {
    name: DS.attr('string'),
    permissions: DS.hasMany("permission")
});

Dashboard.Group.FIXTURES =[
    {
        id: 1,
        name: "Agents"
    },
    {
        id: 2,
        name: "Customers"
    }
];
