$(".modal").modal('hide');
remote_get("<%= new_install_repository_path engines_system_id: @engines_system.id, repository_url: @side_load.repository_url, install_metadata: @side_load.install_metadata %>", true);
