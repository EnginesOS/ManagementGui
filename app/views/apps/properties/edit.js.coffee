$('.modal').modal 'hide'
$('body').append '<%= j(modal(render("form"), header: {text: "Properties for #{@app.name}", icon: "fa-tv"}, id: "remote_modal") ) %>'
$("#remote_modal").modal(backdrop: 'static').modal 'show'
$("#remote_modal").on 'hidden.bs.modal', -> $(this).remove()
