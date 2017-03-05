module Navbar
  module BrandsHelper

    def navbar_brand(opts)
      button_to opts[:link_url], params: opts[:link_params],
        method: :get,
        class: 'btn navbar-brand',
        # disabled: opts[:disabled],
        title: opts[:text] do
          navbar_brand_icon(opts[:image_url], opts[:text])
        end
    end

    def navbar_brand_icon(image_url, text)
      content_tag(:div, icon_url(image_url), class: 'navbar-icon') +
      content_tag(:div, text, class: 'brand_text')
    end

  end
end
