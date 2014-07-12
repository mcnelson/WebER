class Reservation < ActiveRecord::Base
  SemesterMissingError = Class.new(StandardError)
  ErHourMissingError = Class.new(StandardError)
  include ActionView::Helpers::DateHelper

  validates :starts_at, :ends_at, :status, :user_id, presence: true

  # Run date-related validations on create only, allowing admins to backdate stuff
  # via update
  validate :date_chronology, on: :create
  validate :lead_time, on: :create

  validate :units_max_period
  validate :conflicting_reservations
  validate :equipment_or_accessory

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
  after_find :verify_containing_semester_present

  STATUSES = ["live", "pending", "archived", "missed"]
  STATUS_BOOTSTRAP_COLORS = ["info", "warning", "", "default"]

  def defaults
    self.status ||= STATUSES.first
  end

  def duration
    ends_at - starts_at
  end

  def verify_containing_semester_present
    if starts_at && Semester.around_date(starts_at).blank?
      raise SemesterMissingError, "date #{starts_at} is not contained by any semester"
    end

    if ends_at && Semester.around_date(ends_at).blank?
      raise SemesterMissingError, "date #{ends_at} is not contained by any semester"
    end
  end

  def equipment_or_accessory
    if reserved_equipment.blank? && reserved_accessories.blank?
      errors[:base] << "Reservation must have at least one equipment unit or accessory."
    end
  end

  def date_chronology
    errors[:starts_at] << "must be in the future" if starts_at && starts_at < Date.today
    errors[:ends_at] << "must be after the check-out date" if starts_at && ends_at && starts_at >= ends_at
  end

  def lead_time
    return unless starts_at

    min_lead_time = Weber::Application.config.reservation_min_lead_time
    max_lead_time = Weber::Application.config.reservation_max_lead_time

    min_starting_point = min_lead_time.from_now.at_beginning_of_day
    max_starting_point = max_lead_time.from_now.at_beginning_of_day

    if (starts_at < min_starting_point)
      errors[:starts_at] << "must be at least #{distance_of_time_in_words(min_lead_time)} from now"

    elsif (starts_at >= max_starting_point)
      errors[:starts_at] << "must be no more than #{distance_of_time_in_words(max_lead_time)} from now"
    end
  end

  def units_max_period
    return unless starts_at && ends_at

    units.each do |unit|
      if duration > unit.max_reservation_period
        unit.errors[:base] <<
          "cannot be reserved for more than #{distance_of_time_in_words(unit.max_reservation_period)}"
      end
    end
  end

  def conflicting_reservations
    conflicting_reserved_units.each do |reserved_unit|
      errors[:base] << "#{reserved_unit[:name]} is already reserved within your requested dates"
    end
  end

  def conflicting_reserved_units
    ids = (reserved_equipment + reserved_accessories).map(&:unit_id)

    relation = ReservedUnit.
      select("reserved_units.id, units.name").
      joins(:reservation, :unit).
      where(unit_id: ids).
      where("(starts_at >= ? AND ends_at <= ?)
        OR (starts_at <= ? AND ? < ends_at)
        OR (starts_at < ? AND ? < ends_at)",
        starts_at, ends_at,
        starts_at, starts_at,
        ends_at, ends_at
      )

    relation = relation.where("reserved_units.reservation_id != ?", id) if id
    relation.map { |ru| ru.attributes.with_indifferent_access }
  end

  def contains?(equipment)
    equipment.exists? equipment
  end

  def pickup_er_hour
    verify_containing_semester_present

    semester = Semester.around_date(starts_at).first
    er_hour = semester.er_hour_on_day(starts_at)

    unless er_hour
      raise ErHourMissingError,
        "no ER hour present on #{I18n.localize(starts_at, format: :dmy)}"
    end

    er_hour
  end
end
