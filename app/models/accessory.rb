class Accessory < ActiveRecord::Base
  attr_protected :name

  belongs_to :accessory_category

  def name
    accessory_category.title
  end
end
