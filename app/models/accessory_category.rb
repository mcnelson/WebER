class AccessoryCategory < Category
  has_many :equipment, foreign_key: :category_id, conditions: { accessory: true }, dependent: :restrict
end
