module Fields
  module Image

    def engines_image_field_group(method, opts)
      if object.send(method).present? && object.errors[method].empty?
        # @template.image_tag(object.icon.url(opts[:size] || :medium)) +
        @template.content_tag(:div) do
          engines_basic_field(method, :file_field) +
          engines_checkbox_field("#{method}_clear", checkbox_text: "Clear #{method}")
        end
      else
        engines_basic_field(method, :file_field)
      end
    end

  end
end
