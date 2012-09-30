class Package < ActiveRecord::Base
  attr_accessible :max_reservation_period, :title

  belongs_to :user

  has_many :equipment_packages
  has_many :equipment, through: :equipment_packages, dependent: :restrict
end
