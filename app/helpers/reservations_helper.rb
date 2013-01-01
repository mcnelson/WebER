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
end
