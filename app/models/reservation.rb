class Reservation < ActiveRecord::Base
  attr_accessible :ends_at, :starts_at, :status, :user_id, :equipment_attributes, :accessory_reservations

  validates_presence_of :ends_at, :starts_at, :status, :user_id

  validates_associated :user
  belongs_to :user

  has_many :equipment_reservations, conditions: { equipment: { type: "Equipment" } }

  # This is a virtual association, same thing as equipment reservations but only for accessories
  has_many :accessory_reservations, class_name: "EquipmentReservation", foreign_key: :reservation_id,
    conditions: { equipment: { type: "Accessory" } }

  has_many :equipment_bases, through: :equipment_reservations, source: :equipment_base
  has_many :equipment, through: :equipment_reservations, foreign_key: :equipment_id, class_name: "Equipment", source: :equipment_base
  has_many :accessories, through: :equipment_reservations, foreign_key: :equipment_id, class_name: "Accessory", source: :equipment_base
  accepts_nested_attributes_for :equipment_reservations, :accessory_reservations

  scope :find_by_range, lambda { |start_at, end_at|
    where("starts_at > ?", start_at)
      .where("ends_at < ?", end_at)
  }

  after_initialize :default_status

  STATUSES = [
    "live",
    "pending",
    "archived",
    "missed"
  ]

  def default_status
    self.status ||= STATUSES.first
  end

  def earliest_starts_at
    Semester.around_date(starts_at).er_hour_around(starts_at).starts_at
  end

  def latest_starts_at
    Semester.around_date(starts_at).er_hour_around(starts_at).ends_at
  end

  def earliest_ends_at
    Semester.around_date(starts_at).er_hour_around(ends_at).starts_at
  end

  def latest_ends_at
    Semester.around_date(starts_at).er_hour_around(ends_at).ends_at
  end

  def contains?(equipment)
    equipment.exists? equipment
  end
end
