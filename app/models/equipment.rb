class Equipment < Unit
  attr_accessible :name, :accessory_dependencies_attributes
  validates_presence_of :name

  belongs_to :equipment_category, foreign_key: :category_id

  has_many :accessory_dependencies, dependent: :destroy
  has_many :accessory_categories, through: :accessory_dependencies
  accepts_nested_attributes_for :accessory_dependencies, allow_destroy: true
end
