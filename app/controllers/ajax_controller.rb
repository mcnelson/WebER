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
    params[:start_at]
    params[:end_at]
    params[:equipment_id]

    respond_to do |fmt|
      fmt.json { render json: { available: true } }
    end
  end

  def equipment_dependencies

  end
end
