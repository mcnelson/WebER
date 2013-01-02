class Admin::ReservationsController < AdminController
  helper_method :sort_column, :sort_direction

  def index
    @reservations = Reservation.joins(:user)

    if sort_column == "user"
      @reservations = @reservations.order("users.punet" + sort_direction)
    else
      @reservations = @reservations.order(sort_column + " " + sort_direction)
    end

    @reservations = Reservation.page params[:page]
  end

  def show
    @reservation = Reservation.find(params[:id])
  end

  def new
    @reservation = Reservation.new
  end

  def edit
    @reservation = Reservation.find(params[:id])
  end

  def create
    @reservation = Reservation.new(params[:reservation])

    respond_to do |format|
      format.html do
        if @reservation.save
          redirect_to [:admin, @reservation], notice: 'Reservation was successfully created.'
        else
          render action: "new"
        end
      end

      format.js { @reservation.valid? }
    end
  end

  def update
    @reservation = Reservation.find(params[:id])

    if @reservation.update_attributes(params[:reservation])
      redirect_to [:admin, @reservation], notice: 'Reservation was successfully updated.'
    else
      render action: "edit"
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
