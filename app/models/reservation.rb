class Reservation < ActiveRecord::Base
  attr_accessible :ends_at, :starts_at, :status, :user_id, :punet_autocomplete
  attr_accessor :punet_autocomplete

  validates_presence_of :ends_at, :starts_at, :status, :user_id

  belongs_to :user

  has_many :equipment_reservations
  has_many :equipment, through: :equipment_reservations, dependent: :restrict

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
