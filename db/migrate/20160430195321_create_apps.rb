class CreateApps < ActiveRecord::Migration[5.0]
  def change
    create_table :apps do |t|
      t.integer :engines_system_id
      t.string  :name
      t.string  :label
      t.string  :title
      t.string  :icon_file_name
      t.string  :icon_content_type
      t.integer :icon_file_size
      t.string  :icon_updated_at
      t.string  :installer_icon_url
      t.boolean :worker
      t.boolean :show_on_portal
      t.string  :portal_link
      t.text    :portal_worker_message
      t.timestamps
    end
  end
end
