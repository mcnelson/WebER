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

  # Find all reservations sharing this unit that overlap using ER hours as between points.
  # Exclusive -- assumes a unit can be checked in & out in the same hour
  def in_reservations_in_range_exclusive(start_at, end_at)
    semester = Semester.around_date(start_at)
    erh_lower_end_at = semester.to_er_hour_end(start_at)
    erh_upper_start_at = semester.to_er_hour_start(end_at)

    return nil if erh_lower_end_at.nil? || erh_upper_start_at.nil?

    Reservation.
      between(erh_lower_end_at, erh_upper_start_at).
      joins(:reserved_units).where(reserved_units: { unit_id: self.id })
  end

  # TODO: Write an inclusive version of above (needed, right? ... I think)

  def earliest_available_date
    # TODO: This will be a fun one
    #in_reservations_in_range_exclusive(start_at, end_at)
  end

  def suggested_available_date

  end
end
