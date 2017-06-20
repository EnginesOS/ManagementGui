module Page
  module WaitForSystemSpinnerHelper

    def wait_for_system_spinner
      content_tag :div, id: 'waiting_spinner', title: "Please wait...", style: "display: none;" do
        content_tag :div, class: 'waiting_spinner_container',
        style: "-webkit-box-shadow: 0px 0px 100px 100px #{ page_object.text_color };
                -moz-box-shadow: 0px 0px 100px 100px #{ page_object.text_color };
                box-shadow: 0px 0px 100px 100px #{ page_object.text_color };
                background-color: #{ page_object.text_color };" do
          content_tag :i, nil, class: 'fa fa-spinner fa-spin', style: "color: #{ page_object.background_color };"
        end
      end
    end

  end
end
