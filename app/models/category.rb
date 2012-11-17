class Category < ActiveRecord::Base
  attr_accessible :title
  validates_presence_of :title

  def grouped_select_options
    [ "Test" => ::AccessoryCategory.all ]
  end

  def pretty_type_label
    type.underscore.humanize.titlecase
  end
end
