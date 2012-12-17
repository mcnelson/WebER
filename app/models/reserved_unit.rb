class ReservedUnit < ActiveRecord::Base
  attr_accessible :unit_id, :reservation_id
  validates_presence_of :unit_id, :reservation_id

  belongs_to :unit
  belongs_to :reservation

  # Indicates that this equipment was added to the reservation as
  # part of this package.
  belongs_to :package
end
