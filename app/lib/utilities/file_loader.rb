# module Lib
  module Utilities
    module FileLoader

      def self.get url
        return nil if url.blank?


        url_without_timestamp = url.split('?').first
        file = Tempfile.new('app_icon_upload')
        file.binmode
        open(URI.parse(url_without_timestamp), :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE, :allow_redirections => :safe) do |data|
          file.write data.read
        end
        file.rewind
        return file
      rescue
        return nil
      end

    end
  end
# end
