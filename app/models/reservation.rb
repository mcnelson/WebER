class Reservation < ActiveRecord::Base
  attr_accessible :ends_at, :starts_at, :status, :user_id, :equipment_autocomplete, :equipment_attributes, :accessory_reservations

  validates_presence_of :ends_at, :starts_at, :status, :user_id

  validates_associated :user
  belongs_to :user

  has_many :equipment, through: :equipment_reservations
  has_many :equipment_reservations, conditions: {accessory: false}
  has_many :accessory_reservations, conditions: {accessory: true}, class_name: "EquipmentReservation"
  accepts_nested_attributes_for :equipment_reservations, :accessory_reservations

  scope :find_by_range, lambda { |start_at, end_at|
    where("starts_at > ?", start_at)
      .where("ends_at < ?", end_at)
  }

  STATUSES = [
    "live",
    "pending",
    "archived",
    "missed"
  ]

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

  def self.formatted_statuses
    STATUSES.map { |s| s.capitalize }
  end

  def contains?(equipment)
    equipment.exists? equipment
  end
end
