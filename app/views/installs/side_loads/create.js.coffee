$(".modal").modal('hide');
# show_wait_for_system_response_spinner();
remote_get("<%= new_install_repository_path engines_system_id: @engines_system.id, repository_url: @side_load.repository_url, install_metadata: @side_load.install_metadata %>");
