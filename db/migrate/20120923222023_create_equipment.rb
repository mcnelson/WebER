class CreateEquipment < ActiveRecord::Migration
  def change
    create_table :equipment do |t|
      t.boolean :active, null: false, default: true
      t.string :status, null: false, limit: 20
      t.string :name, null: false, limit: 100
      t.string :brand, limit: 100
      t.string :model, limit: 100
      t.string :serial, limit: 100
      t.integer :max_reservation_period

      t.attachment :photo

      t.references :category

      t.timestamps
    end
  end
end
