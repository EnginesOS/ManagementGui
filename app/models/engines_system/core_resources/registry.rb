class EnginesSystem
  module CoreResources
    class Registry

      require 'yajl'

      include ActiveModel::Model

      attr_accessor :engines_system

      def core_system
        @core_system ||= engines_system.core_system
      end

      def tree
        @tree ||= {name: "Registry", content: "Engines system registry", children: nodes}
      end

      def nodes
        [].tap do |tree|
          tree << core_system.registry_configurations
          tree << core_system.registry_apps
          tree << core_system.registry_services
          tree << core_system.registry_orphans
          tree << core_system.registry_shares
        end
      end

    end
  end
end
