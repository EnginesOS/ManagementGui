class App
  module CoreResources
    class Actionator

      include ActiveModel::Model

      attr_accessor :app, :actionator_name, :api_post_result, :exception

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
            label: variable[:input][:label],
            as: variable[:input][:type],
            title: variable[:input][:title],
            collection: variable[:input][:collection],
            tooltip: variable[:input][:tooltip],
            hint: variable[:input][:hint],
            placeholder: variable[:input][:placeholder],
            comment: variable[:input][:comment],
            validate_regex: variable[:input][:validation][:pattern],
            validate_invalid_message: variable[:input][:validation][:message],
            # depend_on_input: variable[:depend_on_input],
            # depend_on_regex: variable[:depend_on_regex],
            # depend_on_value: variable[:depend_on_value],
            # depend_on_property: variable[:depend_on_property],
            # depend_on_display: variable[:depend_on_display],
            required: variable[:mandatory],
            read_only: false # variable[:immutable] || variable[:build_time_only]
          }
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
        return true unless @fields
        @fields.map(&:valid?).all?(&:present?)
      end

      def save_to_system
         @api_post_result = app.core_app.perform_actionator_for(actionator_name, perform_actionator_params)
      #  rescue => e
      #    @exception = e
      #    return false if e.is_a? EnginesError
      # true
      end

      def return_type
        @return_type ||= actionator_params[:return_type]
      end

      def perform_actionator_params
        {}.tap do |result|
          @fields.each do |field|
            result[field.attribute_name.to_sym] = field.value
          end if @fields
        end
      end


    end
  end
end
