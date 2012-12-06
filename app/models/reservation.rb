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
    where("starts_at > ?", start_at.start_of_day)
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

  def others_overlapping(start_at, end_at)
    Reservation.where("id != ?", self.id).where("starts_at >= ? AND ends_at <= ?", start_at, end_at)
  end
end
