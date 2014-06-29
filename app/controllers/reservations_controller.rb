class ReservationsController < ApplicationController
  before_filter :require_student
  before_filter :require_current_semester, only: :new

  def index
    @all_reservations = current_user.reservations.
      order(sort_column + " " + sort_direction).
      page params[:page]

    @due_reservations = current_user.reservations.
      where("ends_at > ? AND ends_at < ?", Date.today, Date.today + 2.days).
      order("ends_at ASC").
      limit(5)
  end

  def show
    @reservation = current_user.reservations.find(params[:id])
  end

  def new
    @reservation = current_user.reservations.build
  end

  def create
    @reservation = Reservation.new(reservation_params, user_id: current_user.id)
    @reservation.user = current_user

    respond_to do |format|
      format.html do
        if @reservation.save
          redirect_to @reservation, notice: 'Reservation was successfully created.'
        else
          render action: "new"
        end
      end

      format.js do
        if params[:commit]
          @reservation.save!

          render js: "window.location = '#{reservation_path(@reservation)}';", notice: 'Reservation was successfully created.'
        else
          @reservation.valid_dates?
          render action: "update_form"
        end
      end
    end
  end

  private

  def sort_column
    params[:sort] || "starts_at"
  end

  def reservation_params
    params.
      require(:reservation).
      permit(
        %w(starts_at ends_at status notes user_id),
        reserved_equipment_attributes: %w(unit_id _destroy),
        reserved_accessories_attributes: %w(unit_id _destroy),
      )
  end
end
