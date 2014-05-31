module ErHoursHelper
  def association_arrow(checkin_hour)
    return "" if checkin_hour.nil?

    content_tag(:span, class: "association-arrow") do
      " ( #{content_tag(:i, "", class: "icon-arrow-right")} #{checkin_hour.wday_name})" .html_safe
    end
  end
end
