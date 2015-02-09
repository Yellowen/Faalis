Faalis.Factory = (controller, resource_name, options = {}) ->
  resource = resource_name
  if typeof(resource) != "object"
    resource = new Resource('resource')

  console.log("sadasda")
  dup_controller = class extends controller
  console.log("zxczxc")
  dup_controller.resource = resource
  console.log(dup_controller.resource)
  return dup_controller
