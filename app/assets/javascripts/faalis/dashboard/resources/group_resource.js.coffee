angular.module('GroupResourse').provider 'GroupFactory', ->

  @get: ->
    class Faalis.GroupFactory extends Faalis.ResourceFactory
      name: 'group'

      fields: [
        new Faalis.StringField('title'),
        new Faalis.HasManyField('permissions', Faalis.PermissionsFactory)
      ]
    return Faalis.GroupFactory
