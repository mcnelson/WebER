class Semester < ActiveRecord::Base
  has_many :er_hour

  attr_accessible :ends_at, :starts_at
  validates_presence_of :ends_at, :starts_at

  scope :live, where("ends_at >= ?", Time.now)
  scope :for_date, lambda { |date|
    where("semesters.starts_at < ?", date)
      .where("semesters.ends_at > ?", date)
      .joins(:er_hour)
  }

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
end
