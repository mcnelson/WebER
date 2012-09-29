class Admin::ReservationsController < AdminController

  def index
    @reservations = Reservation.all

    respond_to do |format|
      format.html
      format.json { render json: @reservations }
    end
  end

  def show
    @reservation = Reservation.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @reservation }
    end
  end

  def new
    @reservation = Reservation.new

    respond_to do |format|
      format.html
      format.json { render json: @reservation }
    end
  end

  def edit
    @reservation = Reservation.find(params[:id])
  end

  def create
    @reservation = Reservation.new(params[:reservation])

    respond_to do |format|
      if @reservation.save
        format.html { redirect_to [:admin, @reservation], notice: 'Reservation was successfully created.' }
        format.json { render json: @reservation, status: :created, location: @reservation }
      else
        format.html { render action: "new" }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @reservation = Reservation.find(params[:id])

    respond_to do |format|
      if @reservation.update_attributes(params[:reservation])
        format.html { redirect_to [:admin, @reservation], notice: 'Reservation was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy

    respond_to do |format|
      format.html { redirect_to admin_reservations_path }
      format.json { head :no_content }
    end
  end
end
