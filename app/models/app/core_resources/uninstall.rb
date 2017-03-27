class App
  module CoreResources
    class Uninstall

      include ActiveModel::Model

      attr_accessor :app, :remove_data

      def remove_data
        @remove_data.nil? || @remove_data == true || @remove_data == '1'
      end

      def uninstall
        @app.core_app.uninstall(remove_data: remove_data)
      end

    end
  end
end
