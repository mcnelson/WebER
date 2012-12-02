class Admin::AccessoriesController < AdminController

  def show
    @accessory = Accessory.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @accessory}
    end
  end

  def new
    @accessory = Accessory.new

    respond_to do |format|
      format.html
      format.json { render json: @accessory }
    end
  end

  def edit
    @accessory = Accessory.find(params[:id])
  end

  def create
    @accessory = Accessory.new(params[:accessory])

    respond_to do |format|
      if @accessory.save
        format.html { redirect_to [:admin, @accessory], notice: 'Accessory was successfully created.' }
        format.json { render json: @accessory, status: :created, location: @accessory }
      else
        format.html { render action: "new" }
        format.json { render json: @accessory.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @accessory = Accessory.find(params[:id])

    respond_to do |format|
      if @accessory.update_attributes(params[:accessory])
        format.html { redirect_to [:admin, @accessory], notice: 'Accessory was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @accessory.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @accessory = Accessory.find(params[:id])
    @accessory.destroy

    respond_to do |format|
      format.html { redirect_to admin_equipment_index_path }
      format.json { head :no_content }
    end
  end
end
