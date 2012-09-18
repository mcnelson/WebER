class Semester < ActiveRecord::Base
  has_many :er_hour

  attr_accessible :ends_at, :starts_at
  accepts_nested_attributes_for :er_hour

  validates_presence_of :ends_at, :starts_at

end
