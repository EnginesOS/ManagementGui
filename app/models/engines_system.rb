class EnginesSystem < ApplicationRecord

  include CoreResources
  include EventStreams
  include Properties
  include ServiceConnections
  include Status

  belongs_to :cloud
  has_many :apps, dependent: :destroy
  has_many :services, dependent: :destroy

  validates :label, presence: true
  validates :url, presence: true, uniqueness: { scope: :cloud }

  custom_attribute_labels url: 'URL', password: "Admin password"

  before_save :cleanup_url

  def core_system
    @core_system ||= EnginesSystemCore::CoreSystem.new(url, token, label)
  end

  def cleanup_url
    assign_attributes(url: clean_url)
  end

  def installed_apps
    @installed_apps ||=
    app_statuses_with_installing_app.map do |name, status|
      apps.find_or_create_by_with_defaults(name: name).tap{ |app| app.status = status }
    end.tap{|found_apps| (apps - found_apps).each(&:delete) }.sort_by &:name
  end

  def installed_services
    @installed_services ||=
    service_statuses.map do |name, status|
      services.find_or_create_by(name: name).tap{ |service| service.status = status }
    end.tap{|found_services| (services - found_services).each(&:delete) }.sort_by &:name
  end

  def cloud_portal_apps
    apps.select(&:show_on_portal)
  end

  def is_local_system?
    url == Rails.application.config.local_system_api_url
  end

  def clean_url
    ( ['http', 'https'].include?(url.split('://').first) ? '' : 'https://' ) +
    + url +
    ( is_integer?(url.split(':').last) ? '' : ':2380' )
  end

  def is_integer?(obj)
    obj.to_s == obj.to_i.to_s
  end

end
