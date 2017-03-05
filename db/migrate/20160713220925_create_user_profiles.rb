class CreateUserProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :user_profiles do |t|
      t.integer :user_id
      t.string   :label
      t.string   :text_color, default: '#ffffff'
      t.string   :background_color, default: '#4488dd'
      t.string   :icon_file_name
      t.string   :icon_content_type
      t.integer  :icon_file_size
      t.datetime :icon_updated_at
      t.text     :portal_header
      t.text     :portal_footer
      t.boolean  :portal_center_align
      t.timestamps
    end
  end
end
