class AjaxController < ApplicationController
  def reservation_tabbox
    return if params[:start_at].blank? || params[:end_at].blank?

    @available = []
    @unavailable = []

    @category = Category.find params[:category_id]
    @equipment = @category.equipment.each do |equipment|
      if equipment.available_in_range?(params[:start_at], params[:end_at])
        @available << equipment
      else
        @unavailable << equipment
      end
    end

    render partial: "reservation_tabbox"
  end

  def check_unit_availability
    return render nothing: true if params_missing_any? [:start_at, :end_at]

    start_at = params[:start_at].to_date
    end_at = params[:end_at].to_date

    json = []

    (params[:equipment].to_a + params[:accessories].to_a).each.map { |n| n.to_i } .each do |unit_id|
      if (unit = Unit.find(unit_id))
        json << {
          id:         unit.id,
          available:  unit.in_reservations_in_range_exclusive(start_at, end_at).empty?,
          thumb:      unit.photo.url(:forty),
          medium:     unit.photo.url(:twosixty)
        }
      end
    end

    respond_to do |fmt|
      fmt.json { render json: json }
    end
  end

  def equipment_dependencies

  end

  private

  def params_missing_any?(array)
    array.each { |v| return true unless params.has_key? v }

    false
  end
end
