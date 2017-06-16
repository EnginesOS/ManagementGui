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
          content_for_descendants_of core_system.orphan_service_consumers
      end

      def delete_orphan_service_consumer(params)
        core_system.delete_orphan_service_consumer(params)
      end

      def content_for_descendants_of(node)
        if node[:children].any?
          [].tap do |result|
            node[:children].each do |child_node|
              result << content_for_descendants_of(child_node)
            end
          end.flatten
        else
          node[:content]
        end
      end

    end
  end
end
