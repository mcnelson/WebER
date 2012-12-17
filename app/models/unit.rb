class Unit < ActiveRecord::Base
  attr_accessible :active, :brand, :max_reservation_period, :model, :serial, :status, :category_id, :photo, :notes
  validates_presence_of :active, :status, :category_id

  belongs_to :category

  has_many :reserved_units
  has_many :reservations, through: :reserved_units

  has_and_belongs_to_many :packages

  has_attached_file :photo,
    styles: {
      thirtytwo: ["32x32#", :jpg],
      forty: ["40x40#", :jpg],
      twosixty: ["260x180#", :jpg],
      threehundred: ["300x200#", :jpg],
      seventwenty: ["720x450>", :jpg],
      tentwentyfour: ["1024x768>", :jpg]
    },

    convert_options: {
      thumb: "-quality 75 -strip"
    },

    default_style: :thirtytwo,
    default_url: "/assets/noimage.jpg"

  STATUSES = [
    "available",
    "in use",
    "damaged",
    "overdue"
  ]

  scope :active, where(active: true)

  after_initialize :default_status

  def default_status
    self.status ||= STATUSES.first
  end

  def name_brand_model
    if brand.present? && model.present?
      "#{name}: #{brand} #{model}"
    elsif brand.present?
      "#{brand} #{name}"
    else
      name
    end
  end

  # Find all reservations sharing this unit that overlap using ER hours as
  # between points. Exclusive -- assumes a unit can be checked in & out in the
  # same hour
  def in_reservations_in_range_exclusive(start_at, end_at)
    semester = Semester.around_date(start_at).first

    lower = semester.to_er_hour_end(start_at) \
      or semester.next_er_hour(start_at).try(:ends_at)

    upper = semester.to_er_hour_start(end_at) \
      or semester.next_er_hour(end_at).try(:starts_at)

    Reservation.
      between(lower, upper).
      joins(:reserved_units).where(reserved_units: { unit_id: self.id })
  end
  # TODO: Write an inclusive version of above (needed, right? ... I think)

  def earliest_available_date
    Semester.current.er_hour_around(
      Reservation.containing_unit(self).order("ends_at DESC")
    )
  end

  def suggested_available_date

  end
end
