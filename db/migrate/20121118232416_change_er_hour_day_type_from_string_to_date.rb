class ChangeErHourDayTypeFromStringToDate < ActiveRecord::Migration
  def up
    rename_column :er_hours, :day, :day_old
    add_column :er_hours, :day, :date

    ErHour.all.each do |er_hour|
      new_date = Date.parse(er_hour.day_old)

      if new_date.strftime("%a").downcase == er_hour.day_old
        er_hour.day = new_date
        er_hour.save!
      else
        puts "no"
      end
    end

    remove_column :er_hours, :day_old
  end

  def down
    # one way
  end
end
