module Forms
  module LinksHelper

    def form_submit_link(text_or_opts=nil)
      if text_or_opts.is_a? String
        opts = {text: text_or_opts}
      else
        opts = text_or_opts
      end
      text = opts[:text] || 'Submit' unless opts[:text] == false
      icon = opts[:icon] || 'fa-check' unless opts[:icon] == false
      title = opts[:title] || "Submit #{action_name} form" unless opts[:title] == false
      html_class = opts[:class] || 'btn btn-primary pull-right'
      data = opts[:data] || {}
      disabled_text = opts[:disabled_text] || 'Submitting'
      disabled_icon = opts[:disabled_icon] || 'fa-hourglass-o'
      html_opts =
          { type: :submit,
            class: html_class,
            data: data.merge( { disable_with: icon_text(
                          disabled_icon, disabled_text) } ),
            title: title }
      button_tag html_opts do
        icon_text(icon, text)
      end
    end

    def form_cancel_link(opts={})
      text = opts[:text] || 'Cancel' unless opts[:text] == false
      icon = opts[:icon] || 'fa-times' unless opts[:icon] == false
      title = opts[:title] || "Cancel #{action_name} form" unless opts[:title] == false
      remote = opts[:remote] == true
      html_class = opts[:class] || 'btn btn-warning pull-left'
      data = opts[:data] || {}
      url = opts[:url]
      toggle = opts[:toggle]
      # html_opts = opts[:html_opts] || { class: 'btn btn-warning pull-left' }
      html_opts =
        { type: :button, remote: remote, class: html_class,
          data: data.
          merge( ( { toggle: :modal, target: toggle} if toggle ) || {} ).
          merge( ( { dismiss: :modal } unless url ) || {} ),
          title: title }
      if url
        link_to(icon_text(icon, text), url, html_opts)
      else
        button_tag(icon_text('fa-times', 'Cancel'), html_opts)
      end
    end

  end
end
