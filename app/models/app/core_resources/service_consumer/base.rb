class App
  module CoreResources
    module ServiceConsumer
      class Base

        include ActiveModel::Model

        attr_accessor :app, :publisher_type_path, :parent_engine, :service_handle

        validate :fields_valid

        def label
          @label ||= "#{service_definition[:title]} (#{service_definition[:service_container]})"
        end

        def service_container_name
          service_definition[:service_container]
        end

        def fields
          @fields ||= form_params.map { |field| Field.new field }
        end

        def field_params_with_values
          consumer_params.map do |key, field|
            field[:value] = resolve_app_templated_value(field[:value])
            field
          end
        end

        def resolve_app_templated_value(string)
          app.core_app.resolve_string(string)
        end

        def consumer_params
          @consumer_params ||= ( service_definition[:consumer_params] || {} )
        end

        def service_definition
          @service_definition ||=
            app.engines_system.core_system.
            service_definition_for( publisher_type_path )
        end

        def field_values
          @field_values ||=
          app.core_app.non_persistent_services_for_publisher_type_path( publisher_type_path ).find do |service|
            service[:service_handle] == service_handle
          end[:variables]
        end

        def field_attributes_for(variable)
            {
              field_consumer: self,
              attribute_name: variable.dig(:name),
              value: variable.dig(:value),
              label: variable.dig(:input, :label) || variable.dig(:label),
              as: variable.dig(:input, :type) || variable_field_type_for( variable.dig(:as) || variable.dig(:field_type) ),
              title: variable.dig(:input, :title) || variable.dig(:title),
              collection: variable.dig(:input, :collection) || variable.dig(:collection) || variable.dig(:select_collection),
              tooltip: variable.dig(:input, :tooltip) || variable.dig(:tooltip),
              hint: variable.dig(:input, :hint) || variable.dig(:hint),
              placeholder: variable.dig(:input, :placeholder) || variable.dig(:placeholder),
              comment: variable.dig(:input, :comment) || variable.dig(:comment),
              validate_regex: variable.dig(:input, :validation, :pattern) || variable.dig(:validate_regex),
              validate_invalid_message: variable.dig(:input, :validation, :message) || variable.dig(:validate_invalid_message),
              required: variable.dig(:mandatory),
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

        def field_values
          field_definition[:variables] || {}
        end

        def field_definition
          @field_values ||=
          app_services.find do |service|
            service[:service_handle] == service_handle
          end || {}
        end

        def fields_valid
          fields.map(&:valid?).all?(&:present?)
        end

        def fields_attributes=(params={})
          @fields = params.map { |i, field| Field.new field.merge({field_consumer: self}) }
        end

        def variable_values
          {}.tap do |result|
            fields.each do |field|
              result[field.attribute_name.to_sym] = field.value
            end
          end
        end

      end
    end
  end
end
