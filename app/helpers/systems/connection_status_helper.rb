module Systems
  module ConnectionStatusHelper

    def system_connection_status(engines_system, opts)
      connected = opts[:connected]
      content_tag(:span,
        class: "system_api_connection_status #{connected ? 'engines_system_api_connected' : ''}",
        id: "system_#{engines_system.id}_api_connection_status") do
        icon 'fa-hdd-o'
      end
    end

  end
end
