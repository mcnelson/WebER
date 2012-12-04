class ReservedUnit < ActiveRecord::Base
  belongs_to :unit
  belongs_to :reservation

  validates_presence_of :unit, :reservation

  # Indicates that this equipment was added to the reservation as
  # part of this package.
  belongs_to :package
end
