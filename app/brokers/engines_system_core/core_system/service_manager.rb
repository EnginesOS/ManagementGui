module EnginesSystemCore
  class CoreSystem
    module ServiceManager

      def service_definition_for(type_path)
        publisher_namespace, base_type_path = type_path.split('/', 2)
        get "service_manager/service_definitions/#{publisher_namespace}/#{base_type_path}", parse: :json
      end

      def persistent_service_connections_for(type_path)
        publisher_namespace, base_type_path = type_path.split('/', 2)
        get "service_manager/persistent_services/#{publisher_namespace}/#{base_type_path}", parse: :json
      end

      def orphan_service_connections_for(type_path)
        publisher_namespace, base_type_path = type_path.split('/', 2)
        get "service_manager/orphan_services/#{publisher_namespace}/#{base_type_path}", parse: :json
      end

      def orphan_service_consumers
        get 'service_manager/orphan_services/', parse: :json
      end

      def delete_orphan_service_consumer(params)
        delete "service_manager/orphan_service/#{params[:type_path]}/#{params[:parent_engine]}/#{params[:service_handle]}", parse: :boolean
      end

    end
  end
end
