# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

# Create certificate_uploads directory in tmp directory
dirname = "#{Rails.application.config.tmp_dir}/certificate_uploads"
FileUtils.mkdir_p(dirname) unless Dir.exist?(dirname)
