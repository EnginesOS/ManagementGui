class CreateCloudLibraries < ActiveRecord::Migration[5.0]
  def change
    create_table :cloud_libraries do |t|
      t.integer :cloud_id
      t.string :name
      t.string :url
      t.timestamps
    end
  end
end
