class MakeUniqueColsUnique < ActiveRecord::Migration
  def up
    add_index :users, :pu_student_id, unique: true
    add_index :users, :punet, unique: true
    add_index :users, :email, unique: true
  end
end
