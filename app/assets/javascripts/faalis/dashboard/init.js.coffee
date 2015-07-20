# Setup select2 for selects with multiple class
console.log("jquery")
console.log($)
setup_select2 = ->
  $(".multiple.select").select2()
  console.log("shirt")

$(document).on "page:load", setup_select2
$ ->
  setup_select2()
