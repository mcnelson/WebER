class Accessory < EquipmentBase
  attr_protected :name

  belongs_to :accessory_category, foreign_key: :category_id

  def name
    accessory_category.title
  end
end