require_relative 'boot'

# require 'rails/all'
# require all except action_cable
require "rails"
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SystemGui
  class Application < Rails::Application

    # config.logger = Logger.new(STDERR)

    # Temporary directory
    config.tmp_dir = '/tmp'

    # ENV['RAILS_MAX_THREADS'] = '16'

    config.bug_reports_server = ENV['BUG_REPORTS_SERVER'] # e.g. 'http://eng.example.com:3999'
    config.local_system_api_url = ENV['SYSTEM_API_URL'] # e.g. 'http://eng.example.com:2380'
    config.user_timeout_minutes = ENV['USER_TIMEOUT_MINUTES'] # default is 30

  end
end
