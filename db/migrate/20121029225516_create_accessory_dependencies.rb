class CreateAccessoryDependencies < ActiveRecord::Migration
  def change
    create_table :accessory_dependencies do |t|
      t.integer :equipment_id, null: false
      t.integer :accessory_equipment_id, null: false
      t.boolean :optional, null: false, default: false

      t.timestamps
    end
  end
end
