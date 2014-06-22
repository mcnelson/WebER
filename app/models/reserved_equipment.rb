class ReservedEquipment < ReservedUnit
  belongs_to :equipment, -> { where(type: "Equipment") }
end
