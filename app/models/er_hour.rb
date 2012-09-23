class ErHour < ActiveRecord::Base
  attr_accessible :day, :ends_at, :starts_at, :semester_id, :er_hour_id

  has_one :associated_hour, class_name: "ErHour"
  belongs_to :associated_hour, class_name: "ErHour"
  belongs_to :semester

  validates_presence_of :day, :starts_at, :ends_at, :semester_id
  validates_uniqueness_of :er_hour_id

  def description
    "#{day.capitalize} #{starts_at.strftime "%l:%M%P"} - #{ends_at.strftime "%l:%M%P"}"
  end
end
