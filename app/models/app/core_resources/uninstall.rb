class App
  module CoreResources
    class Uninstall

      include ActiveModel::Model

      attr_accessor :app, :remove_data, :exception

      def remove_data
        @remove_data == true || @remove_data == '1'
      end

      def uninstall
        app.core_app.uninstall(remove_data: remove_data)
      rescue => e
        @exception = e
        return false if e.is_a? EnginesSystemApiResourceNotFoundError
      end

      # def core_app
      #   @core_app ||= EnginesSystemCore::CoreApp.new(engines_system, app)
      # end


    end
  end
end
