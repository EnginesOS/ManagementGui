module Forms
  module FormHelper

    def form_for(object, opts={}, &block)
      ( super object,
        (opts.without :remote).merge({ builder: EnginesFormBuilder,
              remote: (opts[:remote].nil? ? (request.format.to_sym == :js) : opts[:remote]),
              html: (opts.without :remote).merge({ class: "#{opts[:class]} form-horizontal", :'data-type' => :script }) }),
            &add_errors(opts, &block) )
    end

    def add_errors(form_opts, &block)
      Proc.new { |f| f.errors + fake_user_credential_fields(form_opts) + capture{yield(f)} }
    end

    def fake_user_credential_fields(form_opts)
      # This is to catch browser auto-filling user credentials into forms with password fields.
      return ''.html_safe if form_opts[:user_sign_in_form]
      content_tag :div, style: 'height: 0px; overflow: hidden;' do
        # form_tag '/fake' do
          text_field_tag(nil) +
          password_field_tag(nil)
        # end
      end
    end

  end
end
