class App < ApplicationRecord

  include CoreResources
  include Instructions
  include Properties
  include ServiceConsumers
  include Status

  has_image :icon

  belongs_to :engines_system
  has_one :cloud, through: :engines_system

  attr_writer :state

  def state
    @state ||= core_app.state
  end

  validates :label, length: { maximum: 32 }

  custom_attribute_labels portal_link: 'Link'

  def self.find_or_create_by_with_defaults(opts)
    existing_app = find_by(opts)
    return existing_app if existing_app
    create(opts).tap do |app|
      app.show_on_portal = true
      unless app.blueprint_deployment_type == :web
        app.worker = true
      end
      app.save
    end
  end

  def portal_link
    super || set_default_website
  end

  def set_default_website
    self.update_columns portal_link: default_website
    default_website
  end

  def default_website
    websites.first
  # Rescue catches case when app install does not complete and system is
  # subsquently unable to supply a website url for gui app.
  rescue  EnginesSystemApiConnectionRefusedError,
          EnginesSystemApiResourceNotFoundError
    nil
  end

  def core_app
    @core_app ||= EnginesSystemCore::CoreApp.new(engines_system.url, engines_system.token, name)
  end

  def container
    @container ||= core_app.container
  end

  def to_s
    name
  end

  def to_label
    label.present? ? label : to_s
  end

end
