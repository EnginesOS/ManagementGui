class ApplicationRecord
  module ImageInstance

    def check_clear_attachment_for(method=:icon)
      if send("#{method}_clear") == "1"
        send(method).clear
      end
    end

  end
end
