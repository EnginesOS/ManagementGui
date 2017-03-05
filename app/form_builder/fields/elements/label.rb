module Fields
  module Elements
    module Label

      def engines_field_label_for(object, attribute_name, opts={})
        return ''.html_safe if opts[:label] == false
        label_text = opts[:label] || engines_field_name_from_class(object, attribute_name)
        @template.content_tag :label, label_text,
              # for: engines_field_id_for(attribute_name),
              class: [ 'control-label', opts[:class] ].join(' ')
      end

      def engines_field_name_from_class(object, attribute_name)
        object.class.human_attribute_name(attribute_name)
      end

    end
  end
end
