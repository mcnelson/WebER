class RenameErHourErHourIdToAssociatedHourId < ActiveRecord::Migration
  def change
    change_table :er_hours do |t|
      t.rename :er_hour_id, :associated_hour_id
    end
  end
end
