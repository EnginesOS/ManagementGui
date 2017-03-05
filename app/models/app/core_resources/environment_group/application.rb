class App
  module CoreResources
    class EnvironmentGroup
      class Application

        include ActiveModel::Model

        attr_accessor :group

        def to_label
          "Application environment variables for #{group.app.name}"
        end

        def variable_params
          group.app.environment_variables[:application] || []
        end

        def field_params
          group.app.blueprint[:software][:environment_variables] || []
        end

        def field_params_with_values
          variable_params.map do |variable|
            ( field_params.find{|field| field[:name] == variable[:name]} || { name: variable[:name] } ).tap { |field| field[:value] = variable[:value] }
          end
        end

      end
    end
  end
end
