class EquipmentReservation < ActiveRecord::Base
  belongs_to :equipment_base, foreign_key: :equipment_id
  belongs_to :reservation

  validates_presence_of :equipment, :reservation

  # Indicates that this equipment was added to the reservation as
  # part of this package.
  belongs_to :package
end
