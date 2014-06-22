class Admin::ReservationsController < AdminController
  before_filter :require_current_semester, only: :new

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
    @reservation = current_user.reservations.build
  end

  def edit
    @reservation = Reservation.find(params[:id])
  end

  def create
    @reservation = Reservation.new(reservation_params)

    respond_to do |format|
      format.html do
        require 'pry'; binding.pry;
        if @reservation.save!
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

          render js: "window.location = '#{admin_reservation_path(@reservation)}';",
            notice: 'Reservation was successfully created.'
        else
          @reservation.valid?
          render action: "update_form"
        end
      end
    end
  end

  def update
    @reservation = Reservation.find(params[:id])
    @reservation.assign_attributes(reservation_params)

    respond_to do |format|
      format.html do
        if @reservation.save(reservation_params)
          redirect_to [:admin, @reservation], notice: 'Reservation was successfully updated.'
        else
          render action: "edit"
        end
      end

      format.js do
        if params[:commit] && @reservation.save(reservation_params)
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

  private

  def sort_column
    params[:sort] || "starts_at"
  end

  def reservation_params
    params.require(:reservation).permit(%w(starts_at ends_at status notes user_id))
  end
end
