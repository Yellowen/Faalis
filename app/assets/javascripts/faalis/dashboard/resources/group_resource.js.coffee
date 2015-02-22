angular.module('GroupResource', []).provider 'GroupFactory', [->

  class Faalis.GroupFactory extends Faalis.ResourceFactory
    name: 'group'

    fields: [
      new Faalis.StringField('title'),
      new Faalis.HasManyField('permissions', Faalis.PermissionsFactory)
    ]

  @resource = Faalis.GroupFactory

  this.$get = [->
    return @resource
  ]
  return
]
