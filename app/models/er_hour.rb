class ErHour < ActiveRecord::Base
  include ErHoursHelper

  validates_presence_of :wday, :starts_at, :ends_at, :semester_id
  validate :once_per_weekday_per_semester

  belongs_to :checkin_hour, class_name: "ErHour"
  belongs_to :semester

  scope :in_semester, lambda { |semester|
    joins(:semester)
    where(semester_id: semester.id)
  }

  scope :live, joins(:semester).where("er_hours.ends_at >= ? AND semesters.ends_at >= ?", Time.now, Time.now)

  def once_per_weekday_per_semester
    if semester && semester.er_hours.select { |h| h != self && h.wday == self.wday } .present?
      errors[:wday] << "is already present in the semester. There can only be one ER hour per weekday in a semester."
    end
  end

  def wday_name
    Date::DAYNAMES[wday][0...3]
  end

  def weekday_with_range
    "#{wday_name} #{I18n.localize(starts_at, format: :ampm)} - #{I18n.localize(ends_at, format: :ampm)}"
  end
end
