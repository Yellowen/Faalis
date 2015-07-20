# Setup select2 for selects with multiple class
setup_select2 = ->
  $("select.multiple.select").select2()

$(document).on "page:load", ->
  setup_select2()

$ ->
  setup_select2()
