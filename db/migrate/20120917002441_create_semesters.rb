class CreateSemesters < ActiveRecord::Migration
  def change
    create_table :semesters do |t|
      t.date :starts_at, null: false
      t.date :ends_at, null: false

      t.timestamps
    end
  end
end
