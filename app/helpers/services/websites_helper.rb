module Services
  module WebsitesHelper

    def service_website_links(service)
      service.websites.map do |website|
        content_tag(:p) do
          link_to icon_text('fa fa-globe', website), website,
            title: "Website for #{service.name}",
            target: "service_#{service.name}",
            class: 'btn btn-lg'
        end
      end.join.html_safe
    end

  end
end
