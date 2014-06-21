class AdjustUserPermissionLevel < ActiveRecord::Migration
  def change
    remove_column :users, :permission_level
    add_column :users, :permission_level, :integer, null: false, default: 2
    change_column :users, :permission_level, :integer, null: false, default: 0
  end
end
