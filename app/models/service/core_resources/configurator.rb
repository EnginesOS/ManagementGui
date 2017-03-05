class Service
  module CoreResources
    class Configurator

      include ActiveModel::Model

      attr_accessor :service, :configurator_name, :exception

      def to_label
        configurator_params[:label] || configurator_name.to_s.humanize
      end


      def fields_attributes=(params={})
        @fields = params.map { |i, field| Field.new field.merge({field_consumer: self}) }
      end

      def configurator_params
        service.configurators[configurator_name.to_sym]
      end

      def configuration_params
        service.configurations.find{|configuration| configuration[:configurator_name] == configurator_name}
      end


      def field_values
        @field_values ||=
        configuration_params[:variables]
      end

      def field_params
        @field_params ||=
        service.service_definition[:configurators][configurator_name.to_sym][:params].values
      end

      def field_params_with_values
        @field_params_with_values ||=
        field_params.map do |field|
          field[:value] = field_values[field[:name].to_sym]
          field
        end
      end

      #
      # def to_label
      #   service.label
      # end
      #
      # def consumer_params
      #   @consumer_params ||= service.service_definition[:consumer_params]
      # end
      #
      # def field_values
      #   @field_values ||=
      #   app.persistent_services.find do |service|
      #     service[:service_container_name] == service_container_name && service[:parent_engine] == parent_engine
      #   end[:variables]
      # end
      #

      #
      # def grouped_field_params_with_values
      #   @grouped_field_params_with_values ||=
      #   { immutable: field_params_with_values.select { |field| field[:immutable] == true },
      #     mutable: field_params_with_values.select { |field| field[:immutable] != true } }
      # end
      #
      def form_params
        field_params_with_values.map do |variable|
          field_attributes_for(variable)
        end
      end
      #
      def field_attributes_for(variable)
          {
            field_consumer: self,
            attribute_name: variable[:name],
            value: variable[:value],
            label: variable[:label],
            as: variable[:as] || variable[:field_type],
            title: variable[:title],
            collection: variable[:collection] || variable[:select_collection],
            tooltip: variable[:tooltip],
            hint: variable[:hint],
            placeholder: variable[:placeholder],
            comment: variable[:comment],
            validate_regex: variable[:validate_regex],
            validate_invalid_message: variable[:validate_invalid_message],
            # depend_on_input: variable[:depend_on_input],
            # depend_on_regex: variable[:depend_on_regex],
            # depend_on_value: variable[:depend_on_value],
            # depend_on_property: variable[:depend_on_property],
            # depend_on_display: variable[:depend_on_display],
            required: variable[:mandatory],
            read_only: false # variable[:immutable] || variable[:build_time_only]
          }
      end
      #
      def fields
        @fields ||= form_params.map { |field| Field.new field }
      end
      #
      # def persisted?
      #   true
      # end
      #
      def fields_valid
        @fields.map(&:valid?).all?(&:present?)
      end

      def valid?
        [ super, fields_valid ].all?(&:present?)
      end
      #
      # def fields_attributes=(params={})
      #   @fields = params.map { |i, field| Field.new field.merge({field_consumer: self}) }
      # end
      #
      def save_to_system
         service.core_service.update_configuration(configurator_name, { variables: configuration_params_update_values })
      #  rescue => e
      #    @exception = e
      #    return false if e.is_a? EnginesError

      end
      #
      def configuration_params_update_values
        {}.tap do |result|
          @fields.each do |field|
            result[field.attribute_name.to_sym] = field.value
          end
        end
      end


      # def variable_params
      #   group_type.variable_params
      # end
      #
      # def field_params
      #   group_type.field_params
      # end
      #
      # def field_params_with_values
      #   group_type.field_params_with_values
      # end
      #
      # def group_type
      #   @group_type ||=
      #   if owner_type == 'application'
      #     Application.new(group: self)
      #   else
      #     ServiceConsumer.new(group: self, type_path: owner_path)
      #   end
      # end
      #
      # def grouped_field_params_with_values
      #   @grouped_field_params_with_values ||=
      #   { immutable: field_params_with_values.select { |variable| variable[:immutable] == true },
      #     mutable: field_params_with_values.select { |variable| variable[:immutable] != true } }
      # end
      #
      # def form_params
      #   grouped_field_params_with_values[:mutable].map do |variable|
      #     field_attributes_for(variable)
      #   end
      # end
      #
      # def field_attributes_for(variable)
      #     {
      #       field_consumer: self,
      #       attribute_name: variable[:name],
      #       value: variable[:value],
      #       label: variable[:label],
      #       as: variable[:as] || variable[:field_type],
      #       title: variable[:title],
      #       collection: variable[:collection] || variable[:select_collection],
      #       tooltip: variable[:tooltip],
      #       hint: variable[:hint],
      #       placeholder: variable[:placeholder],
      #       comment: variable[:comment],
      #       validate_regex: variable[:validate_regex],
      #       validate_invalid_message: variable[:validate_invalid_message],
      #       depend_on_input: variable[:depend_on_input],
      #       depend_on_regex: variable[:depend_on_regex],
      #       depend_on_value: variable[:depend_on_value],
      #       depend_on_property: variable[:depend_on_property],
      #       depend_on_display: variable[:depend_on_display],
      #       required: variable[:mandatory],
      #       read_only: variable[:immutable] || variable[:build_time_only]
      #     }
      # end
      #
      # def fields
      #   @fields ||= form_params.map { |field| Field.new field }
      #   # @fields ||= {}.tap{|result| form_params.each_with_index { |field, index| result[index] = Field.new field } }
      # end
      #
      # def persisted?
      #   true
      # end
      #
      #
      # def fields_valid
      #   @fields.map(&:valid?).all?(&:present?)
      # end
      #
      # def valid?
      #   [ super, fields_valid ].all?(&:present?)
      # end
      #
      # def save_to_system
      #    app.core_app.set_runtime_properties(environment_variables: environment_variable_update_values)
      #  rescue => e
      #    @exception = e
      #    return false if e.is_a? EnginesError
      # end
      #
      # def environment_variable_update_values
      #   {}.tap do |result|
      #     @fields.each do |field|
      #       result[field.attribute_name.to_sym] = field.value
      #     end
      #   end
      # end



    end
  end
end
