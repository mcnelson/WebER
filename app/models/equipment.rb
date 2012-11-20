class Equipment < ActiveRecord::Base
  attr_accessible :active, :brand, :max_reservation_period, :model, :name, :serial, :status, :category_id, :photo, :notes, :accessory, :accessory_dependencies_attributes
  validates_presence_of :active, :status, :name, :category_id

  belongs_to :category
  validates :category, inclusion: { in: EquipmentCategory.all, message: "must be an equipment category since this unit is classified as equipment" }, if: "!accessory?"
  validates :category, inclusion: { in: AccessoryCategory.all, message: "must be an accessory category since this unit is classified as an accessory" }, if: :accessory?

  has_many :equipment_reservations
  has_many :reservation, through: :equipment_reservations

  has_many :equipment_packages
  has_many :package, through: :equipment_packages

  has_many :accessory_dependencies, dependent: :destroy
  has_many :accessories, through: :accessory_dependencies
  validates_length_of :accessory_dependencies, is: 0, if: :accessory?, message: "cannot exist for an accessory, they can only be used with equipment" # UGLY! Needs validates_absence_of
  accepts_nested_attributes_for :accessory_dependencies, allow_destroy: true

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
  scope :accessories, where(accessory: true)
  scope :equipment, where(accessory: false)

  def name_brand_model
    "#{name}: #{brand} #{model}"
  end

  def status
    read_attribute(:status) || STATUSES.first
  end

  def accessory?
    accessory
  end

  def available_in_range?(start_at, end_at)
    reservation = Reservation.find_by_range(start_at, end_at)

    # If equipment exists in overlapping reservation, return false
    return !reservation.equipment.exists?(self) if reservation.present?

    # Otherwise assume available
    true
  end

  def self.grouped_equipment_select_options
    result = {}
    EquipmentCategory.all.map { |category| result[category.equipment.all] = category.title }

    result
  end

  def self.grouped_accessory_select_options
    result = {}
    AccessoryCategory.all.map { |category| result[category.equipment.all] = category.title }

    result
  end

  def self.formatted_statuses
    self::STATUSES.map { |s| s.capitalize }
  end

  def self.formatted_statuses_for_select
    self::STATUSES.map { |s| [s.capitalize, s] }
  end
end
