class @GroupResource extends Faalis.Resource

  __name__: 'group'

  __attributes__: [
    new Faalis.StringField('title'),
    new Faalis.HasManyField('permissions', Faalis.PermissionResource)
  ]

Faalis.GroupResource = @GroupResource
