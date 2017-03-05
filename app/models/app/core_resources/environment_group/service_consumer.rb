class App
  module CoreResources
    class EnvironmentGroup
      class ServiceConsumer

        include ActiveModel::Model

        attr_accessor :group, :type_path

        def to_label
          "#{service_definition[:title]} environment variables for #{group.app.name}"
        end

        def service_definition
          @service_definition ||=
          group.app.engines_system.core_system.service_definition_for(type_path)
        end

        def field_params
          service_definition[:consumer_params]
        end

        def variable_params
          @variable_params ||=
          group.app.environment_variables[:service_consumers][type_path]
        end

        def field_params_with_values
          variable_params.map do |variable|
            field = field_params[variable[:owner_path].split(':').second.to_sym]
            if field
              field[:value] = variable[:value]
            else
              field = { label: variable[:name].humanize, value: variable[:value], immutable: true }
            end
            field
          end
        end

      end
    end
  end
end
