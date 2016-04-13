window.__amd_table__ = {}
window.modules       = {}

# Guess the js module to load from the action name
window.guess_module = ->
  action_module = $("body").data('action');
  require action_module

# Lookup the module path
window.to_module_path = (dep) ->
  path = dep #window.__amd_table__[dep]

  if path == undefined
    console.warn "Can't find url of '" + dep + "' module in amd table."
    return undefined

  return path


# Fetch the js module
window.fetch_js = (url, callback) ->
  console.log("Fetching ", url)
  # Adding the script tag to the head as suggested before
  body        = document.getElementsByTagName('body')[0]
  script      = document.createElement 'script'
  script.type = 'text/javascript'
  script.src  = "<%= Faalis::Engine.amd_dir %>" + url

  # Then bind the event to the callback function.
  # There are several events for cross browser compatibility.
  script.onreadystatechange = callback
  script.onload             = callback

  # Fire the loading
  body.appendChild script


window.define = (name, deps, fn) ->
  console.group('Define ' + name)

  modules_to_inject = []
  window.modules[name] = {
    name: name,
    deps: deps,
    fn: fn
  }

  console.log('Dependencies: ', deps)

  deps.each (dep) ->
    m = window.modules[dep]

    if m == undefined
      m = require(dep)

    modules_to_inject.push m if m != undefined
    # end each

  console.groupEnd('Define ' + name);
  fn.apply(fn, modules_to_inject)

window.require = (module_name) ->
  path = to_module_path(module_name)

  if path != undefined
    m = fetch_js path, ->
      console.log('Module "' + module_name +"' loaded")

    return m
  return undefined
