class AddEmailToUserInfos < ActiveRecord::Migration
  def change
    change_table :user_infos do |t|
      t.string :email, null: false
    end
  end
end
