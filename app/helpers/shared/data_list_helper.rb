module Shared
  module DataListHelper

    def data_list_text(label, text, opts={})
      content_tag(:dt, title: (opts[:title] || label)) do
        label
      end +
      content_tag(:dd, title: (opts[:title] || text)) do
        text.nil? ? '&nbsp;'.html_safe : text.to_s
      end
    end

    def data_list_array(label, text, opts={})
      content_tag(:dt, title: opts[:title]) do
        label
      end +
      content_tag(:dd, title: opts[:title]) do
        text.empty? ? 'None' :
          text.map{ |element| content_tag :p, element.to_s }.join.html_safe
      end
    end

  end
end
