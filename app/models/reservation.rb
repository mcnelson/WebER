class Reservation < ActiveRecord::Base
  attr_accessible :ends_at, :starts_at, :status, :user_id, :equipment_attributes, :accessory_reservations

  validates_presence_of :ends_at, :starts_at, :status, :user_id

  validates_associated :user
  belongs_to :user

  has_many :reserved_units
  has_many :units, through: :reserved_units

  # Join models for equipment/accessory
  has_many :reserved_equipment, class_name: "ReservedUnit", foreign_key: :reservation_id,
    conditions: { units: { type: "Equipment" } }

  has_many :reserved_accessories, class_name: "ReservedUnit", foreign_key: :reservation_id,
    conditions: { units: { type: "Accessory" } }

  # Units as equipment/accessories via reserved_units
  has_many :equipment, through: :reserved_units, foreign_key: :unit_id,
    class_name: "Equipment", source: :unit

  has_many :accessories, through: :reserved_units, foreign_key: :unit_id,
    class_name: "Accessory", source: :unit

  accepts_nested_attributes_for :reserved_equipment, :reserved_accessories

  scope :between, lambda { |start_at, end_at|
    where("starts_at > ?", start_at.beginning_of_day)
    where("ends_at < ?",   end_at.end_of_day)
  }

  after_initialize :defaults

  STATUSES = [
    "live",
    "pending",
    "archived",
    "missed"
  ]

  def defaults
    self.status ||= STATUSES.first

    # TODO: Make this find next available ERHour
    self.starts_at ||= Date.today
    self.ends_at ||= 1.days.from_now
  end

  def contains?(equipment)
    equipment.exists? equipment
  end

  def others_overlapping(start_at, end_at)
    Reservation.where("id != ?", self.id).where("starts_at >= ? AND ends_at <= ?", start_at, end_at)
  end
end
