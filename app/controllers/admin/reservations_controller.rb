class Admin::ReservationsController < AdminController
  before_filter :require_current_semester, only: %w(new create)

  def index
    @reservations = Reservation.joins(:user).tap do |r|
      if sort_column == "user"
        r = r.order("users.punet #{sort_direction}")
      else
        r = r.order("#{sort_column} #{sort_direction}")
      end
    end.page(params[:page])
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
        if @reservation.save!
          redirect_to [:admin, @reservation], notice: 'Reservation was successfully created.'
        else
          render action: "new"
        end
      end

      format.js do
        if @reservation.fully_valid?
          @reservation.save!

          render js: "window.location = '#{admin_reservation_path(@reservation)}';",
            notice: 'Reservation was successfully created.'
        else
          render action: "update_form"
        end
      end
    end
  end

  def update
    @reservation = Reservation.find(params[:id])

    respond_to do |fmt|
      fmt.html do
        if @reservation.update_attributes(reservation_params)
          redirect_to [:admin, @reservation], notice: 'Reservation was successfully updated.'
        else
          render action: "edit"
        end
      end

      fmt.js do
        @reservation.assign_attributes(reservation_params)

        if @reservation.fully_valid?
          render js: "window.location = '#{admin_reservation_path(@reservation)}';",
            notice: 'Reservation was successfully updated.'

        else
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
    params.
      require(:reservation).
      permit(
        %w(starts_at ends_at status notes user_id),
        reserved_equipment_attributes: %w(id unit_id _destroy),
        reserved_accessories_attributes: %w(id unit_id _destroy),
      )
  end
end
