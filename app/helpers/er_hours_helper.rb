module ErHoursHelper
  def wday_abbreviated(wday)
    Date.parse(Date::DAYNAMES[wday]).strftime("%a").downcase.capitalize
  end

  def association_arrow(checkin_hour)
    return "" if checkin_hour.nil?

    content_tag(:span, class: "association-arrow") do
      " ( #{content_tag(:i, "", class: "icon-arrow-right")} #{wday_abbreviated(checkin_hour.wday)})" .html_safe
    end
  end
end
