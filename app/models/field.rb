class Field

  include ActiveModel::Model

  validate :mandatory_validation
  validate :password_confirmation_validation
  validate :regex_validation

  def self.form_attributes
    [ :attribute_name, :as,
      :value, :value_confirmation,
      :label, :title,
      :horizontal, :compact,
      :left, :width, :right,
      :collection,
      :placeholder, :comment, :tooltip, :hint,
      :validate_regex, :validate_invalid_message,
      :depend_on_input, :depend_on_regex,
      :depend_on_value, :depend_on_property, :depend_on_display,
      :required, :read_only ]
  end

  attr_accessor :field_consumer, *form_attributes

  def valid?
    super.tap do |result|
      unless result
        errors.each do |attribute, message|
          field_consumer.errors.add :base, "#{label} #{message}"
        end
      end
    end
  end

  def regex_validation
    if (value.present? && validate_regex.present? &&
      !Regexp.new(validate_regex.to_s).match(value.to_s))
      errors.add method,
        ( validate_invalid_message ||
        "is invalid (Failed to match `#{value}` "\
        "with /#{validate_regex}/.)" )
    end
  end

  def mandatory_validation
    if required && value.blank?
      errors.add :value, "can't be blank"
    end
  end

  def password_confirmation_validation
    if as.to_sym == :password_with_confirmation &&
        value.present? && value != value_confirmation
      errors.add :value, "confirmation must match"
    end
  end

  # def value_for_system
  #   case as
  #   when :boolean
  #     value == '1'
  #   when :select
  #
  #   when :int
  #     :integer
  #   when :hidden
  #     :hidden
  #   when :password
  #     :password
  #   when :password_with_confirmation
  #     :password_with_confirmation
  #   when :text, :text_area
  #     :text
  #   when :text_field
  #     :string
  #   else
  #     :string
  #   end
  # end

end
