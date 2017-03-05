class App
  module CoreResources
    class EnvironmentGroup

      include ActiveModel::Model

      attr_accessor :app, :owner_type, :owner_path, :exception

      validate :fields_valid

      def to_label
        group_type.to_label
      end

      # def variable_params
      #   group_type.variable_params
      # end

      # def field_params
      #   group_type.field_params
      # end

      def field_params_with_values
        group_type.field_params_with_values
      end

      def group_type
        @group_type ||=
        if owner_type == 'application'
          EnvironmentGroup::Application.new(group: self)
        else
          EnvironmentGroup::ServiceConsumer.new(group: self, type_path: owner_path)
        end
      end

      def grouped_field_params_with_values
        @grouped_field_params_with_values ||=
        { immutable: field_params_with_values.select { |variable| variable[:immutable] == true },
          mutable: field_params_with_values.select { |variable| variable[:immutable] != true } }
      end

      def form_params
        grouped_field_params_with_values[:mutable].map do |variable|
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

      def fields
        @fields ||= form_params.map { |field| Field.new field }
        # @fields ||= {}.tap{|result| form_params.each_with_index { |field, index| result[index] = Field.new field } }
      end

      def persisted?
        true
      end

      def fields_attributes=(params={})
        @fields = params.map { |i, field| Field.new field.merge({field_consumer: self}) }
      end

      def fields_valid
        @fields.map(&:valid?).all?(&:present?)
      end

      def save_to_system
         app.core_app.set_runtime_properties(environment_variables: environment_variable_update_values)
       rescue => e
         @exception = e
         return false if e.is_a? EnginesError
      end

      def environment_variable_update_values
        {}.tap do |result|
          @fields.each do |field|
            result[field.attribute_name.to_sym] = field.value
          end
        end
      end


    end
  end
end
