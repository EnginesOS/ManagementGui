module Components
  module Legend

    def engines_legend(text=nil, opts={})
      @template.content_tag :div, class: 'col-sm-12' do
        @template.content_tag :div, class: 'form-group form_legend' do
          @template.legend text, opts
        end
      end
    end

  end
end
