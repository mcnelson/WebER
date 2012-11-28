class EquipmentCategory < Category
  has_many :equipment, dependent: :restrict
end
