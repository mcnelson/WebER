class AccessoryCategory < Category
  has_many :accessories, -> { where(type: "Accessory") }, dependent: :restrict_with_error, foreign_key: :category_id
end
