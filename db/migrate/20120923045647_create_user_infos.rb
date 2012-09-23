class CreateUserInfos < ActiveRecord::Migration
  def change
    create_table :user_infos do |t|
      t.boolean :active, default: true
      t.string :punet, null: false, limit: 8 # All PUNetIDs are 4 lastname chars + 4 birthday nums
      t.integer :pu_student_id
      t.integer :strikes, default: 0
      t.boolean :can_reserve, default: true
      t.text :notes
      t.string :password_digest

      t.timestamps
    end
  end
end
