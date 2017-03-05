class CreateClouds < ActiveRecord::Migration[5.0]
  def change
    create_table :clouds do |t|
      t.integer :user_profile_id
      t.string   :label
      t.string   :admin_banner
      t.string   :text_color, default: '#4488dd'
      t.string   :background_color, default: '#ffffff'
      t.string   :icon_file_name
      t.string   :icon_content_type
      t.integer  :icon_file_size
      t.datetime :icon_updated_at
      t.text     :portal_header
      t.text     :portal_footer
      t.boolean  :portal_center_align
      t.boolean  :show_on_portal
      t.boolean  :show_services
      t.timestamps
    end
  end
end
