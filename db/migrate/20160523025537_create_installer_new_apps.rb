class CreateInstallerNewApps < ActiveRecord::Migration[5.0]
  def change
    create_table :installer_new_apps do |t|
      t.integer :engines_system_id
      t.integer :repository_id
      t.string :label
      t.string :container_name
      t.string :host_name
      t.string :domain_name
      t.string :http_protocol
      t.integer :memory
      t.boolean :license_accept
    end
  end
end
