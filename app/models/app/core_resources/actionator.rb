class App
  module CoreResources
    class Actionator

      include ActiveModel::Model

      attr_accessor :app, :actionator_name, :api_post_result

      validate :fields_valid

      def to_label
        actionator_params[:label]
      end

      def actionator_params
        app.actionator_for(actionator_name)
      end

      def field_params
        actionator_params[:variables] || []
      end

      def field_params_with_values
        field_params # this is here in case need to template values
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
            collection: variable.dig(:input, :collection) || variable.dig(:collection) || variable.dig(:select_collection),
            tooltip: variable.dig(:input, :tooltip) || variable.dig(:tooltip),
            hint: variable.dig(:input, :hint) || variable.dig(:hint),
            placeholder: variable.dig(:input, :placeholder) || variable.dig(:placeholder),
            comment: variable.dig(:input, :comment) || variable.dig(:comment),
            validate_regex: variable.dig(:input, :validation, :pattern) || variable.dig(:validate_regex),
            validate_invalid_message: variable.dig(:input, :validation, :message) || variable.dig(:validate_invalid_message),
            # depend_on_input: variable[:depend_on_input],
            # depend_on_regex: variable[:depend_on_regex],
            # depend_on_value: variable[:depend_on_value],
            # depend_on_property: variable[:depend_on_property],
            # depend_on_display: variable[:depend_on_display],
            required: variable[:mandatory],
            read_only: false # variable[:immutable] || variable[:build_time_only]
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

      def persisted?
        true
      end

      def fields_attributes=(params={})
        @fields = params.map { |i, field| Field.new field.merge({field_consumer: self}) }
      end

      def fields_valid
        return true unless @fields
        @fields.map(&:valid?).all?(&:present?)
      end

      def save_to_system
        @api_post_result = app.core_app.perform_actionator_for(actionator_name, perform_actionator_params, return_type)
      end

      def return_type
        @return_type ||= return_type_for actionator_params[:return_type]
      end

      def return_type_for(raw_return_type)
        # mutate return types that have been incorrectly specified
        case raw_return_type
        when 'text/plain'; 'plain_text'
        else; raw_return_type
        end
      end

      def perform_actionator_params
        {}.tap do |result|
          @fields.each do |field|
            result[field.attribute_name.to_sym] = field.value_for_system
          end if @fields
        end
      end


    end
  end
end
