class CreateEnginesSystemCertificates < ActiveRecord::Migration[5.0]
  def change
    create_table :engines_system_certificates do |t|
      t.integer :engines_system_id
      t.string  :certificate_file_name
      t.string  :certificate_content_type
      t.integer :certificate_file_size
      t.string  :certificate_updated_at
    end
  end
end
