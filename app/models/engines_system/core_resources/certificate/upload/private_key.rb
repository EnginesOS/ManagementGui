class EnginesSystem
  module CoreResources
    module Certificate
      module Upload
        class PrivateKey

          include ActiveModel::Model

          attr_accessor :engines_system, :certificate_tmp_file, :certificate_cname,
                        :private_key_file_upload, :private_key_input, :password
          attr_writer :private_key_upload_method_selection

          def private_key_upload_method_selection
            @private_key_upload_method_selection ||= :file
          end

          def core_system
            @core_system ||= engines_system.core_system
          end

          def private_key_input
            @private_key_input ||=
"-----BEGIN ENCRYPTED PRIVATE KEY-----\n\
MIIJjjBABgkqhkiG9w0BBQ0wMzAbBgkqhkiG9w0BBQwwDgQIOLUJ3zR++y8CAggA\n\
MBQGCCqGSIb3DQMHBAjkBOJYqVpfmQSCCUhsaiQlDA9ikPoZ0GliLG00AgQFqEtX\n\
2QMlgSgYdPsdNJNV8HUj3/nUOZmZK7O6x7FgGvo9MtLEZuUod5CnCuc9eZCxLO7z\n\
kF5Up0mAzVKXc9873ANzBQ+rRijnU180UVqMVe7s4bY/8DH4eMM/aAM1iGm2vaZU\n\
7P8vr1rsROXEdjkbwqudZ2mBMRGh0DbEnBZDqcQXVdJIOYjAaPG7JdbnJKufxgLU\n\
yjAs6EvSucIorUgVmEOEFnTVmJ1nhuZv6dRWgvXvrJA+oby4eXk13FBj3h7eMHiF\n\
EdsNOOH92pSdtcA9GOAe+A3MFlG0qWEl7IecJlkEBdeX3In5r+jO2/dnYlylyitW\n\
k9oKcBrINgyB2Kdqmps3hS13Yi+YLcwP4q9u/fBYjoDEyN65l8Wcem+KW423SXiN\n\
MstufscOf+SkqgZcwSaP4tb4eS7u+6+qP/FtCv5Au7AAf4I2yDUfjHCgrsSShaYV\n\
y2sAC6rZgtTBOw7ArDrqSBN9By7AAXFUF7N4SqHLkwcDgeZOnk9lfnG5GGyUEuU7\n\
KbjVaKbhVpdoCzATlTsAqq/3AGrCipWnaWbB/ao09XGodNzB1SpaojpqapIrSYKx\n\
O7UVhwb+P0asKsYWcrcktKorClEFwgutjGYsmAWfyyxkOdofCis7uy8oV9c10rcD\n\
IFrJEdyYmIXN5qvSKLwmXMrEofi6nwgRDFv1srJIH9XxCZWBDrUw6WYdujpI0/4a\n\
mK3xtKnLQGUhvc9udYtXKqMu0l5iILnl1MO2Xgu1/Y04xxFTMvGs0cJBPCCBzD+I\n\
a+zZQmKJina0DfPkHJ7QkT0ISkfBhAPLHL73Yn78/9TLC6vl3Lx1pDFIDVbeD1QU\n\
pz6weXeP6ngsYUJyY9Ia12sk9z9nAO2wIQHPj76goq875MMoGgmuvZOqHH8wDaU1\n\
whVHFmXEzxtTPGmBAnG0ijBXBd2aiUyYGyBZQOh5DhYutzNhOnvBL+xvpI7J7wQ8\n\
E2sJSTWN2W/cno+ecmGojaqd1+Ft6pXMJHEeU0cqYVv0w5i1Dp9sYj5cu+dRkJ+T\n\
3PDNRl2msu4/BNry6P5UD7JJ5hnmayPmhhCkbQoKJaq3hbmeySOgWTD8WZVygpDI\n\
Cl+Q2GDCebojVR2Yi+Bre5SCFtlmXgwHPaYlAN71iFycQshp/Ubp9pDdDNucvjIs\n\
Rx/g5U+mCXDhM54q65TROhhi/tlGsmM5wdOPP6L0lk40YLTPgFMIAAe/D/q2g5Fs\n\
k4Iwjk8Iw4QyPEL/s9jVxz2aXVNPmDmUOUr3gqhMkqmCJNIwAW2TcJdamE030YmC\n\
yR3NzWvmpPvCLlavR+5aIZF3CvfeU1ioGXybUUa5GtscLDegwQOmYqfq5NrQcAwi\n\
lqmyDXHWqgMtEoTyoHNSe+p8Q7Gr+4JEZ7kkfbFXhHycSZANvoD3J/QxCrm5/jxH\n\
lA0gj55IzeFa5z8Emm+yjooMTO0yUHZlVhdmLpP7mSOnTxau3CQ9KF1dtQtxXpon\n\
bb49RMj3HE5RCZdBlwcyn22LpaJZ7+h51UZV89GXv9kJ4HY2nJ8/N1Z73uhetkYC\n\
YAaI7fJFabl3goOKMnwNd9KEGLZPmyt05+ZmxrRFiqU9wcOuXKnLSp6QLn4iLguo\n\
i1wvYLb9Tq+gLcuBnM8dRPGkiF1HvHJvYLhNgieqBMNMgQdGbywa8JTkHsZbwuH7\n\
SAJ9XIuzPsXqG7fhdW6nntVEW8MEXpeSvxoBx5NF99Yaze5fIP6C868bPvntWVz3\n\
vhVBcVKv6j+6vDmNBbt1wyOgCrhsUjj9qcAO2Xla76AbARFjmRqhAXfvmUGKSvTp\n\
7QZNZMc3dWQkgw0Kn927lSNGRO06rcN4MzMuzBfjQ3B6H6u2GGHFmcdFw0CPUgBo\n\
miqPVqEipgXZgNYyndPFH9wueMp4GjVvuidahcsxi+H19HyddYHFwebp0SvMfgvp\n\
8Cvrjk9Krx3UDN/oilBCIp0C/k8jx3yHZf4NzCaoTb968TSMvrkIRUAoJkOfxQHx\n\
F23yob33GBDHukZDgoWbr6AD0kdvskeBFETnmaZTzX/VIJUkAM0fouzZhVsjMr9w\n\
BXdNib1HhgCUC2K1RgwZJKnNS4k4/56fuGfGvCCtDHqSVfVpJpAxfhI/pQhxCMfM\n\
nlmLjLuvgNZas/nlwB5aPogjn7NCWqNbuLvnXrsY4o3flYhZAd6dvR4gJ9xPQiaS\n\
SnGHT3kIOM9O0zvVBjnw5hGnQL+o5TsDmEmXDtyBD1gVzmk+MmWhZHOWS4MOEpDm\n\
BivzeoqAN3Kp/JD4ZubY8uj9CkeHkf2x1iHNI+ExtyXao/edrCff17geY48qzQnq\n\
PL2iCT7+4u53jCGglKIpVZBTXMq7ya80kfI1jEid4Aoeno3Y/qgYXD4bYMOJ7Lmd\n\
FbKgskTomskflIA/oxw37p+Y0g/Bi6jNqCntAaRy77tufbUlfSRgoaF/HnfvxdUI\n\
134+979NKzF/nn/IJppPKoPh/WnvN5fQAd3o5Tndgk6cQFGul/VifyarDP4dsdYZ\n\
wKdCLtbFhqVcE0LpXvzUL756WfULkwCDDF1OYZguUfjwC4yF0+Z3LQlVorGTy4xi\n\
+7zVnNUBFYlRa4d83TEiz+IE0brqxhTxEe1UExhHMou9H/qvJT090nJwmAqPhiX9\n\
ZfA1eMMzbDJAXFK3b8Bv9dENEhrVO3Sh44FLLCxzH0mHJiIkAFlrLg7ZeSDlEgth\n\
1Gsr1QAomlcuCpQBb+/BNpuiglCDV9Fk7rhuDvKpL1MQAy54n/V4ok/QrIXezp8u\n\
jH1S+bB9RzGLm1POda+R9qvxRNxewXMlcNGrNCw8ooIHEn5Lggko+eY8kE+CpSGC\n\
Mb9NeulxFAi7QZHBGYsGCrjA/3WW97hY1hpG5q8WFkcmA5ENClYlMYh9m8qS3fNT\n\
qT8QvVOwwMwguN/hf9mbC1If4m59/SlGEexNeJ1ljrH+RMjY3n1XOVNPpAaG9PTV\n\
B1kxcDQyikdNTnBCOxkiOmqVYe9W8EfYEns0mqsrR5+S4KWqVbu7SvvMnhuqg0VH\n\
rNovGLCYeKVpMCreKUQPFIBk0YNKHDAzk1658YuQa3G/BlAe0OjcR65VGaBLRg6k\n\
QJX0GZDm7/6JOvf8yy6XVW0HwUSChMPB6z7pEEubeAZS5pkj+Hd1vdXrHDftKV8p\n\
qIk=\n\
-----END ENCRYPTED PRIVATE KEY-----\n"
          end


          validate :validate_private_key

          def validate_private_key
            if password_instead_private_key?
              true
            else
              if private_key_file_uploaded?
                validate_private_key_upload
              else
                validate_private_key_input
              end
            end
          end

          def private_key_file_uploaded?
            private_key_upload_method_selection.to_s == 'file'
          end

          def password_instead_private_key?
            certificate_cname.blank?
          end

          def validate_private_key_upload
            if private_key_file_upload.present?
              true
            else
              errors.add(:private_key_file_upload, 'needs a file')
              false
            end
          end

          def validate_private_key_input
            if private_key_input.present?
              true
            else
              errors.add(:private_key_input, 'needs text')
              false
            end
          end

          def private_key_string
            if password_instead_private_key?
              nil
            else
              if private_key_file_uploaded?
                private_key_file_content
              else
                private_key_input
              end
            end
          end

          def private_key_file_content
            private_key_file_upload.tempfile.rewind;
            private_key_file_upload.tempfile.read
          end



  ############3
          #
          #
          # def tmp_dir
          #   @tmp_dir ||=
          #   "#{Rails.application.config.tmp_dir}/engines_gui_certificate_uploads"
          # end
          #
          # def tmp_filepath
          #   @tmp_filepath ||=
          #   "#{tmp_dir}/#{filename}"
          # end
          #
          # def upload_filepath
          #   @upload_filepath ||= key_file_upload.tempfile.to_path.to_s
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
          def key_present?
            if key_file_upload.present?
              true
            else
              errors.add(:key_file_upload, 'needs a file')
              false
            end
          end
          #
          #
          # def valid_ssl_certificate
          #   unless cname.present?
          #     delete_certificate_tmp_file
          #     errors.add(:key_file_upload, 'file must contain a valid SSL certificate.')
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
