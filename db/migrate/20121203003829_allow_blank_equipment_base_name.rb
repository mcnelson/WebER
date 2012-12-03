class AllowBlankEquipmentBaseName < ActiveRecord::Migration
  def up
    change_column :equipment_bases, :name, :string, null: true, limit: 100
  end

  def down
    change_column :equipment_bases, :name, :string, null: false, limit: 100
  end
end
