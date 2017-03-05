class CreateInstallerRepository < ActiveRecord::Migration[5.0]
  def change
    create_table :installer_repositories do |t|
      t.integer :engines_system_id
      t.text    :blueprint
      t.text    :raw_blueprint
      t.string  :app_label
      t.string  :app_icon_url
      t.string  :repository_url
      t.string  :library_id
    end
  end
end
