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
  $('.datepicker').datetimepicker()


setup_loadindicator = ->
  NProgress.configure({
    showSpinner: false,
    ease: 'ease',
    speed: 500
  })

setup_controls = ->
  setup_select2()
  setup_icheck()
  setup_datepicker()
  setup_loadindicator()

$(document).on "page:changed", ->
  setup_controls()


$ ->
  setup_controls()
