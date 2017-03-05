class UserProfile < ApplicationRecord

  # before_create :set_defaults

  belongs_to :user
  has_many :app_shares, dependent: :destroy
  has_many :clouds, dependent: :destroy
  has_many :engines_systems, through: :clouds
  has_many :apps, through: :engines_systems
  has_many :services, through: :engines_systems

  has_image :icon

  # def set_defaults
  #   clouds.create(label: 'My Engines')
  # end

  def shared_apps
    app_shares.map(&:app)
  end

end
