class ReservedEquipment < ReservedUnit
  belongs_to :equipment, conditions: { type: "Equipment" }
end
