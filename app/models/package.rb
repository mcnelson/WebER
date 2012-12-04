class Package < ActiveRecord::Base
  attr_accessible :max_reservation_period, :title

  belongs_to :user

  has_and_belongs_to_many :units
end
