class ChangeDateToDateTime < ActiveRecord::Migration
  def change
    change_column :reservations, :starts_at, :datetime, null: false
    change_column :reservations, :ends_at, :datetime, null: false
  end
end
