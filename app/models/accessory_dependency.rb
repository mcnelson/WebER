class AccessoryDependency < ActiveRecord::Base
  validates_presence_of :accessory_category

  belongs_to :equipment
  belongs_to :accessory_category

  def optional?
    optional
  end
end
