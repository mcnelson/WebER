class RenameUserInfosToUsers < ActiveRecord::Migration
  def change
    rename_table :user_infos, :users
  end
end
