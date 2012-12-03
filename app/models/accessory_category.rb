class AccessoryCategory < Category
  has_many :accessories, conditions: { type: "Accessory" }, dependent: :restrict, foreign_key: :category_id
end
