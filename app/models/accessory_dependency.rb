class AccessoryDependency < ActiveRecord::Base
  attr_accessible :accessory_category_id, :equipment_id, :optional
  validates_presence_of :accessory_category

  belongs_to :equipment
  belongs_to :accessory_category

  def optional?
    optional
  end
end
