$('.modal').modal 'hide'
<% if remotipart_submitted? %>
$('body').append '<%= j "#{modal(render('form'), header: {text: "System properties for #{@engines_system.label}", icon: 'fa-hdd-o'})}" %>'
<% else %>
$('body').append '<%= j(modal(render('form'), header: {text: "System properties for #{@engines_system.label}", icon: 'fa-hdd-o'}) ) %>'
<% end %>
$('#remote_modal').modal(backdrop: 'static').modal 'show'
$('#remote_modal').on 'hidden.bs.modal', -> $(this).remove()
