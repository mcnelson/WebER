class Admin::CategoriesController < AdminController
  def index
    @equipment_categories = EquipmentCategory.order(:title).all
    @new_equipment_category = EquipmentCategory.new

    @accessory_categories = AccessoryCategory.order(:title).all
    @new_accessory_category = AccessoryCategory.new
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy

    redirect_to admin_categories_path
  end
end
