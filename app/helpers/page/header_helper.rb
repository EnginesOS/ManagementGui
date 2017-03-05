module Page
  module HeaderHelper

    def page_header(text_or_opts, opts={})
      if text_or_opts.is_a? String
        text = text_or_opts
      else
        text = text_or_opts[:text]
        opts = text_or_opts
      end
      icon = opts[:icon] || 'fa-angle-right'
      subtext = opts[:subtext]
      title = opts[:title]
      content_tag :div, class: 'page-header', title: title do
        [ icon_text(icon, text),
          content_tag(:small, subtext) ].
          join(' ').html_safe
      end
    end

  end
end
