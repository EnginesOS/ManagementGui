# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(username: :admin, password: :password, password_confirmation: :password).tap do |admin_user|
  admin_user.user_profile.clouds.create(label: 'My Engines').tap do |cloud|
    if Rails.application.config.local_system_api_url.present?
      cloud.engines_systems.create(
        label: 'Local system',
        url: Rails.application.config.local_system_api_url)
    end
  end
end
