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

  def max_reservation_period
    read_attribute(:max_reservation_period) || Weber::Application.config.default_max_reservation_period
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

  # Find all reservations sharing this unit that overlap the date range given
  def in_reservations_in_range_exclusive(lower, upper)
    Reservation.
      overlapping(lower, upper).
      joins(:reserved_units).where(reserved_units: { unit_id: self.id })
  end
  # TODO: Write an inclusive version of above (needed, right? ... I think)

  def earliest_available_date
    range = [
      Date.today,
      (Date.today + Weber::Application.config.default_max_reservation_period)
    ]

    begin
      reservation = in_reservations_in_range_exclusive(range[0], range[1])
        order("ends_at DESC").
        limit(1).
        first

      if reservation.present?
        if range[0] == reservation.ends_at # Should never happen
          raise "Equipment#in_reservations_in_range_exclusive returned out-of-range reservation"
        end

        range[0] = reservation.ends_at
        range[1] = (reservation.ends_at + Weber::Application.config.default_max_reservation_period)
      end
    end while reservation.present?
  end

  def suggested_available_date

  end
end
