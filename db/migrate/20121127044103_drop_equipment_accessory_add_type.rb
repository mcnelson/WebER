class DropEquipmentAccessoryAddType < ActiveRecord::Migration
  def up
    change_table :equipment do |t|
      t.remove :accessory
      t.string :type, null: false, default: "Equipment"
    end
  end

  def down
    change_table :equipment do |t|
      t.boolean :accessory
      t.remove :type
    end
  end
end
