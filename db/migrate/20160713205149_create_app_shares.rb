class CreateAppShares < ActiveRecord::Migration[5.0]
  def change
    create_table :app_shares do |t|
      t.integer :user_profile_id
      t.integer :app_id
      t.boolean :accepted
      t.boolean :rejected
      t.boolean :revoked
      t.timestamps
    end
  end
end
