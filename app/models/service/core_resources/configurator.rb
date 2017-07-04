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
            label: variable.dig(:input, :label) || variable.dig(:label),
            as: variable.dig(:input, :type) || variable_field_type_for( variable.dig(:as) || variable.dig(:field_type) ),
            title: variable.dig(:input, :title) || variable.dig(:title),
            collection: variable.dig(:input, :collection, :items) || variable.dig(:collection) || variable.dig(:select_collection),
            collection_include_blank: variable.dig(:input, :collection, :include_blank),
            tooltip: variable.dig(:input, :tooltip) || variable.dig(:tooltip),
            hint: variable.dig(:input, :hint) || variable.dig(:hint),
            placeholder: variable.dig(:input, :placeholder) || variable.dig(:placeholder),
            comment: variable.dig(:input, :comment) || variable.dig(:comment),
            validate_regex: variable.dig(:input, :validation, :pattern) || variable.dig(:validate_regex),
            validate_invalid_message: variable.dig(:input, :validation, :message) || variable.dig(:validate_invalid_message),
            required: variable[:mandatory],
            read_only: false
          }
      end

      def variable_field_type_for(v)
        case v.to_s.to_sym
        when :boolean
          :boolean
        when :collection, :select, :select_single
          :select
        when :int
          :integer
        when :hidden
          :hidden
        when :password
          :password
        when :password_with_confirmation
          :password_with_confirmation
        when :text, :text_area
          :text
        when :text_field
          :string
        else
          :string
        end
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
