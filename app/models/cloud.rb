class Cloud < ApplicationRecord

  belongs_to :user_profile
  has_many :engines_systems, dependent: :destroy
  # has_many :apps, through: :engines_systems
  has_many :libraries, dependent: :destroy

  has_image :icon

  validates :label, presence: true

  after_create :set_default_library

  def cloud_portal_apps
    [].tap do |result|
      engines_systems.map do |engines_system|
        engines_system.cloud_portal_apps.each do |app|
          result << app
        end
      end
    end.sort_by &:to_label
  end

  def set_default_library
    libraries.create(
      name: 'Engines library',
      url: 'https://library.engines.org/api/v0/apps' )
  end

end
