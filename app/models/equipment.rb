class Equipment < ActiveRecord::Base
  attr_accessible :active, :brand, :max_reservation_period, :model, :name, :serial, :status
  validates_presence_of :active, :status, :name, :category

  has_one :category

  STATUSES = [
    "available",
    "in use",
    "damaged",
    "overdue"
  ]
end
