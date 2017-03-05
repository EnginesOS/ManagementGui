module Apps
  module InstructionsHelper

    def app_instruction_link(app, instruction, opts={})
      text = "#{instruction.to_s.humanize}"
      icon = opts[:icon]
      title = "#{instruction.to_s.humanize} #{app.to_s}"
      form_class = 'display_inline'
      resource_link app,
        text: text, icon: icon, title: title, form_class: form_class,
        url: app_instruction_path,
        params: { app_id: app.id, app_instruction: instruction }
    end

  end
end
