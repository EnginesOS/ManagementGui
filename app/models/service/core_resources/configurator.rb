class Service
  module CoreResources
    class Configurator

      include ActiveModel::Model

      attr_accessor :service, :configurator_name

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

      def form_params
        field_params_with_values.map do |variable|
          field_attributes_for(variable)
        end
      end

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
            required: variable[:mandatory],
            read_only: false
          }
      end

      def fields
        @fields ||= form_params.map { |field| Field.new field }
      end

      def fields_valid
        @fields.map(&:valid?).all?(&:present?)
      end

      def valid?
        [ super, fields_valid ].all?(&:present?)
      end

      def save_to_system
         service.core_service.update_configuration(configurator_name, { variables: configuration_params_update_values })
      end

      def configuration_params_update_values
        {}.tap do |result|
          @fields.each do |field|
            result[field.attribute_name.to_sym] = field.value_for_system
          end
        end
      end

    end
  end
end
