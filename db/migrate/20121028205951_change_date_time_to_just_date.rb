class ChangeDateTimeToJustDate < ActiveRecord::Migration
  def change
    change_column :reservations, :starts_at, :date, null: false
    change_column :reservations, :ends_at, :date, null: false
  end
end
