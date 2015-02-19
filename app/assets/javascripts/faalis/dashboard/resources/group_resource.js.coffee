class Faalis.GroupFactory extends Faalis.ResourceFactory
  name: 'group'

  fields: [
    new Faalis.StringField('title'),
    new Faalis.HasManyField('permissions', Faalis.PermissionsFactory)
  ]
