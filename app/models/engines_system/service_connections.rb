class EnginesSystem
  module ServiceConnections

    def persistent_service_connections_for(type_path)
      # begin
        result = core_system.persistent_service_connections_for(type_path)
      # rescue => e
      #   Rails.logger.warn "Failed to get '#{publisher_namespace}/#{type_path} persistent services' from Engines System API. #{e}"
      #   raise
      # end
    end

    def orphan_service_connections_for(type_path)
      # begin
        core_system.orphan_service_connections_for(type_path)
      # rescue => e
      #   Rails.logger.warn "Failed to get '#{publisher_namespace}/#{type_path} orphan services' from Engines System API. #{e}"
      #   raise
      # end
    end

    def service_definition_for(type_path)
      # begin
        core_system.service_definition_for(type_path)
      # rescue => e
      #   Rails.logger.warn "Failed to get '#{publisher_namespace}/#{type_path} service definition' from Engines System API. #{e}"
      #   raise
      # end
    end


  end
end
