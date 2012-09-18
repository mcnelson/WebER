class CreateErHours < ActiveRecord::Migration
  def change
    create_table :er_hours do |t|
      t.time :starts_at, null: false
      t.time :ends_at, null: false
      t.string :day, null: false, limit: 3

      t.references :semester, null: false
      t.references :er_hour

      t.timestamps
    end
  end
end
