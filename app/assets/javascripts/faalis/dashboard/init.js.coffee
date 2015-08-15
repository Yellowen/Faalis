# Setup select2 for selects with multiple class
setup_select2 = ->
  $("select.multiple.select").select2()

setup_icheck = ->
  $('input').iCheck {
    labelHover: false,
    checkboxClass: 'icheckbox_flat',
    cursor: true }

setup_datepicker = ->
  $('.datetimepicker').datetimepicker()

setup_controls = ->
  setup_select2()
  setup_icheck()
  setup_datepicker()

$(document).on "page:load", ->
  setup_controls()


$ ->
  setup_controls()
