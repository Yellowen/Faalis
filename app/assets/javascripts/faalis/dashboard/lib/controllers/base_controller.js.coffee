# Father of all the client side controllers of **Faalis**
class Faalis.BaseController
  # **scope_obj** is an **AngularJS** scope instance that child
  # class should provide using `super` syntax
  constructor: (scope_obj)->

    # Inject all the methods in current object prototype
    # to the scope except for those which starts with an
    # underscore.
    Object.keys(this.__proto__, (key) ->
      if (this[key] instanceof Function)
        unless key.startsWith('_')
          scope_obj[key] = this[key]
    )
