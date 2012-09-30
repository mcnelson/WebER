class Equipment < ActiveRecord::Base
  attr_accessible :active, :brand, :max_reservation_period, :model, :name, :serial, :status, :category_id, :photo
  validates_presence_of :active, :status, :name, :category_id

  belongs_to :category

  has_many :equipment_reservations
  has_many :reservation, through: :equipment_reservations

  has_many :equipment_packages
  has_many :package, through: :equipment_packages

  has_attached_file :photo

  STATUSES = [
    "available",
    "in use",
    "damaged",
    "overdue"
  ]

  def self.formatted_statuses
    self::STATUSES.map { |s| s.capitalize }
  end
end
