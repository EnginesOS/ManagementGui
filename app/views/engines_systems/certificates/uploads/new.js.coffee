$('.modal').modal 'hide'
<% if remotipart_submitted? %>
$('body').append '<%= j "#{(render 'new')}" %>'
<% else %>
$('body').append '<%= j (render 'new') %>'
<% end %>
$('#remote_modal').modal(backdrop: 'static').modal 'show'
$('#remote_modal').on 'hidden.bs.modal', -> $(this).remove()
$("#remote_modal_flash_messages").html("<%= j(flash_messages) %>");
$("#remote_modal_flash_messages").hide().fadeIn();
