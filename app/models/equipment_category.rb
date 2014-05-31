class EquipmentCategory < Category
  has_many :equipment, conditions: { type: "Equipment" }, dependent: :restrict_with_error, foreign_key: :category_id
end
