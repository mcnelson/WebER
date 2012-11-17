class SplitCategoriesIntoEquipmentAndAccessory < ActiveRecord::Migration
  def change
    add_column :categories, :type, :string, null: false, default: "EquipmentCategory"
  end
end
