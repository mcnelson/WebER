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

  # TODO split into inclusive/exclusive
  def available_in_range?(start_at, end_at)
    reservation = Reservation.find_by_range(start_at, end_at)

    # If equipment exists in overlapping reservation, return false
    return !reservation.equipment.exists?(self) if reservation.present?

    # Otherwise assume available
    true
  end

  def available_in_range_exclusive(start_at, end_at)
    (
    Reservation
      .select(nil)
      .new(starts_at: start_at, ends_at: end_at)
      .others_overlapping
      .joins(equipment_bases_reservations: :equipment_bases)
      .where(equipment_bases_reservations: { equipment_bases: { equipment_id: self.id } })
    )
  end
end
