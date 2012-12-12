class Admin::ReservationsController < AdminController

  def index
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

    if @reservation.save
      redirect_to [:admin, @reservation], notice: 'Reservation was successfully created.'
    else
      render action: "new"
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
end
