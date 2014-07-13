class Admin::EquipmentCategoriesController < AdminController
  def edit
    @category = EquipmentCategory.find(params[:id])
    render "admin/categories/edit"
  end

  def create
    @category = EquipmentCategory.new(category_params)

    if @category.save
      redirect_to admin_categories_path, flash: {success: 'Equipment category was successfully created.'}
    else
      render "admin/categories/edit"
    end
  end

  def update
    @category = EquipmentCategory.find(params[:id])

    if @category.update_attributes(category_params)
      redirect_to admin_categories_path, flash: {success: 'Equipment category was successfully updated.'}
    else
      render "admin/categories/edit"
    end
  end

  private

  def category_params
    params.
      require(:equipment_category).
      permit(:title)
  end
end
