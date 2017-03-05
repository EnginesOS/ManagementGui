$('.modal').modal 'hide'
$('body').append '<%= j(render "installs/libraries/show") %>'
$('#remote_modal').modal 'show'
$('#remote_modal').on 'hidden.bs.modal', -> $(this).remove()
$('#remote_modal_flash_messages').html('<%= j(flash_messages) %>');
$('#remote_modal_flash_messages').hide().fadeIn();

# Live text search/filtering for library
install_libarary_apps = new List('install_libarary_apps', valueNames: [ 'list_search' ])
$('#install_libarary_apps input.search').focus()
