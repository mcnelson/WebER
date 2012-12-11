class AccurizeModelNaming < ActiveRecord::Migration
  def change
    # Yikes
    rename_table :equipment_bases, :units

    rename_table :equipment_packages, :packages_units
    rename_table :equipment_reservations, :reserved_units

    # equipment_id --> unit_id everywhere
    rename_column :accessory_dependencies, :equipment_id, :unit_id
    rename_column :packages_units, :equipment_id, :unit_id
    rename_column :reserved_units, :equipment_id, :unit_id
  end
end
