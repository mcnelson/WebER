class CreateEquipmentReservations < ActiveRecord::Migration
  def change
    create_table :equipment_reservations do |t|
      t.references :equipment, null: false
      t.references :reservation, null: false

      t.references :package

      t.timestamps
    end
  end
end
