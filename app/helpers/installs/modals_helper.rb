module Installs
  module ModalsHelper

    def install_libraries_menu_modal(engines_system)
      modal(header: {text: 'Install', icon: 'fa-plus'},
        footer_close: true) do
          up_to_system_menu_link(engines_system) +
          section_header('Select library') +
          engines_system.cloud.libraries.map do |library|
            resource_link :install_library, text: library.to_s,
              title: "Install from #{library.to_s}",
              params: { engines_system_id: engines_system.id, library_id: library.id },
              remote: true
          end.join.html_safe
      end
    end

  end
end
