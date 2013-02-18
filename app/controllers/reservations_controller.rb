class ReservationsController < ApplicationController
  before_filter :require_student
  before_filter :require_current_semester, only: :new

  helper_method :sort_column, :sort_direction

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
    @reservation = Reservation.new(starts_at: Semester.current.next_er_hour(2.days.from_now).starts_at)
    @reservation.user = current_user
  end

  def create
    @reservation = Reservation.new(params[:reservation], user_id: current_user.id)
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
        if params[:commit] && @reservation.save
          render js: "window.location = '#{reservation_path(@reservation)}';", notice: 'Reservation was successfully created.'
        else
          @reservation.valid?
          render action: "update_form"
        end
      end
    end
  end

  def sort_column
    params[:sort] || "starts_at"
  end

  def sort_direction
    params[:direction] || "desc"
  end
end
