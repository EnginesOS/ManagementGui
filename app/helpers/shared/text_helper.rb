module Shared
  module TextHelper

    def markdown_text(text)
      Markdown.new(
        text,
        :hard_wrap, :filter_html, :autolink,
        :no_intra_emphasis, :fenced_code_blocks ).
        to_html.html_safe
    end

    def pretty_print(data)
      content_tag :pre do
        if data.is_a?(Array) || data.is_a?(Hash)
          JSON.pretty_generate(data)
        else
          data
        end
      end
    end
    # alias pp pretty_print

    def time_ago(time)
      distance_of_time_in_words(time, DateTime.now) + ' ago'
    end

    def format_time(time)
      time = DateTime.parse(time) if time.is_a? String
      time.strftime "UTC %H:%M:%S %d %B %Y"
    end

    def labelled_pretty_text(label, text)
      content_tag(:label, label) +
      pretty_print(text)
    end

    def boolean_text(boolean)
      if boolean == true
        icon_text('fa-check', 'True')
      else
        icon_text('fa-times', 'False')
      end
    end

  end
end
