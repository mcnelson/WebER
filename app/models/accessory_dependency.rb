class AccessoryDependency < ActiveRecord::Base
  attr_accessible :accessory_category_id, :equipment_id, :optional

  belongs_to :equipment
  belongs_to :accessory_category

  def optional?
    optional
  end
end
