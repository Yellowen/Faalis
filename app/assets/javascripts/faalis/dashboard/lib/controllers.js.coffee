Faalis.Controller = (controller_name) ->
  controller = controller_name.camelize() + "Controller"
  return Faalis[controller]
