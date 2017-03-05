$('.modal').modal 'hide'
$('body').append '<%= j(modal(render('form'), header: {text: "Bug report settings for #{@engines_system.label}", icon: 'fa-bug'}, id: 'edit_system_bug_reports_modal') ) %>'
$('#edit_system_bug_reports_modal').modal(backdrop: 'static').modal 'show'
$('#edit_system_bug_reports_modal').on 'hidden.bs.modal', -> $(this).remove()
