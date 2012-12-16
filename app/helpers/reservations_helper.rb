module ReservationsHelper
  def unit_row_image_tag(form_builder)
    return form_builder.object.unit.photo.url(:forty) if form_builder.object.unit.present?
    "/assets/noimage.jpg"
  end
end
