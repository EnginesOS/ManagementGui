class CreateAppEnvironmentVariables < ActiveRecord::Migration[5.0]
  def change
    create_table :app_environment_variables do |t|
      t.integer :engines_system_id
      t.integer :app_id
      t.boolean :ask_at_build_time
      t.boolean :build_time_only
    end
  end
end
