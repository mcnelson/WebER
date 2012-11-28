class AccessoryCategory < Category
  has_many :accessories, dependent: :restrict
end
