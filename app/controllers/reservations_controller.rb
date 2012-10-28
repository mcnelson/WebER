class ReservationsController < ApplicationController
  before_filter :require_student

  def index
    # Write me
  end

  def new
    @reservation = Reservation.new
  end
end
