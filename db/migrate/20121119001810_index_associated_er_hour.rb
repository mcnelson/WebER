class IndexAssociatedErHour < ActiveRecord::Migration
  def change
    add_index :er_hours, :associated_hour_id
  end
end
