class ErHour < ActiveRecord::Base
  attr_accessible :day, :ends_at, :starts_at, :semester_id, :associated_hour_id

  has_one :associated_hour, class_name: "ErHour"
  belongs_to :associated_hour, class_name: "ErHour"
  belongs_to :semester

  validates_presence_of :day, :starts_at, :ends_at, :semester_id
  validate :once_per_weekday_per_semester
  validates_uniqueness_of :associated_hour_id, allow_blank: true, message: "has already been associated"

  scope :in_semester, lambda { |semester|
    joins(:semester)
    where(semester_id: semester.id)
  }

  scope :live, joins(:semester).where("er_hours.ends_at >= ? AND semesters.ends_at >= ?", Time.now, Time.now)

  default_scope order(:day)

  def once_per_weekday_per_semester
    if semester.er_hours.select { |er_hour| er_hour.day.wday == self.day.wday } .any?
      errors[:day] << "is already present in the semester. There can only be one ER hour per day in a semester."
    end
  end

  def day_abbreviated
    read_attribute(:day).strftime("%a").downcase
  end

  # This can deal with a String or Date
  def day_abbreviated=(value)
    write_attribute(:day, Date.parse(value)) if value.is_a? String
    write_attribute(:day, value) if value.is_a? Date

    false
  end

  def weekday_with_range
    "#{day_abbreviated.capitalize} #{starts_at.strftime "%l:%M%P"} - #{ends_at.strftime "%l:%M%P"}"
  end

  def find_associated_hour
    return associated_hour if associated_hour.present?
    ErHour.find_by_associated_hour_id(id)
  end

  def available_for_association
   other_hours_in_semester.reject { |er_hour| er_hour.find_associated_hour.present? && er_hour != self.associated_hour }
  end

  def other_hours_in_semester
    semester.er_hours.where("id != ?", id)
  end

  private

  def self.associated_pairs(semester)
    pairs = []
    set = ErHour.in_semester(semester).all # By default this is ordered by day ascending

    # For each ER hour in the set, build a 2-element array consisting of the checkout hour
    # on the left and check in hour on the right, and add it to set
    while set.size > 0
      left = set.first
      right = left.find_associated_hour

      if right.present?
        pairs << [left, right].sort_by! { |o| o.day.wday } # Sort by weekday number
        set.delete right
      else
        pairs << left
      end

      set.delete left
    end

    pairs
  end
end
