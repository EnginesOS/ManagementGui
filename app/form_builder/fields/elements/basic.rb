module Fields
  module Elements
    module Basic

      def engines_basic_field(method, type=:text_field, opts={})
        opts = { class: 'form-control' }.merge(opts) unless type == :check_box
        send type, method, opts.slice(:class, :title, :tooltip, :placeholder, :autocomplete, :required) #, :id)
      end

    end
  end
end
