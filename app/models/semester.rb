class Semester < ActiveRecord::Base
  has_many :er_hour

  attr_accessible :ends_at, :starts_at
  validates_presence_of :ends_at, :starts_at
end
