bind_depend_on_form_field_events = ->
  $('input, textarea, select').each ->
    $(this).change ->
      check_depend_on_form_fields()
  return

check_depend_on_form_fields = ->
  $('[data-behavior~=depend_on]').each ->
    dependent_field = this
    dependor_input = $('#' + $(dependent_field).data('depend-on-input'))
    check_dependent_field_visibility dependent_field, dependor_input
  return

check_dependent_field_visibility = (dependent_field, dependor_input) ->
  if  ( $(dependent_field).data('depend-on-property') == 'checked' and $(dependor_input).prop('checked') ) or
      ( $(dependent_field).data('depend-on-value') == $(dependor_input).val() )
    if $(dependent_field).data('depend-on-display') == 'hide'
      $(dependent_field).hide()
    else
      $(dependent_field).show()
  else
    if $(dependent_field).data('depend-on-display') == 'hide'
      $(dependent_field).show()
    else
      $(dependent_field).hide()
  return

process_depend_on = ->
  bind_depend_on_form_field_events()
  check_depend_on_form_fields()
  return

$(document).ready -> process_depend_on()
$(document).on 'turbolinks:load', -> process_depend_on()
$(document).ajaxComplete -> process_depend_on()
