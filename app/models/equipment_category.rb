class EquipmentCategory < Category
  has_many :equipment, -> { where(type: "Equipment") }, dependent: :restrict_with_error, foreign_key: :category_id
end
