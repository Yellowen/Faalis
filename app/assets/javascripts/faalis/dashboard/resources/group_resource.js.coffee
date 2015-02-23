class Faalis.GroupResource extends Faalis.Resource
  name: 'group'

  fields: [
    new Faalis.StringField('title'),
    new Faalis.HasManyField('permissions', Faalis.PermissionResource)
  ]
