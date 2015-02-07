Faalis.Controller = (controller_name) ->
  var controller = controller_name.camelize() + "Controller"
  return Faalis[controller]
