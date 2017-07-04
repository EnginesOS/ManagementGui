module Navbar
  module NavbarHelpsHelper

    def navbar_help_link
			link_to icon('fa-question'), help_path(lookup: "#{params[:controller]}.#{params[:action]}.help"), title: 'Help', class: 'btn_navbar show_waiting_spinner'
    end

  end
end
