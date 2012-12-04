class Category < ActiveRecord::Base
  attr_accessible :title
  validates_presence_of :title

  has_many :units

  def humanize_type
    type.underscore.humanize.titlecase
  end
end
