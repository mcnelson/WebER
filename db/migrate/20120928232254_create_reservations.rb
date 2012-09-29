class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.datetime :starts_at, null:false
      t.datetime :ends_at, null: false
      t.string :status, null: false, limit: 30
      t.text :notes

      t.references :user, null: false

      t.timestamps
    end
  end
end
