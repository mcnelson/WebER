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
end
