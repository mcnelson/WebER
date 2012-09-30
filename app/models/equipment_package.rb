class EquipmentPackage < ActiveRecord::Base
  belongs_to :equipment
  belongs_to :package
end
