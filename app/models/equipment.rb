class Equipment < ActiveRecord::Base
  attr_accessible :active, :brand, :max_reservation_period, :model, :name, :serial, :status, :category_id, :photo
  validates_presence_of :active, :status, :name, :category_id

  belongs_to :category

  has_many :equipment_reservations
  has_many :reservation, through: :equipment_reservations

  has_many :equipment_packages
  has_many :package, through: :equipment_packages

  has_attached_file :photo,
    styles: {
      forty: ["40x40#", :jpg],
      twosixty: ["260x180#", :jpg],
      threehundred: ["300x200#", :jpg],
      tentwentyfour: ["1024x768>", :jpg]
    },
    convert_options: {
      thumb: "-quality 75 -strip"
    }

  STATUSES = [
    "available",
    "in use",
    "damaged",
    "overdue"
  ]

  def self.formatted_statuses
    self::STATUSES.map { |s| s.capitalize }
  end

  def self.formatted_statuses_for_select
    self::STATUSES.map { |s| [s.capitalize, s] }
  end

  def pretty_name
    "#{name}: #{brand} #{model}"
  end
end
