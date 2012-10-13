class Admin::EquipmentController < AdminController
  helper_method :sort_column, :sort_direction

  def index
    @equipment = Equipment.joins(:category)

    @equipment = @equipment.where(status: params[:status]) if params[:status].present?
    @equipment = @equipment.where(category_id: params[:category]) if params[:category].present?

    @equipment = @equipment.order(sort_column + " " + sort_direction)

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
    @equipment = Equipment.new(params[:equipment])

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
      if @equipment.update_attributes(params[:equipment])
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

  def sort_column
    params[:sort] || "name"
  end

  def sort_direction
    params[:direction] || "asc"
  end
end
