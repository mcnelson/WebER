class ReservedAccessory < ReservedUnit
  belongs_to :accessory, conditions: { type: "Accessory" }
end
