module Fields
  module Elements
    module Checkbox

      def engines_checkbox_field(method, opts={})
        @template.content_tag :div, class: 'checkbox' do
          @template.content_tag :label do #, for: engines_field_id_for(method)
            engines_basic_field(method, :check_box) + opts[:checkbox_text]
          end
        end
      end

    end
  end
end
