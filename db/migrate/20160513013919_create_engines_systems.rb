class CreateEnginesSystems < ActiveRecord::Migration[5.0]
  def change
    create_table :engines_systems do |t|
      t.integer :cloud_id
      t.string   :label
      t.string   :url
      t.text   :token
      t.timestamps
    end
  end
end
