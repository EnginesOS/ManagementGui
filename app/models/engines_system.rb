class EnginesSystem < ApplicationRecord

  include CoreResources
  include EventStreams
  include Properties
  include ServiceConnections
  include Status

  belongs_to :cloud
  has_many :apps, dependent: :destroy
  has_many :services, dependent: :destroy
  # has_many :installer_repositories, class_name: '::Installer::Repository', dependent: :destroy
  # has_one :certificate, class_name: 'CoreResources::Certificate', dependent: :destroy

  # attr_accessor :password, :exception

  validates :label, presence: true
  validates :url, presence: true, uniqueness: { scope: :cloud }
  # validates :password, presence: true

  custom_attribute_labels url: 'URL', password: "Admin password"

  # has_image :icon

  def core_system
    @core_system ||= EnginesSystemCore::CoreSystem.new(url, token, label)
  end

  def installed_apps
    @installed_apps ||=
    app_states_with_installing_app.map do |name, state|
      apps.find_or_create_by_with_defaults(name: name).tap{ |app| app.state = state }
    end.tap{|found_apps| (apps - found_apps).each(&:delete) }.sort_by &:name
  end

  def installed_services
    @installed_services ||=
    service_states.map do |name, state|
      services.find_or_create_by(name: name).tap{ |service| service.state = state }
    end.tap{|found_services| (services - found_services).each(&:delete) }.sort_by &:name
  end

  def cloud_portal_apps
    apps.select(&:show_on_portal)
  end

  def is_local_system
    url == Rails.application.config.local_system_api_url
  end

end
