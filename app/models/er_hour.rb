class ErHour < ActiveRecord::Base
  attr_accessible :day, :ends_at, :starts_at, :semester_id, :associated_hour_id

  has_one :associated_hour, class_name: "ErHour"
  belongs_to :associated_hour, class_name: "ErHour"
  belongs_to :semester

  validates_presence_of :day, :starts_at, :ends_at, :semester_id
  validates_uniqueness_of :associated_hour_id

  scope :live, joins(:semester).where("er_hours.ends_at >= ? AND semesters.ends_at >= ?", Time.now, Time.now)
  scope :live_excluding, lambda { |exclude_id| joins(:semester).where("er_hours.ends_at >= ? AND semesters.ends_at >= ? AND er_hours.id != ?", Time.now, Time.now, exclude_id) }

  def description
    "#{day.capitalize} #{starts_at.strftime "%l:%M%P"} - #{ends_at.strftime "%l:%M%P"}"
  end
end
