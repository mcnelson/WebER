class Admin::AccessoryCategoriesController < AdminController
  def edit
    @category = AccessoryCategory.find(params[:id])
    render "admin/categories/edit"
  end

  def create
    @category = AccessoryCategory.new(accessory_params)

    if @category.save
      redirect_to admin_categories_path, flash: {success: 'Accessory category was successfully created.'}
    else
      render "admin/categories/edit"
    end
  end

  def update
    @category = AccessoryCategory.find(params[:id])

    if @category.update_attributes(accessory_params)
      redirect_to admin_categories_path, flash: {success: 'Accessory category was successfully updated.'}
    else
      render "admin/categories/edit"
    end
  end

  private

  def accessory_params
    params.
      require(:accessory_category).
      permit(:title)
  end
end
