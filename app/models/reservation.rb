class Reservation < ActiveRecord::Base
  include ActionView::Helpers # Wah wah wahhhh

  attr_accessible :ends_at, :starts_at, :status, :user_id, :reserved_equipment_attributes, :reserved_accessories_attributes

  validates_presence_of :ends_at, :starts_at, :status, :user_id

  validate :equipment_or_accessory
  validate :lead_time, on: :create
  validate :units_max_period, on: :create
  validate :conflicting_units

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

  scope :between, lambda { |lower, upper|
    where("starts_at > ? AND ends_at < ?", lower, upper)
  }

  scope :overlapping, lambda { |lower, upper|
    where("(starts_at >= ? AND ends_at <= ?)
          OR (starts_at < ? AND ? < ends_at)
          OR (starts_at < ? AND ? < ends_at)",
          lower, upper,
          lower, lower,
          upper, upper)
  }

  scope :containing_unit, lambda { |unit|
    joins(:reserved_units)
    where({ reserved_units: { unit_id: unit.id } })
  }

  after_initialize :defaults

  STATUSES = ["live", "pending", "archived", "missed"]
  STATUS_BOOTSTRAP_COLORS = ["info", "warning", "", "default"]

  def defaults
    self.status     ||= STATUSES.first
    self.starts_at  ||= Semester.current.next_er_hour(Date.today).date
    self.ends_at    ||= Semester.current.next_er_hour(Date.today + 2.days).date
  end

  def equipment_or_accessory
    if reserved_equipment.blank? && reserved_accessories.blank?
      errors[:base] << "Reservation must have at least one equipment unit or accessory."
    end
  end

  def lead_time
    # Use er hour time to now to afford the possiblity of using more granular time in config
    given_lead_time = (Semester.current.to_er_hour_start(starts_at) - DateTime.now).abs

    # start date less than minimum lead time
    if (given_lead_time < Weber::Application.config.reservation_min_lead_time)
      errors[:starts_at] << "must be at least #{distance_of_time_in_words(Weber::Application.config.reservation_min_lead_time)} from now"

    # start date greater than max lead time
    elsif (given_lead_time > Weber::Application.config.reservation_max_lead_time)
      errors[:starts_at] << "must be no more than #{distance_of_time_in_words(Weber::Application.config.reservation_max_lead_time)} from now"
    end
  end

  def units_max_period
    units.each do |unit|
      if (start_at.to_i - end_at.to_i).abs > unit.max_reservation_period
        unit.errors[:base] << "cannot be reserved for more than #{distance_of_time_in_words(unit.max_reservation_period)}"
      end
    end
  end

  def conflicting_units
    units.each do |unit|
      overlapping_reservations = unit.
        in_reservations_in_range_exclusive(starts_at, ends_at).
        where("reservations.id != ?", id)

      if overlapping_reservations.any?
        unit.errors[:base] << "conflicts with #{pluralize(overlapping_reservations.count, "reservation")}"
      end
    end
  end

  def contains?(equipment)
    equipment.exists? equipment
  end
end
