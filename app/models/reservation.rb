class Reservation < ActiveRecord::Base
  attr_accessible :ends_at, :starts_at, :status, :user_id, :equipment_autocomplete, :equipment_attributes
  attr_accessor :equipment_autocomplete

  validates_presence_of :ends_at, :starts_at, :status, :user_id

  validates_associated :user
  belongs_to :user

  has_many :equipment_reservations
  has_many :equipment, through: :equipment_reservations, dependent: :restrict

  accepts_nested_attributes_for :equipment

  STATUSES = [
    "live",
    "pending",
    "archived",
    "missed"
  ]

  def self.formatted_statuses
    STATUSES.map { |s| s.capitalize }
  end
end
