module Shared
  module IconsHelper

    def icon_text(icon=nil, text=nil, opts={})
      content_tag :span, title: opts[:title] do
        if icon.present?
          icon(icon) +
          content_tag(
            :span,
            ( "&nbsp;#{text}".html_safe if text ) )
        else
          text.to_s
        end.gsub('"', "'").html_safe
      end
    end

    def icon_url(url)
      if url.present?
        image_tag(url, alt: '')
      else
        ''.html_safe
      end
    end

    def icon(icon_or_opts)
      if icon_or_opts.is_a? String
        single_icon(icon_or_opts)
      else
        stacked_fa_icon(icon_or_opts)
      end
    end

    def single_icon(icon)
      content_tag(:i, nil, class: "#{icon.to_s.split('-', 2).first} #{icon}")
    end

    def stacked_fa_icon(opts)
      content_tag :span, style: 'font-size: 0.6em; margin: -3px 0px -3px -3px;', class: 'fa-stack' do
        content_tag(:i, nil, class: "fa #{opts[:back]} fa-stack-2x fa-sm") +
        content_tag(:i, nil,
          style: "margin-top: #{opts[:vertical_offset]}px",
          class: "fa #{opts[:front]} fa-sm fa-stack-1x #{'fa-inverse' if opts[:front_inverse]}")
      end
    end

  end
end
