module Fields
  module Elements
    module Id

      def engines_field_id_for(method)
        [ object.class.name.underscore,
          method ].
          join('_').html_safe
      end

    end
  end
end
