class ChangeAccessoryDependencyToUseAccessoryCategory < ActiveRecord::Migration
  def change
    rename_column :accessory_dependencies, :accessory_equipment_id, :accessory_category_id
  end
end
