class Admin::EquipmentController < AdminController
  def index
    @equipment = Unit.joins(:category)

    @equipment = @equipment.where(status: params[:status]) if params[:status].present?
    @equipment = @equipment.where(category_id: params[:category]) if params[:category].present?

    if sort_column == "category"
      @equipment = @equipment.order("categories.title " + sort_direction)
    else
      @equipment = @equipment.order(sort_column + " " + sort_direction)
    end

    @equipment = @equipment.page params[:page]

    respond_to do |format|
      format.html
      format.json { render json: @equipment }
    end
  end

  def show
    @equipment = Equipment.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @equipment }
    end
  end

  def new
    @equipment = Equipment.new

    respond_to do |format|
      format.html
      format.json { render json: @equipment }
    end
  end

  def edit
    @equipment = Equipment.find(params[:id])
  end

  def create
    @equipment = Equipment.new(equipment_params)

    respond_to do |format|
      if @equipment.save
        format.html { redirect_to [:admin, @equipment], notice: 'Equipment was successfully created.' }
        format.json { render json: @equipment, status: :created, location: @equipment }
      else
        format.html { render action: "new" }
        format.json { render json: @equipment.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @equipment = Equipment.find(params[:id])

    respond_to do |format|
      if @equipment.update_attributes(equipment_params)
        format.html { redirect_to [:admin, @equipment], notice: 'Equipment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @equipment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @equipment = Equipment.find(params[:id])
    @equipment.destroy

    respond_to do |format|
      format.html { redirect_to admin_equipment_index_path }
      format.json { head :no_content }
    end
  end

  private

  def sort_column
    params[:sort] || "name"
  end

  def equipment_params
    params.require(:equipment).permit(%w(
      active status name brand model serial max_reservation_period photo category_id notes type
    ))
  end
end
