$('.modal').modal 'hide'
<% modal_html = modal(
    render('form'),
    header: {text: 'Cloud properties', icon: 'fa-cloud'}) %>
$('body').append '<%= j modal_html %>'
$('#remote_modal').modal(backdrop: 'static').modal 'show'
$('#remote_modal').on 'hidden.bs.modal', -> $(this).remove()
