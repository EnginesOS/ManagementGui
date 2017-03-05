class CreateInstallerNewAppEnvironmentVariables < ActiveRecord::Migration[5.0]
  def change
    create_table :installer_new_app_environment_variables do |t|
      t.integer :engines_system_id
      t.integer :new_app_id
      t.boolean :ask_at_build_time
      t.boolean :build_time_only
    end
  end
end
