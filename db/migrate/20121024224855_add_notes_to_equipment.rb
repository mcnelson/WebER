class AddNotesToEquipment < ActiveRecord::Migration
  def change
    change_table :equipment do |t|
      t.text :notes
    end
  end
end
