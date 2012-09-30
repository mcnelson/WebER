class Reservation < ActiveRecord::Base
  attr_accessible :ends_at, :starts_at, :status
  validates_presence_of :ends_at, :starts_at, :status, :user

  belongs_to :user

  has_many :equipment, through: :equipment_reservations, dependent: :restrict

  STATUSES = [
    "live",
    "pending",
    "archived",
    "missed"
  ]
end
