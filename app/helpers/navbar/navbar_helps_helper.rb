module Navbar
  module NavbarHelpsHelper

    def navbar_help_link
			link_to icon('fa-question'), help_path(lookup: "#{params[:controller]}.#{params[:action]}.help"), title: 'Help', class: 'btn_navbar show_wait_for_system_response_spinner'
    end

  end
end
