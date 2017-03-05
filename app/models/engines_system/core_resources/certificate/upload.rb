class EnginesSystem
  module CoreResources
    module Certificate
      class Upload

        include ActiveModel::Model

        attr_accessor :engines_system, :certificate, :domain_name

        validates :certificate, presence: true
        validate :valid_ssl_certificate

        def core_system
          @core_system ||= engines_system.core_system
        end

        def tmp_dir
          @tmp_dir ||=
          "#{Rails.application.config.tmp_dir}/certificate_uploads"
        end

        def tmp_filepath
          @tmp_filepath ||=
          "#{tmp_dir}/#{filename}"
        end

        def upload_filepath
          @upload_filepath ||= certificate.tempfile.to_path.to_s
        end

        def filename
          File.basename upload_filepath
        end

        def save_certificate_to_tmp_file
          certificate_upload_present? && FileUtils.mv(upload_filepath, tmp_dir) && valid?
        end

        def certificate_upload_present?
          if certificate.present?
            true
          else
            errors.add(:certificate, 'needs a file')
            false
          end
        end

        def valid_ssl_certificate
          invalid_certificate unless cname.present?
        end

        def invalid_certificate
          delete_certificate_tmp_file
          errors.add(:certificate, 'file must contain a valid SSL certificate.')
        end

        def delete_certificate_tmp_file
          File.delete tmp_filepath
        end

        def certificate_tmp_file
          @certificate_tmp_file ||=
          File.open(tmp_filepath, 'r') do |file|
            file.read
          end
        end

        def ssl_certificate
          @ssl_certificate ||=
          OpenSSL::X509::Certificate.new(certificate_tmp_file)
        end

        def cname
          @cname ||=
          begin
            ssl_certificate.subject.to_a.find{|element| element.first == 'CN'}.second
          rescue => e
            return nil if e.is_a? OpenSSL::X509::CertificateError
            raise
          end
        end

      end
    end
  end
end
