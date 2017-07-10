# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

# Create certificate_uploads directory in tmp directory
dirname = "#{Rails.application.config.tmp_dir}/engines_gui_certificate_uploads"
Dir.mkdir(dirname) unless Dir.exist?(dirname)
