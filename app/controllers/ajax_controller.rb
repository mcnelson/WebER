class AjaxController < ApplicationController
  def reservation_tabbox
    @category = Category.find params[:category_id]
    @equipment = @category.equipment.available_in_range(params[:start_at], params[:end_at])

    render partial: "reservation_tabbox"
  end
end
