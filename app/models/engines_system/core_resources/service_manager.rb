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
      end

    end
  end
end
