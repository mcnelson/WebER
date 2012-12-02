class EquipmentCategory < Category
  has_many :equipment, dependent: :restrict, foreign_key: :category_id
end
