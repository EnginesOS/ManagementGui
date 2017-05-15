module Fields
  module Elements
    module Select

      def engines_collection_field(method, opts={})
        opts[:collection] = opts[:collection] || []
        if opts[:collection].count > 5
          engines_collection_select_field(method, opts)
        else
          engines_collection_radios_field(method, opts)
        end
      end

      def engines_collection_select_field(method, opts={})
        collection_select(
          method,
          collection_for(opts[:collection]),
          :first, :last, opts.merge(({selected: opts[:value]} unless object.send(method).present?) || {}), { class: "form-control #{opts[:class]}" } )
      end

      def engines_collection_radios_field(method, opts={})
        @template.content_tag :div, class: "radios_collection #{opts[:class]}" do
          collection_radio_buttons(
            method,
            collection_for(opts[:collection]), :first, :last, ({checked: opts[:value]} unless object.send(method).present?) || {}, {} ) do |radio_button|
                @template.content_tag :div, class: 'radio' do
                  radio_button.label { radio_button.radio_button +
                                        radio_button.text }
                end
              end
        end
      end

      def collection_for(collection)
        return collection if collection.is_a? Hash
        array_or_string_to_array(collection).map { |element| array_or_string_to_array element }
      end

      def array_or_string_to_array(array_or_string)
        return array_or_string if array_or_string.is_a? Array
        JSON.parse(array_or_string.to_s)
      rescue
        JSON.parse('["' + array_or_string.to_s + '"]')
      rescue
        []
      end

    end
  end
end
