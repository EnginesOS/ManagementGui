class EnginesSystem
  module ServiceConnections

    def persistent_service_connections_for(type_path)
      core_system.persistent_service_connections_for(type_path)
    end

    def orphan_service_connections_for(type_path)
      core_system.orphan_service_connections_for(type_path)
    end

    def service_definition_for(type_path)
      core_system.service_definition_for(type_path)
    end

  end
end
