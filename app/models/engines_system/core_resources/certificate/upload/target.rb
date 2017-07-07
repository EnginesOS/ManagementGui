class EnginesSystem
  module CoreResources
    module Certificate
      module Upload
        class Target

          include ActiveModel::Model
          extend ApplicationRecord::CustomAttributeLabels

          attr_accessor :host_domain, :certificate_for, :password, :engines_system, :certificate_string, :certificate_cname, :private_key_string, :target

          validate :custom_host_domain_present_if_required

          custom_attribute_labels host_domain: 'Custom host.domain'

          def certificate_for
            @certificate_for || :default
          end

          # def tmp_filepath
          #   @tmp_filepath ||=
          #   "#{Rails.application.config.tmp_dir}/certificate_uploads/#{tmp_filename}"
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

          def save_certificate_to_system
            # true
            if certificate_for.to_sym == :default
              engines_system.core_system.save_default_certificate(
                certificate: certificate_string,
                private_key: private_key_string,
                password: password)
                # certificate_tmp_file, key, password)
            else
              engines_system.core_system.save_service_certificate(
                certificate: certificate_string,
                private_key: private_key_string,
                password: password,
                target: target )

                # host_domain, certificate_tmp_file, key, password)
            end
            #  &&
            # delete_certificate_tmp_file
          end

          def custom_host_domain_present_if_required
            errors.add(:host_domain, "can't be blank") if certificate_for.to_sym == :custom && host_domain.blank?
          end

        end
      end
    end
  end
end
