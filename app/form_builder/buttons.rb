module Buttons

  def engines_submit(opts={})
    @template.content_tag(:div, class: 'col-sm-12') do
      @template.content_tag(:div, class: 'form-group form_buttons_group') do
        @template.form_submit_link opts
      end
    end
  end

  def engines_cancel_submit(cancel_opts={}, submit_opts={})
    @template.content_tag(:div, class: 'col-sm-12') do
      @template.content_tag(:div, class: 'form-group form_buttons_group') do
        @template.form_submit_link({ class: 'btn btn-primary pull-right' }.merge submit_opts) +
        @template.form_cancel_link(cancel_opts)
      end
    end
  end

  # protected
  #
  # def default_cancel_path
  #   return url_for(object.class) if object.new_record?
  #   url_for(object)
  # end

end
