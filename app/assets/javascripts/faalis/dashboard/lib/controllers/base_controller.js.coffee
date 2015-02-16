class Faalis.BaseController
  constructor: (scope_obj)->

    Object.keys(this.__proto__, (key) ->
      if (this[key] instanceof Function)
        if key.startsWith('_')
          scope_obj[key] = this[key]
    )
