# Patching the jquery UJS to add a class to disabled
# element
$.rails.disableElement = (element) ->
  replacement = element.data('disable-with')
  classes     = element.data('disable-class')

  element.data('ujs:enable-with', element.html())
  if replacement != undefined
    element.html(replacement)

  if classes != undefined
    element.addClass(classes);

  element.bind 'click.railsDisable', (e) ->
    return rails.stopEverything(e)


$.rails.enableElement = (element) ->
  classes = element.data('disable-class');

  if element.data('ujs:enable-with') != undefined
    element.html(element.data('ujs:enable-with'))
    element.removeData('ujs:enable-with')

  if classes != undefined
    element.removeClass(classes);

  element.unbind('click.railsDisable')
