class Admin::AccessoryCategoriesController < AdminController
  def edit
    @category = AccessoryCategory.find(params[:id])
    render action: "categories/edit"
  end

  def create
    @category = AccessoryCategory.new(params[:accessory_category])

    if @category.save
      redirect_to admin_categories_path, notice: 'Accessory category was successfully created.'
    else
      render action: "categories/edit"
    end
  end

  def update
    @category = AccessoryCategory.find(params[:id])

    if @category.update_attributes(params[:accessory_category])
      redirect_to admin_categories_path, notice: 'Accessory category was successfully updated.'
    else
      render action: "categories/edit"
    end
  end
end
