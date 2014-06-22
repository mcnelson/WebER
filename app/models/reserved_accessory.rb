class ReservedAccessory < ReservedUnit
  belongs_to :accessory, -> { where(type: "Accessory") }
end
