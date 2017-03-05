module Page
  module BodyHelper

    def page_body(body)
      if @error || (devise_controller? && !current_user)
        cloud_page_body(page_object, body)
      elsif controller_name == 'portals'
        portal_page_body(page_object, body)
      else
        cloud_page_body(page_object, body, page_body_style(page_object))
      end
    end

    def cloud_page_body(cloud, body, body_style=nil)
      content_tag :body, style: body_style do
        content_tag(:div, class: 'container') do
          flash_messages +
          body +
          content_tag(:div, nil, id: 'page_footer')
        end
      end
    end

    # def page_body_footer
    #   content_tag :div, class: 'container' do
    #     content_tag :div, class: 'row' do
    #       content_tag :div, class: 'col-sm-12' do
    #         content_tag :div, nil, class: 'page_body_footer'
    #       end
    #     end
    #   end
    # end

    def page_object
      @cloud || ( current_user || User.find_by(username: 'admin') ).user_profile
    end

    # def cloud_page_body_style
    #   page_body_style(@cloud)
    # end

    def page_body_style(cloud_or_user_profile)
      "color: #{cloud_or_user_profile.text_color};
      background-color: #{cloud_or_user_profile.background_color};"
    end

  end
end
