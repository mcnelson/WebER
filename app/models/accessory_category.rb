class AccessoryCategory < Category
  has_many :accessories, dependent: :restrict, foreign_key: :category_id
end
