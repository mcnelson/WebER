class SplitReservedUnitsIntoEquipmentAndAccessory < ActiveRecord::Migration
  def change
    add_column :reserved_units, :type, :string, null: false
  end
end
