class @GroupResource extends Faalis.Resource

  __name__: 'group'

  console.log("23333333333333")
  console.log(PermissionResource)

  __attributes__: [
    new Faalis.StringField('title'),
    new Faalis.HasManyField('permissions', Faalis.PermissionResource)
  ]

Faalis.GroupResource = @GroupResource
