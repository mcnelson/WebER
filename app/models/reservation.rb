class Reservation < ActiveRecord::Base
  attr_accessible :ends_at, :starts_at, :status, :user_id, :reserved_equipment_attributes, :reserved_accessories_attributes

  validates_presence_of :ends_at, :starts_at, :status, :user_id
  validate :equipment_or_accessory

  validates_associated :user
  belongs_to :user

  has_many :reserved_units, dependent: :destroy
  has_many :reserved_equipment
  has_many :reserved_accessories
  has_many :units, through: :reserved_units

  # Units as equipment/accessories via reserved_units
  has_many :equipment, through: :reserved_equipment, foreign_key: :unit_id,
    class_name: "Equipment", source: :unit

  has_many :accessories, through: :reserved_accessories, foreign_key: :unit_id,
    class_name: "Accessory", source: :unit

  accepts_nested_attributes_for :reserved_equipment, :reserved_accessories, allow_destroy: true

  scope :between, lambda { |start_at, end_at|
    where("starts_at > ?", start_at.beginning_of_day)
    where("ends_at < ?",   end_at.end_of_day)
  }

  scope :containing_unit, lambda { |unit|
    joins(:reserved_units)
    where({ reserved_units: { unit_id: unit.id } })
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

    current_semester = Semester.current
    self.starts_at = current_semester.next_er_hour(Date.today).day
    self.ends_at   = current_semester.next_er_hour(starts_at + 2.days).day
  end

  def equipment_or_accessory
    if reserved_equipment.blank? && reserved_accessories.blank?
      errors[:base] << "Reservation must have at least one equipment unit or accessory."
    end
  end

  def contains?(equipment)
    equipment.exists? equipment
  end

  def others_overlapping(start_at, end_at)
    Reservation.where("id != ?", self.id).where("starts_at >= ? AND ends_at <= ?", start_at, end_at)
  end
end
