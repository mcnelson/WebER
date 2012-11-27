class DropEquipmentAccessoryAddType < ActiveRecord::Migration
  def up
    change_table :equipment do |t|
      t.remove :accessory
      t.string :type, null: false, default: "Equipment"
    end

    rename_table :equipment, :equipment_bases
  end

  def down
    change_table :equipment do |t|
      t.boolean :accessory
      t.remove :type
    end

    rename_table :equipment_bases, :equipment
  end
end
