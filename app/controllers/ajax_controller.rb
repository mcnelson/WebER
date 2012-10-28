class AjaxController < ApplicationController
  def reservation_tabbox
    @reservation = Reservation.find params[:reservation_id]
    @category = Category.find params[:category_id]

    render partial: "reservation_tabbox"
  end
end
