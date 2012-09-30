class CreatePackages < ActiveRecord::Migration
  def change
    create_table :packages do |t|
      t.string :title, null: false, limit: 200
      t.integer :max_reservation_period

      t.references :user, null: false

      t.timestamps
    end
  end
end
