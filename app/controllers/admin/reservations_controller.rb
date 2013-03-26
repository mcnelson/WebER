class Admin::ReservationsController < AdminController
  helper_method :sort_column, :sort_direction
  before_filter :require_current_semester, only: :new

  helper LaterDude::CalendarHelper

  def index
    @reservations = Reservation.joins(:user)

    if sort_column == "user"
      @reservations = @reservations.order("users.punet" + sort_direction)
    else
      @reservations = @reservations.order(sort_column + " " + sort_direction)
    end

    @reservations = @reservations.page params[:page]
  end

  def show
    @reservation = Reservation.find(params[:id])
  end

  def new
    @reservation = Reservation.new(
      starts_at: Semester.current.next_er_hour(2.days.from_now).starts_at,
      user_id: current_user.id
    )
  end

  def edit
    @reservation = Reservation.find(params[:id])
  end

  def create # TODO: Make functional
    @reservation = Reservation.new(params[:reservation])

    respond_to do |format|
      format.html do
        if @reservation.save
          redirect_to [:admin, @reservation], notice: 'Reservation was successfully created.'
        else
          render action: "new"
        end
      end

      format.js do
        if params[:commit] && @reservation.save
          @reservation.invalid_override = true
          @reservation.valid?
          @reservation.save!

          render js: "window.location = '#{admin_reservation_path(@reservation)}';", notice: 'Reservation was successfully created.'
        else
          @reservation.valid?
          render action: "update_form"
        end
      end
    end
  end

  def update
    @reservation = Reservation.find(params[:id])
    @reservation.assign_attributes(params[:reservation])

    respond_to do |format|
      format.html do
        if @reservation.save(params[:reservation])
          redirect_to [:admin, @reservation], notice: 'Reservation was successfully updated.'
        else
          render action: "edit"
        end
      end

      format.js do
        if params[:commit] && @reservation.save(params[:reservation])
          render js: "window.location = '#{admin_reservation_path(@reservation)}';", notice: 'Reservation was successfully updated.'
        else
          @reservation.valid?
          render action: "update_form"
        end
      end
    end
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy

    redirect_to admin_reservations_path
  end

  def sort_column
    params[:sort] || "starts_at"
  end

  def sort_direction
    params[:direction] || "desc"
  end
end
