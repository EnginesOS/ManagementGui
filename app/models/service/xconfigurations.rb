class Service
  class Configurations

    include ActiveModel::Model

    attr_accessor :service_name

    def service_configurations_hash
      @service_configurations_hash ||= service.core_service.configurations
    end

    def service
      @service ||= Service.new(name: service_name)
    end



    # def valid?
    #   service.environment_variables.map(&:field).map do |field|
    #     if field.valid?
    #       true
    #     else
    #       field.errors.messages[:value].tap do |error_message|
    #         service.errors.add :base, error_message
    #       end
    #       false
    #     end
    #   end.all?
    # end
    #
    # def save_to_system
    #   
    #    #service.core_service.set_runtime_properties(environment_variables: environment_variable_update_values)
    # end
    #
    # def environment_variable_update_values
    #   {}.tap do |result|
    #     service.environment_variables.each do |environment_variable|
    #       result[environment_variable.field.attribute_name.to_sym] =
    #           environment_variable.field.value
    #     end
    #   end
    # end
    #
    # def setup_environment_variables
    #   service.environment_variables.build(runtime_environment_variables)
    # end
    #
    # def runtime_environment_variable_values
    #   @runtime_environment_variable_values ||=
    #     {}.tap do |result|
    #       service.service_container[:environments].each do |environment_variable|
    #         result[environment_variable[:name]] = environment_variable[:value]
    #       end
    #     end
    # end
    #
    # def runtime_environment_variables
    #   container_environment_variables.map do |env|
    #     blueprint_env = blueprint_environment_variables[env[:name]]
    #     env.merge blueprint_env if blueprint_env.present?
    #     env
    #   end
    # end
    #
    # def container_environment_variables
    #   @runtime_environment_variables ||=
    #     service.service_container[:environments].map do |env|
    #       { ask_at_build_time: env[:ask_at_build_time],
    #         build_time_only: env[:build_time_only],
    #         field_attributes: {
    #           attribute_name: env[:name],
    #           value: env[:value],
    #           label: env[:label],
    #           compact: true,
    #           required: env[:mandatory],
    #           read_only: env[:immutable] } }
    #     end
    # end
    #
    # def blueprint_environment_variables
    #   @blueprint_environment_variables ||=
    #   {}.tap do |result|
    #     service.blueprint[:variables].each do |env|
    #       result[env[:name]] = {
    #         ask_at_build_time: env[:ask_at_build_time],
    #         build_time_only: env[:build_time_only],
    #         field_attributes: {
    #           label: env[:label],
    #           as: env[:as] || env[:field_type],
    #           title: env[:title],
    #           collection: env[:collection] || env[:select_collection],
    #           tooltip: env[:tooltip],
    #           hint: env[:hint],
    #           placeholder: env[:placeholder],
    #           comment: env[:comment],
    #           validate_regex: env[:validate_regex],
    #           validate_invalid_message: env[:validate_invalid_message],
    #           depend_on_input: env[:depend_on_input],
    #           depend_on_regex: env[:depend_on_regex],
    #           depend_on_value: env[:depend_on_value],
    #           depend_on_property: env[:depend_on_property],
    #           depend_on_display: env[:depend_on_display],
    #           required: env[:mandatory],
    #           read_only: env[:immutable] || env[:build_time_only]
    #         }
    #       }
    #     end
    #   end
    # end

  end
end
