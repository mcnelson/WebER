class EquipmentCategory < Category
  has_many :equipment, conditions: { type: "Equipment" }, dependent: :restrict, foreign_key: :category_id
end
