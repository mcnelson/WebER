class Semester < ActiveRecord::Base
  has_many :er_hours, class_name: "ErHour"

  validates_presence_of :ends_at, :starts_at

  scope :live, where("ends_at >= ?", Time.now)
  scope :around_date, lambda { |date| where("? BETWEEN starts_at AND ends_at", date) }

  TERM_SPLIT_MONTH = 6

  def term
    starts_at.month.in?(TERM_SPLIT_MONTH .. 12) ? "Fall" : "Spring" if starts_at
  end

  def year
    starts_at.year if starts_at
  end

  def yearterm
    "#{year.to_s} #{term}"
  end

  def yearterm_with_range
    "#{year.to_s} #{term} (#{I18n.localize(starts_at, format: :monthday)} - #{I18n.localize(ends_at, format: :monthday)})"
  end

  def er_hour_on_day(date)
    er_hours.select { |erh| erh.wday == date.wday } .first || nil
  end

  # Find the ER Hour on the given day and get the ER hour's start time
  def to_er_hour_start(date)
    erh_time = er_hour_on_day(date).try(:starts_at) or return nil
    DateTime.new(date.year, date.month, date.day, erh_time.hour, erh_time.mday, erh_time.sec).in_time_zone
  end

  # Find the ER Hour on the given day and get the ER hour's end time
  def to_er_hour_end(date)
    erh_time = er_hour_on_day(date).try(:ends_at) or return nil
    DateTime.new(date.year, date.month, date.day, erh_time.hour, erh_time.mday, erh_time.sec).in_time_zone
  end

  def self.current
    Semester.around_date(Date.today).first
  end
end
