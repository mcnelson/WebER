class ErHourDayToWday < ActiveRecord::Migration
  def up
    add_column :er_hours, :wday, :integer

    ErHour.all.each do |er_hour|
      er_hour.update_attribute(:wday, er_hour.day.wday)
    end

    change_column :er_hours, :wday, :integer, :null => true

    remove_column :er_hours, :day
  end

  def down
    # One-way
  end
end
