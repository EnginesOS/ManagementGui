module Shared
  module FlashMessageHelper

    def flash_messages
      content_tag(:div, id: :flash_messages) do
        flash.map do |msg_type, message|
          next if message == true  # Devise creates { timedout: true } flag in flash messages
          next if message == nil  # nil message created by Devise sessions controller override in users/sessions_controller.rb
          flash_message(msg_type, message)
        end.join.html_safe
      end
    end

    def flash_message(msg_type, message)
      content_tag(:div, message, class: "alert #{flash_message_bootstrap_alert_class_for(msg_type)} alert-dismissible") do
        button_tag(type: 'button', class: 'close', data: { dismiss: 'alert' }) do
          '&times;'.html_safe
        end +
        message
      end
    end

    def flash_message_bootstrap_alert_class_for(flash_type)
      { success: 'alert-success',
        error: 'alert-danger',
        alert: 'alert-warning',
        notice: 'alert-info' }[flash_type.to_sym]
    end


  end
end
