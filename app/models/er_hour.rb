class ErHour < ActiveRecord::Base
  attr_accessible :day, :ends_at, :starts_at, :semester_id, :associated_hour_id

  has_one :associated_hour, class_name: "ErHour"
  belongs_to :associated_hour, class_name: "ErHour"
  belongs_to :semester

  validates_presence_of :day, :starts_at, :ends_at, :semester_id
  validates_uniqueness_of :associated_hour_id, allow_blank: true, message: "has already been associated"

  scope :live, joins(:semester).where("er_hours.ends_at >= ? AND semesters.ends_at >= ?", Time.now, Time.now)
  scope :available_for_association, lambda { |for_hour|
    joins(:semester)
    where("semesters.id = ?")
    where("er_hours.associated_hour_id IS NULL", for_hour.id)
    where("er_hours.id != ?", for_hour.id) if for_hour.persisted?
  }

  default_scope order(:day)

  def day
    read_attribute(:day).strftime("%a").downcase
  end

  # This can deal with a String or Date
  def day=(value)
    write_attribute(:day, Date.parse(value)) if value.is_a? String
    write_attribute(:day, value) if value.is_a? Date

    false
  end

  def weekday_with_range
    "#{day.capitalize} #{starts_at.strftime "%l:%M%P"} - #{ends_at.strftime "%l:%M%P"}"
  end

  private

  def self.associated_pairs(semester)
    pairs = []
    set = ErHour.where(semester_id: semester.id).order(:starts_at).all
    set.each do |er_hour|
      if er_hour.associated_hour.present?
        pairs << [er_hour, er_hour.associated_hour].sort_by! { |o| Date.parse(o.day).wday }
      else
        pairs << er_hour
      end

      # Remove the associated hour from the set
      set.delete er_hour.associated_hour
    end

    pairs
  end
end
