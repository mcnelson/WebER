class RenameErHourAssociatedHourToCheckIn < ActiveRecord::Migration
  def change
    rename_column :er_hours, :associated_hour_id, :checkin_hour_id
  end
end
