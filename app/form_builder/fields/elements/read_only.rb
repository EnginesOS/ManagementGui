module Fields
  module Elements
    module ReadOnly

      def engines_read_only_field(method, opts={})
        text_field(
          method,
          value: opts[:value] || object.send(method),
          readonly: 'readonly',
          class: 'form-control' )
      end

    end
  end
end
