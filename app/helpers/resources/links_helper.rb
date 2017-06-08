module Resources
  module LinksHelper

    def resource_link(resource, opts={})
      text = opts[:text] || "#{resource.to_s.humanize}" unless opts[:text] == false
      icon = opts[:icon] || 'fa-angle-right' unless opts[:icon] == false
      title = opts[:title] || "#{resource.to_s.humanize}" unless opts[:title] == false
      url = opts[:url] || url_for([resource])
      remote = opts[:remote] != false
      target = opts[:target]
      spinner = opts[:spinner] != false # && !remote
      disabled = opts[:disabled] ? "disabled" : nil
      disable_with = opts[:disable_with]
      html_class = "#{opts[:class]} btn btn-lg btn_resource"
      html_class = html_class + ' show_waiting_spinner' if spinner
      params = opts[:params]
      method = opts[:method] || :get
      button_to(url, method: method, params: params, form: { target: target }, data: { disable_with: disable_with }, title: title, remote: remote, form_class: opts[:form_class], class: html_class, disabled: disabled) do icon_text(icon, text) end
    end

    def new_resource_link(model_name, opts={})
      text = opts[:text] || "New #{model_name.to_s.humanize}" unless opts[:text] == false
      icon = opts[:icon] || 'fa-plus-square-o' unless opts[:icon] == false
      title = opts[:title] || "New #{model_name.to_s.humanize}" unless opts[:title] == false
      url = opts[:url] || url_for([:new, model_name])
      remote = opts[:remote] != false
      spinner = opts[:spinner] != false # && !remote
      disabled = opts[:disabled] ? "disabled" : nil
      html_class = "#{opts[:class]} btn btn-lg btn_resource"
      html_class = html_class + ' show_waiting_spinner' if spinner
      params = opts[:params]
      button_to url, method: :get, params: params,
        title: title, remote: remote, form_class: opts[:form_class], class: html_class, disabled: disabled do
          icon_text(icon, text)
        end
    end

    def edit_resource_link(resource, opts={})
      text = opts[:text] || "Edit #{resource.to_s.humanize}" unless opts[:text] == false
      icon = opts[:icon] || 'fa-edit' unless opts[:icon] == false
      title = opts[:title] || "Edit #{resource.to_s.humanize}" unless opts[:title] == false
      url = opts[:url] || url_for([:edit, resource])
      remote = opts[:remote] != false
      spinner = opts[:spinner] != false # && !remote
      disabled = opts[:disabled] ? "disabled" : nil
      html_class = "#{opts[:class]} btn btn-lg btn_resource"
      html_class = html_class + ' show_waiting_spinner' if spinner
      button_to url, method: :get, params: opts[:params],
        title: title, remote: remote, form_class: opts[:form_class], class: html_class, disabled: disabled do
          icon_text(icon, text)
        end
    end

    def destroy_resource_link(resource, opts={})
      text = opts[:text] || "Destroy #{resource.to_s.humanize}"
      icon = opts[:icon] || 'fa-trash-o'
      title = opts[:title] || "Destroy #{resource.to_s.humanize}"
      url = opts[:url] || url_for([resource])
      confirm_opts = opts[:confirm] || {}
      confirm_text = confirm_opts[:text] || "Are you sure that you want to destroy #{resource.to_s.humanize}?"
      remote = opts[:remote] != false
      spinner = opts[:spinner] != false && !remote
      disabled = opts[:disabled] ? "disabled" : nil
      method = opts[:method] || :delete
      html_class = "#{opts[:class]} btn btn-lg btn_resource"
      html_class = html_class + ' show_waiting_spinner' if spinner
      button_opts = {
        method: method, params: opts[:params],
        title: title, remote: remote, form_class: opts[:form_class],
        class: html_class, disabled: disabled }
      button_opts = button_opts.merge({data: {confirm: confirm_text}}) unless opts[:confirm] == false
      button_to(url, button_opts) do
        icon_text(icon, text)
      end
    end

  end
end
