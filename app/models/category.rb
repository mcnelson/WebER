class Category < ActiveRecord::Base
  attr_accessible :title
  validates_presence_of :title
end
