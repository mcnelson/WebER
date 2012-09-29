class Reservation < ActiveRecord::Base
  attr_accessible :ends_at, :starts_at, :status

  belongs_to :user
end
