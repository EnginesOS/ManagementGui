class Service < ApplicationRecord

  include CoreResources
  include Properties
  # include Status

  include LabelData

  attr_accessor :state

  before_save :update_display_attributes

  belongs_to :engines_system

  def core_service
    @core_service ||= EnginesSystemCore::CoreService.new(engines_system.url, engines_system.token, name)
  end

  def container
    @container ||= core_service.container
  end

  def to_s
    name
  end

  def label
    title
  rescue
    name.to_s.humanize
  end

  def icon
    return label_data[name.to_sym][:icon] if label_data[name.to_sym]
    'fa-square-o'
  end


  def perform_instruction(action)
    result = core_service.send action
    if result
      {type: :success, message: "Sent #{action} instruction."}
    else
      { type: :error, message: "Failed to send #{action} instruction." }
    end
  end

  # def publisher_namespace
  #   @publisher_namespace ||= container[:publisher_namespace]
  # end

  def publisher_type_path
    @publisher_type_path ||= "#{container[:publisher_namespace]}/#{container[:type_path]}"
  end

  def service_configurations
    @service_configurations ||= core_service.configurations
  end

# Service definition

  def service_definition
    @service_definition ||= engines_system.service_definition_for(publisher_type_path)
  end

  # Test for local mgmt GUI
  def is_local_mgmt
    name.to_s == 'mgmt' && engines_system.is_local_system
  end

  private

  def update_display_attributes
    self.title = service_definition[:title]
    self.description = service_definition[:description]
    
  end


end
