class Category < ActiveRecord::Base
  attr_accessible :title
  validates_presence_of :title

  def humanize_type
    type.underscore.humanize.titlecase
  end

  def self.grouped_select_options
    {
      ::EquipmentCategory.all => "Equipment Categories",
      ::AccessoryCategory.all => "Accessory Categories"
    }
  end
end
