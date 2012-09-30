class AddPermissionLevelToUser < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :permission_level, null: false, limit: 50
    end
  end
end
