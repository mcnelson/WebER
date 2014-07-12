class Admin::AccessoriesController < AdminController
  def show
    @accessory = Accessory.find(params[:id])
  end

  def new
    @accessory = Accessory.new
  end

  def edit
    @accessory = Accessory.find(params[:id])
  end

  def create
    @accessory = Accessory.new(accessory_params)

    if @accessory.save
      redirect_to [:admin, @accessory], notice: 'Accessory was successfully created.'
    else
      render "new"
    end
  end

  def update
    @accessory = Accessory.find(params[:id])

    if @accessory.update_attributes(accessory_params)
      redirect_to [:admin, @accessory], notice: 'Accessory was successfully updated.'
    else
      render "edit"
    end
  end

  def destroy
    @accessory = Accessory.find(params[:id])
    @accessory.destroy

    redirect_to admin_equipment_index_path
  end

  private

  def accessory_params
    params.require(:accessory).permit(%w(
      active status name brand model serial max_reservation_period photo category_id notes type
    ))
  end
end
