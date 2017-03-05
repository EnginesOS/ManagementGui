class EnginesSystem
  module CoreResources
    class ServiceManager

      require 'yajl'

      include ActiveModel::Model

      attr_accessor :engines_system

      def core_system
        engines_system.core_system
      end

      def orphan_service_consumers
        @orphan_services ||=
          core_system.orphan_service_consumers[:children].
          map{|child| child[:children]}.flatten.
          map{|child| child[:children]}.flatten.
          map{|child| child[:children]}.flatten.
          map{|child| child[:children]}.flatten.
          map{|child| child[:children]}.flatten.
          map{|child| child[:content]}
      end


      def delete_orphan_service_consumer(params)
        core_system.delete_orphan_service_consumer(params)


        # type_path: params[:type_path], parent_engine: params[:parent_engine], params[:service_handle])
        #     end
        #
        #     def delete_orphan_service_consumer(params)
        #       delete "service_manager/orphan_service/#{params[:type_path]}/#{params[:parent_engine]}/#{params[:service_handle]}", parse: :boolean

      end





      # def tree
      #   @tree ||= {name: "Service manager", content: nil, children: nodes}
      # end
      #
      # def nodes
      #   [].tap do |tree|
      #     tree << {name: "Orphan data", content: core_system.orphan_services }
      #     tree << core_system.registry_apps
      #     tree << core_system.registry_services
      #     tree << core_system.registry_orphans
      #     tree << core_system.registry_shares
      #   end
      # end

    end
  end
end
