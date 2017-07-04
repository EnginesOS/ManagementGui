$('.modal').modal 'hide'
$('body').append '<%= j(modal(render('form'), header: {text: "Timezone settings for #{@engines_system.label}", icon: 'fa-clock-o'}, id: 'edit_system_timezone_modal') ) %>'
$('#edit_system_timezone_modal').modal(backdrop: 'static').modal 'show'
$('#edit_system_timezone_modal').on 'hidden.bs.modal', -> $(this).remove()
$("#edit_system_timezone_modal_flash_messages").html("<%= j(flash_messages) %>");
$("#edit_system_timezone_modal_flash_messages").hide().fadeIn();
