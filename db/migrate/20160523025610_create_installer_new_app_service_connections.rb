class CreateInstallerNewAppServiceConnections < ActiveRecord::Migration[5.0]
  def change
    create_table :installer_new_app_service_connections do |t|
      t.integer :engines_system_id
      t.integer :new_app_id
      t.string :publisher_namespace
      t.string :type_path
      t.string :create_type
      t.string :existing_service
      t.string :orphan_service
      t.string :existing_service
      t.string :orphan_service
    end
  end
end
