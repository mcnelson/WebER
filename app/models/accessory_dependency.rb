class AccessoryDependency < ActiveRecord::Base
  attr_accessible :accessory_equipment_id, :equipment_id, :optional

  belongs_to :equipment
  belongs_to :accessory_equipment, class_name: "Equipment"

  def optional?
    optional
  end
end
