class EquipmentCategory < Category
  has_many :equipment, foreign_key: :category_id, conditions: { accessory: false }, dependent: :restrict
end
