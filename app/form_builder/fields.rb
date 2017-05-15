module Fields

  include Elements
  include Image

  def engines_field_builder
    opts = {}
    opts[:attribute_name] = object.attribute_name
    opts[:label] = object.label.to_s == 'false' ? false : ( object.label.present? ? object.label : object.attribute_name.to_s )
    opts[:as] = object.read_only.to_s == 'true' ? :read_only : ( object.as.present? ? object.as : :string )
    opts[:title] = object.title.to_s == 'false' ? false : ( object.title.present? ? object.title : object.label )
    opts[:horizontal] = object.horizontal.to_s == 'true'
    opts[:compact] = object.compact.to_s == 'true'
    opts[:left] = object.left.present? ? object.left.to_i : nil
    opts[:width] = object.width.present? ? object.width.to_i : nil
    opts[:right] = object.right.present? ? object.right.to_i : nil
    opts[:collection] = object.collection || []
    opts[:tooltip] = object.tooltip
    opts[:hint] = object.hint
    opts[:placeholder] = object.placeholder
    opts[:comment] = object.comment
    opts[:validate_regex] = object.validate_regex
    opts[:validate_invalid_message] = object.validate_invalid_message
    opts[:depend_on] = { input: object.depend_on_input,
                         value: object.depend_on_value,
                         regex: object.depend_on_regex,
                         property: object.depend_on_property,
                         display: object.depend_on_display }
    engines_field(:value, opts) + field_meta_data_fields
  end

  def field_meta_data_fields
    hidden_field(:attribute_name) +
    hidden_field(:label) +
    hidden_field(:as) +
    hidden_field(:title) +
    hidden_field(:horizontal) +
    hidden_field(:compact) +
    hidden_field(:left) +
    hidden_field(:width) +
    hidden_field(:right) +
    hidden_field(:collection) +
    hidden_field(:tooltip) +
    hidden_field(:hint) +
    hidden_field(:placeholder) +
    hidden_field(:comment) +
    hidden_field(:validate_regex) +
    hidden_field(:validate_invalid_message) +
    hidden_field(:depend_on_input) +
    hidden_field(:depend_on_regex) +
    hidden_field(:depend_on_value) +
    hidden_field(:depend_on_property) +
    hidden_field(:depend_on_display) +
    hidden_field(:required) +
    hidden_field(:read_only)
  end

  def engines_field(method, opts={})
    if opts[:value_to_json]
      opts[:value] = object.send(method).to_json
    end
    title = opts[:title] || "#{object.class.name.to_s.split('::').last.underscore.humanize} - #{method.to_s.humanize}"
    horizontal = opts[:horizontal] == true
    compact = opts[:compact] == true
    label = opts[:label]
    left = opts[:left] || ( horizontal ? 2 : 0)
    right = opts[:right] || 0
    width = opts[:width] || (12 - left - right)
    total_width = left + width + right
    errors = object.errors[method]
    depend_on = opts[:depend_on]
    depend_on_data = depend_on.present? && depend_on[:input].present? ?
                      { behavior: :depend_on,
                        depend_on_input: depend_on[:input],
                        depend_on_value: depend_on[:value],
                        depend_on_regex: depend_on[:regex],
                        depend_on_property: depend_on[:property],
                        depend_on_display: depend_on[:display] } : {}
    if opts[:as] && opts[:as].to_sym == :hidden
      engines_hidden_field method, opts
    else
      @template.content_tag(:span, data: depend_on_data) do
        if horizontal
          @template.content_tag(:div, class: "col-sm-#{total_width}") do
            @template.content_tag(:div, class: "form-group form_field horizontal_form_field #{'compact_form_field' if compact} #{'has-warning' if errors.any?}") do
              engines_field_label_for(object, method, label: label, class: ( label == false ? '' : "col-sm-#{left}" ) )  +
              @template.content_tag(:div, class: "col-sm-#{width} col-sm-offset-right-#{right} #{ ( label == false ? "col-sm-offset-#{left}" : '' ) }") do
                engines_field_add_hint_and_errors_to_field(method, opts.without(:label))
              end
            end
          end
        else
          @template.content_tag(:div, class: "col-sm-#{width} col-sm-offset-#{left} col-sm-offset-right-#{right}") do
            @template.content_tag(
                :div,
                class: "form-group form_field vertical_form_field #{'compact_form_field' if compact} #{'has-warning' if errors.any?}",
                title: title) do
              engines_field_label_for(object, method, label: label) +
              engines_field_add_hint_and_errors_to_field(method, opts.without(:label))
            end
          end
        end
      end
    end
  end

  def engines_field_add_hint_and_errors_to_field(method, opts={})
    errors = object.errors[method]
    @template.content_tag(:div, opts[:comment], class: 'help-block engines_field_comment' ) +
    engines_field_selector(method, opts) +
    @template.content_tag(:div, opts[:hint], class: 'help-block engines_field_hint' ) +
    if errors
      @template.content_tag :div, class: 'help-block' do
        errors.map do |error|
          next if error.include? 'Paperclip::Errors::NotIdentifiedByImageMagickError'
          if error.is_a? Array
            error.last
          else
            error
          end
        end.join.html_safe
      end
    end
  end

  def engines_field_selector(method, opts={})
    data_type = opts[:as] || object.class.data_type_for(method)
    case data_type.to_sym
    when :boolean
      engines_checkbox_field method, opts
    when :enum
      engines_enum_field method, opts
    when :parent, :belongs_to
      engines_association_field method, opts
    when :radios
      engines_collection_radios_field method, opts
    when :select, :select_single
      engines_collection_select_field method, opts
    when :collection
      engines_collection_field method, opts
    when :image
      engines_image_field_group method, opts
    when :date, :datetime, :decimal, :float, :integer, :string, :text, :time, :color, :password, :email, :file
      engines_basic_field method, basic_field_input_type_for(data_type), opts
    when :date_field, :datetime_field, :number_field, :number_field, :number_field, :text_field, :text_area, :time_field, :color_field, :password_field, :email_field, :file_field
      engines_basic_field method, data_type, opts
    # when :color
      # color_label_field(method, opts)
    when :password_with_confirmation
      engines_password_with_confirmation_field method, opts
    when :read_only
      engines_read_only_field method, opts
    when :timezone
      engines_timezone_select_field method, opts
    when :country
      engines_country_select_field method, opts
    when :language
      engines_language_select_field method, opts
    else
      opts[:value] = "Unknown type '#{data_type}' for '#{method}'"
      engines_read_only_field method, opts
    end
  end

  private

  def basic_field_input_type_for(data_type)
    case data_type.to_sym
    when :date;             :date_field
    when :datetime;         :datetime_field
    when :decimal;          :number_field
    when :float;            :number_field
    when :integer;          :number_field
    when :string;           :text_field
    when :text;             :text_area
    when :time;             :time_field
    when :color;            :color_field
    when :password;         :password_field
    when :email;            :email_field
    when :file;             :file_field
    end
  end

end
