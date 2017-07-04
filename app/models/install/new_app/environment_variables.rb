class Install
  class NewApp
    class EnvironmentVariables

      include ActiveModel::Model

      attr_accessor :new_app

      def valid?
        @fields.map{ |field| field.valid? }.all?(&:present?).
        tap do |valid_result|
          unless valid_result
            errors.each do |attribute, message|
              new_app.errors.add :base, "#{message}"
            end
          end
        end
      end

      def field_params
        ( new_app.blueprint.dig(:software, :environment_variables) || [] ).
        select{ |variable| variable[:ask_at_build_time] == true }
      end

      def fields
        @fields ||= form_params.map { |field| Field.new field }
      end

      def fields_attributes=(params={})
        @fields ||= params.values.map { |field_params| field_params.merge field_consumer: self }.map { |field| Field.new field }
      end

      def form_params
        field_params.map do |variable|
          field_attributes_for(variable)
        end
      end

      def field_attributes_for(variable)
          {
            field_consumer: self,
            attribute_name: variable.dig(:name),
            value: variable.dig(:value),
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
            # depend_on_input: variable.dig(:depend_on_input),
            # depend_on_regex: variable.dig(:depend_on_regex),
            # depend_on_value: variable.dig(:depend_on_value),
            # depend_on_property: variable.dig(:depend_on_property),
            # depend_on_display: variable.dig(:depend_on_display),
            required: true, # variable.dig(:mandatory),
            read_only: false #variable.dig(:immutable) || variable.dig(:build_time_only)
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

    end
  end
end
