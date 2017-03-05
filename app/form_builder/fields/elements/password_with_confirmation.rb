module Fields
  module Elements
    module PasswordWithConfirmation

      def engines_password_with_confirmation_field(method, opts={})
        opts = opts.merge({ class: "#{opts[:class]} form-control" })
        conformation_opts = opts.merge({ class: "#{opts[:class]} password_confirmation", placeholder: 'Confirm password' })
        send(:password_field, method, opts.slice(:class, :title, :tooltip, :placeholder, :autocomplete)) +
        send(:password_field, "#{method}_confirmation", conformation_opts.slice(:class, :title, :tooltip, :placeholder, :autocomplete))
      end

    end
  end
end
