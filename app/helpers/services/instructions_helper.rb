module Services
  module InstructionsHelper

    def service_instruction_link(service, action, opts={})
      text = opts[:text] == false ? false : ( opts[:text] || "#{action.to_s.humanize}")
      icon = opts[:icon] == false ? false : opts[:icon]
      title = opts[:title] == false ? false : ( opts[:title] || "#{action.to_s.humanize} #{service.to_s}" )
      form_class = 'display_inline'
        resource_link service,
          text: text, icon: icon, title: title, form_class: form_class,
          url: service_instruction_path(service_id: service.id, service_instruction: action)
    end

  end
end
