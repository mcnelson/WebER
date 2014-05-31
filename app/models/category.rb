class Category < ActiveRecord::Base
  validates_presence_of :title

  has_many :units

  def humanize_type
    type.underscore.humanize.titlecase
  end
end
