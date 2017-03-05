class CreateEnginesSystemActivitySnapshots < ActiveRecord::Migration[5.0]
  def change
    create_table :engines_system_activity_snapshots do |t|
      t.integer :engines_system_id
      t.text :engines_memory
      t.text :services_memory
      t.text :containers_memory
      t.text :system_memory
      t.text :cpu_load
      t.text :cpu_queue
      t.text :disks
      t.text :network
    end
  end
end
