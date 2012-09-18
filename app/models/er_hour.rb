class ErHour < ActiveRecord::Base
  attr_accessible :day, :ends_at, :starts_at

  has_one :associated_hour, class_name: "ErHour"
  belongs_to :associated_hour, class_name: "ErHour"
  belongs_to :semester
end
