var bind_depend_on_form_field_events, check_depend_on_form_fields, check_dependent_field_visibility, process_depend_on;

bind_depend_on_form_field_events = function() {
  $('input, textarea, select').each(function() {
    return $(this).change(function() {
      return check_depend_on_form_fields();
    });
  });
};

check_depend_on_form_fields = function() {
  $('[data-behavior~=depend_on]').each(function() {
    var dependent_field, dependor_input;
    dependent_field = this;
    dependor_input = $('#' + $(dependent_field).data('depend-on-input'));
    return check_dependent_field_visibility(dependent_field, dependor_input);
  });
};

check_dependent_field_visibility = function(dependent_field, dependor_input) {
  if (($(dependent_field).data('depend-on-property') === 'checked' && $(dependor_input).prop('checked')) || ($(dependent_field).data('depend-on-value') === $(dependor_input).val())) {
    if ($(dependent_field).data('depend-on-display') === 'hide') {
      $(dependent_field).hide();
    } else {
      $(dependent_field).show();
    }
  } else {
    if ($(dependent_field).data('depend-on-display') === 'hide') {
      $(dependent_field).show();
    } else {
      $(dependent_field).hide();
    }
  }
};

process_depend_on = function() {
  bind_depend_on_form_field_events();
  check_depend_on_form_fields();
};

$(document).ready(function() {
  return process_depend_on();
});

$(document).on('turbolinks:load', function() {
  return process_depend_on();
});

$(document).ajaxComplete(function() {
  return process_depend_on();
});
