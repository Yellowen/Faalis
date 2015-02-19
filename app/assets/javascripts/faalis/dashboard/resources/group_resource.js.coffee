class Faalis.GroupFactory extends Faalis.ResourceFactory
  @fields = [
    new Faalis.StringField('title'),
    new Faalis.HasMany('permissions', Faalis.PermissionsFactory)
  ]
