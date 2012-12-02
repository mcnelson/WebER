class Category < ActiveRecord::Base
  attr_accessible :title
  validates_presence_of :title

  def humanize_type
    type.underscore.humanize.titlecase
  end
end
