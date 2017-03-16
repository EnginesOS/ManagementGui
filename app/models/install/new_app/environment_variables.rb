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
        
        ( new_app.blueprint[:software][:environment_variables] || [] ).
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
            read_only: false #variable[:immutable] || variable[:build_time_only]
          }
      end

    end
  end
end
