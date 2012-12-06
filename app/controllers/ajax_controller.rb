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

    json = []

    [params[:equipment], params[:accessories]].flatten.each do |unit_id|
      push = { available: true }
      if Unit.find(equipment_id).in_reservations_in_range_exclusive(params[:start_at], params[:end_at])
        push[:available] = false
      end

      json[unit_id] = push
    end

    respond_to do |fmt|
      fmt.json { render json: json }
    end
  end

  def equipment_dependencies

  end

  private

  def params_missing_any?(array)
    array.each do |element|
      return true if params.has_key? element
    end

    false
  end
end
