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
    "#{year.to_s} #{term} (#{starts_at.strftime "%b %e"} - #{ends_at.strftime "%b %e"})"
  end

  def er_hour_around(date)
    er_hours.select { |erh| erh.day.wday == date.wday } || nil
  end

  # Find an er hour given a date. If no er hour on the given date, goes forward
  # to find the next hour. I.e. given a Friday, iterates to Monday and returns that
  def next_er_hour(date)
    idate = date
    er_hour = nil
    begin
      idate = idate.tomorrow
      er_hour = er_hour_around(idate.wday)

    end while er_hour.nil? && idate < ends_at

    er_hour
  end

  # Get the ER hour's start time given a Date
  def to_er_hour_start(date)
    er_hour_around(date).try(:starts_at)
  end

  # Get the ER hour's end time given a Date
  def to_er_hour_end(date)
    er_hour_around(date).try(:ends_at)
  end
end
