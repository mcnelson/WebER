module ApplicationHelper
  def weekdays_for_select
    Date::DAYNAMES.zip( Date::DAYNAMES.map { |d| d.downcase[0..2] } )
  end
end
