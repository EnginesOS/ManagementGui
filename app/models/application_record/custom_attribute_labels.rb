class ApplicationRecord
  module CustomAttributeLabels

    def human_attribute_name(attribute_key_name, options = {})
      if @custom_attribute_labels.present? && @custom_attribute_labels[attribute_key_name.to_sym].present?
        @custom_attribute_labels[attribute_key_name.to_sym]
      else
        super
      end
    end

    def custom_attribute_labels(labels)
      @custom_attribute_labels = labels
    end

  end
end
