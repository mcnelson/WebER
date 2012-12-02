class Admin::EquipmentCategoriesController < AdminController
  def edit
    @category = EquipmentCategory.find(params[:id])
    render action: "categories/edit"
  end

  def create
    @category = EquipmentCategory.new(params[:equipment_category])

    if @category.save
      redirect_to admin_categories_path, notice: 'Equipment category was successfully created.'
    else
      render action: "categories/edit"
    end
  end

  def update
    @category = EquipmentCategory.find(params[:id])

    if @category.update_attributes(params[:equipment_category])
      redirect_to admin_categories_path, notice: 'Equipment category was successfully updated.'
    else
      render action: "categories/edit"
    end
  end
end
