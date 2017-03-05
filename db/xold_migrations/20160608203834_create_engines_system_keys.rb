class CreateEnginesSystemKeys < ActiveRecord::Migration[5.0]
  def change
    create_table :engines_system_keys do |t|
      t.integer :engines_system_id
      t.string  :key_file_name
      t.string  :key_content_type
      t.integer :key_file_size
      t.string  :key_updated_at
    end
  end
end
