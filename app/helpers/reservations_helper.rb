module ReservationsHelper
  def unit_row_image_tag(form_builder)
    return form_builder.object.unit.photo.url(:forty) if form_builder.object.unit.present?
    "/assets/noimage.jpg"
  end

  def reservation_row_status(status)
    color = Reservation::STATUS_BOOTSTRAP_COLORS[Reservation::STATUSES.index(status)]
    label_class = (color) ? "label label-#{color}" : ""
    content_tag :span, status.capitalize, class: label_class
  end

  # Outputs JSON data for all valid dates in the given date's semester
  def valid_er_hour_days(date)
    semester = Semester.around_date(date).first

    days = []
    semester.starts_at.upto(semester.ends_at) do |idate|
      days << idate.strftime("%d/%m/%Y") unless semester.er_hour_on_day(idate).nil?
    end

    days.to_json
  end
end
