module EnginesSystemCore
  class CoreSystem
    module ServiceManager

      def service_definition_for(publisher_type_path)
        get "service_manager/service_definitions/#{publisher_type_path}", expect: :json
      end

      def persistent_service_connections_for(publisher_type_path)
        get "service_manager/persistent_services/#{publisher_type_path}", expect: :json
      end

      def orphan_service_connections_for(publisher_type_path)
        get "service_manager/orphan_services/#{publisher_type_path}", expect: :json
      end

      def orphan_service_consumers
        get 'service_manager/orphan_services/', expect: :json
      end

      def delete_orphan_service_consumer(params)
        delete "service_manager/orphan_service/#{params[:type_path]}/#{params[:parent_engine]}/#{params[:service_handle]}", expect: :boolean
      end

    end
  end
end
