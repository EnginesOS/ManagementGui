module Shared
  module SectionHelper

    def section_header(text, opts={})
      icon = opts[:icon]
      subtext = opts[:subtext]
      title = opts[:title] || text
      content_tag :div, ( icon_text(icon, text) + content_tag(:small, subtext) ), title: title, class: 'dropdown-header'
    end

  end
end
