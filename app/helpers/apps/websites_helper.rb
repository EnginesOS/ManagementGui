module Apps
  module WebsitesHelper

    def app_website_links(app)
      app.websites.map do |website|
        content_tag(:div) do
          link_to icon_text('fa fa-globe', website), website,
            title: "Website for #{app.name}",
            target: "app_#{website}",
            class: 'btn btn-lg btn_resource'
        end
      end.join.html_safe
    end

  end
end
