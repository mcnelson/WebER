class CreateEquipmentPackages < ActiveRecord::Migration
  def change
    create_table :equipment_packages do |t|
      t.references :equipment, null: false
      t.references :package, null: false

      t.timestamps
    end
  end
end
