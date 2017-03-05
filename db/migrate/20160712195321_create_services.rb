class CreateServices < ActiveRecord::Migration[5.0]
  def change
    create_table :services do |t|
      t.integer :engines_system_id
      t.string  :name
      t.string  :title
      t.string  :description
      t.timestamps
    end
  end
end
