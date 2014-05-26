class Semester < ActiveRecord::Base
  has_many :er_hours, class_name: "ErHour"

  attr_accessible :ends_at, :starts_at
  validates_presence_of :ends_at, :starts_at

  scope :live, where("ends_at >= ?", Time.now)
  scope :around_date, lambda { |date| where("? BETWEEN starts_at AND ends_at", date) }

  TERM_SPLIT_MONTH = 6

  def term
    starts_at.month.in?(TERM_SPLIT_MONTH .. 12) ? "Fall" : "Spring"
  end

  def year
    starts_at.year
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

  # Find an er hour given a date. If no er hour on the given date, goes forward
  # to find the next hour. I.e. given a Friday, iterates to Monday and returns that
  def next_er_hour(date)
    idate = date.clone
    er_hour = nil

    while (er_hour = er_hour_on_day(idate)) == nil && idate < ends_at
      idate = idate.tomorrow
    end

    ErHour::SpecificErHour.new(er_hour, idate) unless er_hour.nil?
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
