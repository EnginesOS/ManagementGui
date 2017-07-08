class EnginesSystem
  module CoreResources
    module Certificate
      module Upload
        class Certificate

          include ActiveModel::Model

          attr_accessor :engines_system,
                        :certificate_file_upload, :certificate_input

          attr_writer :certificate_upload_method_selection

          validate :validate_certificate

          def core_system
            @core_system ||= engines_system.core_system
          end

          def certificate_upload_method_selection
            @certificate_upload_method_selection ||= :file
          end

          def certificate_input
            @certificate_input ||=
"-----BEGIN CERTIFICATE-----\n\
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\n\
-----END CERTIFICATE-----\n"
          end

          def validate_certificate
            if certificate_file_uploaded?
              validate_certificate_upload
            else
              validate_certificate_input
            end  #&&
            #validate_certificate_cname
          end

          def certificate_file_uploaded?
            certificate_upload_method_selection.to_s == 'file'
          end

          def validate_certificate_upload
            if certificate_file_upload.present?
              true
            else
              errors.add(:certificate_file_upload, 'needs a file')
              false
            end
          end

          def validate_certificate_input
            if certificate_input.present?
              true
            else
              errors.add(:certificate_input, 'needs text')
              false
            end
          end

          def validate_certificate_cname
            if certificate_cname.present?
              true
            else
              errors.add(:base, 'Invalid certificate.')
              false
            end
          end

          def certificate_string
            if certificate_file_uploaded?
              certificate_file_content
            else
              certificate_input
            end
          end

          def certificate_file_content
            certificate_file_upload.tempfile.rewind;
            certificate_file_upload.tempfile.read
          rescue
            ''
          end

          def ssl_certificate
            @ssl_certificate ||=
            OpenSSL::X509::Certificate.new(certificate_string)
          end

          def certificate_cname
            @certificate_cname ||=
            begin
              ssl_certificate.subject.to_a.find{|element| element.first == 'CN'}.second
            rescue => e
              return nil if e.is_a? OpenSSL::X509::CertificateError
              raise
            end
          end




          # def x509_certificate
          #   @ssl_certificate ||=
          #   OpenSSL::X509::Certificate.new(certificate_file_content)
          # end
          #
          # def pkcs12_certificate
          #   @ssl_certificate ||=
          #   OpenSSL::PKCS12.new(certificate_file_content, 'password')
          # end
          #
          #
          #
          def save_to_tmp
          # byebug
            # Dir.mkdir('tmp/engines_gui_certificate_uploads') unless Dir.exist?('tmp/engines_gui_certificate_uploads')
            if certificate_upload_method_selection.to_s == 'file'
              FileUtils.mv upload_filepath, tmp_dir
              File.rename "#{tmp_dir}/#{upload_filename}", "#{tmp_dir}/#{tmp_file_name}"
            else
              File.write "#{tmp_dir}/#{tmp_file_name}", certificate_input
            end
            true
          rescue
            false
          end

          def tmp_file_name
            @tmp_file_name ||= SecureRandom.hex
          end

          def upload_filepath
            @upload_filepath ||= certificate_file_upload.tempfile.to_path.to_s
          end

          def upload_filename
            File.basename upload_filepath
          end

          def tmp_dir
            @tmp_dir ||=
            "#{Rails.application.config.tmp_dir}/engines_gui_certificate_uploads"
          end

  ############3

          #

          #
          # def tmp_filepath
          #   @tmp_filepath ||=
          #   "#{tmp_dir}/#{filename}"
          # end
          #
          # def upload_filepath
          #   @upload_filepath ||= certificate_file_upload.tempfile.to_path.to_s
          # end
          #
          # def filename
          #   File.basename upload_filepath
          # end
          #
          # def save_certificate_to_tmp_file
          #   certificate_upload_present? && FileUtils.mv(upload_filepath, tmp_dir) && valid?
          # end
          #

          #
          #
          # def valid_ssl_certificate
          #   unless cname.present?
          #     delete_certificate_tmp_file
          #     errors.add(:certificate_file_upload, 'file must contain a valid SSL certificate.')
          #   end
          # end
          #
          # def delete_certificate_tmp_file
          #   File.delete tmp_filepath
          # end
          #
          # def certificate_tmp_file
          #   @certificate_tmp_file ||=
          #   File.open(tmp_filepath, 'r') do |file|
          #     file.read
          #   end
          # end
          #
          # def ssl_certificate
          #   @ssl_certificate ||=
          #   OpenSSL::X509::Certificate.new(certificate_tmp_file)
          # end
          #
          # def cname
          #   @cname ||=
          #   begin
          #     ssl_certificate.subject.to_a.find{|element| element.first == 'CN'}.second
          #   rescue => e
          #     return nil if e.is_a? OpenSSL::X509::CertificateError
          #     raise
          #   end
          # end

        end
      end
    end
  end
end
